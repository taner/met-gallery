import 'dart:async';
import 'dart:ui' show PointerDeviceKind;

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_ui/material_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/models/artwork.dart';
import '../../../strings.dart';
import '../../../widgets/artwork_image.dart';
import 'favourite_button.dart';

/// Below this width the detail takes the whole screen.
const double _kCompactWidth = 600.0;

/// How long the detail takes to open and to close.
const Duration kDetailTransition = Duration(milliseconds: 320);

/// The [Hero] tag shared by a tile's picture and the same picture in the
/// detail.
Object artworkHeroTag(Artwork artwork) => 'artwork-image-${artwork.id}';

/// The picture of [artwork], as one end of the flight between a tile and
/// the detail.
///
/// Each copy of the picture is a new `<img>` element, which the browser
/// takes a few frames to paint. To avoid a blink, the tile keeps its
/// picture during a flight ([staysInGrid]), and the detail's picture
/// carries a [GlobalKey] so that it is moved, not rebuilt.
class ArtworkHero extends HookWidget {
  final Artwork artwork;

  /// True for the tile in the grid, false for the detail.
  final bool staysInGrid;

  /// Which of the work's pictures to show; the tile's own when null.
  final String? url;

  const ArtworkHero({
    super.key,
    required this.artwork,
    this.staysInGrid = false,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    // Lets the picture be moved between the detail and the overlay without
    // being rebuilt.
    final picture = useMemoized(GlobalKey.new);

    return Hero(
      tag: artworkHeroTag(artwork),
      // A straight line; the default is an arc.
      createRectTween: (begin, end) => RectTween(begin: begin, end: end),
      placeholderBuilder: staysInGrid ? (context, size, child) => child : null,
      flightShuttleBuilder: _detailPictureFlies,
      child: KeyedSubtree(
        key: picture,
        child: ArtworkImage(url: url ?? artwork.imageUrl),
      ),
    );
  }

  /// The detail is where a flight is going when it opens and where it
  /// comes from when it closes.
  static Widget _detailPictureFlies(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection direction,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    final detail = direction == HeroFlightDirection.push
        ? toHeroContext
        : fromHeroContext;
    return (detail.widget as Hero).child;
  }
}

/// Opens one work for a closer look.
///
/// A page route dressed as a dialog, because Flutter only flies a [Hero]
/// between page routes and `showDialog` pushes a popup route.
///
/// Completes when the detail has finished closing, with the subject the
/// reader chose to search for, or null. A new search must wait for that, or
/// the tile would go while the picture was still flying back to it.
Future<String?> showArtworkDetail(BuildContext context, Artwork artwork) {
  final duration = MediaQuery.disableAnimationsOf(context)
      ? Duration.zero
      : kDetailTransition;

  final route = PageRouteBuilder<String>(
    opaque: false,
    fullscreenDialog: true,
    barrierDismissible: true,
    barrierColor: Colors.black54,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    transitionDuration: duration,
    reverseTransitionDuration: duration,
    pageBuilder: (context, _, _) => ArtworkDetail(artwork: artwork),
    // The panel fades in around the picture while the picture travels.
    transitionsBuilder: (context, animation, _, child) => FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
      child: child,
    ),
  );

  unawaited(Navigator.of(context, rootNavigator: true).push(route));
  return route.completed;
}

/// One work, closer up: its picture, any other views of it to flip
/// through, and its label.
///
/// Pops with a subject keyword when the reader chooses one to search for.
class ArtworkDetail extends HookWidget {
  final Artwork artwork;

  const ArtworkDetail({super.key, required this.artwork});

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < _kCompactWidth;

    // Which of the work's pictures is showing. It opens on the tile's, which
    // the browser already has.
    final views = artwork.imageUrls;
    final showing = useState(0);

    final image = Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ArtworkHero(artwork: artwork, url: views[showing.value]),
          ),
        ),
        if (views.length > 1)
          _OtherViews(
            urls: views,
            showing: showing.value,
            onShow: (index) => showing.value = index,
          ),
      ],
    );
    final label = _Label(artwork: artwork);

    if (compact) {
      return Dialog.fullscreen(
        child: SafeArea(
          child: Column(
            children: [
              const Align(alignment: Alignment.centerRight, child: _Close()),
              Expanded(flex: 3, child: image),
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  // Same 16 as the image above it, so the label starts on
                  // the picture's left edge.
                  padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 24.0),
                  child: label,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Dialog(
      clipBehavior: Clip.antiAlias,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 920.0, maxHeight: 620.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ColoredBox(
                color: Theme.of(context).colorScheme.surfaceContainer,
                child: image,
              ),
            ),
            SizedBox(
              width: 320.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Align(
                    alignment: Alignment.centerRight,
                    child: _Close(),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
                      child: label,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The work's details, set the way a wall label is: maker first, title in
/// italics, then date, medium and department. A line the record lacks is
/// left out.
class _Label extends StatelessWidget {
  final Artwork artwork;

  const _Label({required this.artwork});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = theme.textTheme;
    final muted = theme.colorScheme.onSurfaceVariant;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (artwork.artist.isNotEmpty) ...[
          Text(artwork.artist, style: text.titleMedium),
          const SizedBox(height: 4.0),
        ],
        Text(
          Strings.titleOf(artwork),
          style: text.headlineSmall?.copyWith(fontStyle: FontStyle.italic),
        ),
        if (artwork.date.isNotEmpty) ...[
          const SizedBox(height: 8.0),
          Text(artwork.date, style: text.bodyLarge),
        ],
        if (artwork.medium.isNotEmpty) ...[
          const SizedBox(height: 8.0),
          Text(artwork.medium, style: text.bodyMedium?.copyWith(color: muted)),
        ],
        if (artwork.department.isNotEmpty) ...[
          const SizedBox(height: 8.0),
          Text(
            artwork.department,
            style: text.labelMedium?.copyWith(color: muted),
          ),
        ],
        if (artwork.tags.isNotEmpty) ...[
          const SizedBox(height: 16.0),
          // Each subject is a search: choosing one closes the detail with it.
          Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children: [
              for (final subject in artwork.tags)
                ActionChip(
                  label: Text(subject),
                  tooltip: Strings.searchFor(subject),
                  onPressed: () => Navigator.of(context).pop(subject),
                ),
            ],
          ),
        ],
        const SizedBox(height: 24.0),
        FilledButton.tonalIcon(
          onPressed: () => launchUrl(
            Uri.parse(artwork.pageUrl),
            webOnlyWindowName: '_blank',
          ),
          style: FilledButton.styleFrom(minimumSize: const Size(64.0, 48.0)),
          icon: const Icon(Icons.open_in_new, size: 18.0),
          label: const Text(Strings.viewOnMuseumSite),
        ),
        const SizedBox(height: 8.0),
        FavouriteLabelledButton(artwork: artwork),
      ],
    );
  }
}

/// The side of a thumbnail in [_OtherViews].
const double _kThumbSize = 56.0;

/// The work's pictures as a row of thumbnails under the main one, the one
/// that is showing marked. Only there when a work has more than one.
class _OtherViews extends StatelessWidget {
  final List<String> urls;
  final int showing;
  final ValueChanged<int> onShow;

  const _OtherViews({
    required this.urls,
    required this.showing,
    required this.onShow,
  });

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: _kThumbSize + 16.0,
      // Mouse drag is not a scroll gesture by default on the web.
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context)
            .copyWith(dragDevices: PointerDeviceKind.values.toSet()),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
          itemCount: urls.length,
          separatorBuilder: (_, _) => const SizedBox(width: 8.0),
          itemBuilder: (context, index) {
            final isShowing = index == showing;

            return Material(
              type: MaterialType.transparency,
              child: InkWell(
                key: Key('artwork_view_$index'),
                onTap: () => onShow(index),
                borderRadius: BorderRadius.circular(8.0),
                // Ink, so that hover and focus tints show on the frame. The
                // chosen view is marked by the frame's colour.
                child: Ink(
                  width: _kThumbSize,
                  height: _kThumbSize,
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: scheme.surface,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: isShowing ? scheme.primary : scheme.outlineVariant,
                      width: 2.0,
                    ),
                  ),
                  child: ArtworkImage(url: urls[index], compact: true),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Close extends StatelessWidget {
  const _Close();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        // First stop for the keyboard.
        autofocus: true,
        tooltip: Strings.close,
        icon: const Icon(Icons.close),
        onPressed: () => Navigator.of(context).maybePop(),
      ),
    );
  }
}
