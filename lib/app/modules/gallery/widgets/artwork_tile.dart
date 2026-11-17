import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:material_ui/material_ui.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../data/models/artwork.dart';
import '../../../strings.dart';
import 'artwork_detail.dart';
import 'favourite_button.dart';
import '../../../widgets/app_skeleton.dart';
import '../gallery_helper.dart';

/// Corner radius of a mat, and the space between its edge and the work.
const double kMatRadius = 8.0;
const double kMatPadding = 12.0;

/// One work in the grid: a square mat with the whole image inside it, and
/// a two-part caption underneath.
///
/// The caption sits under the mat, not over the image, because the image
/// is an HTML element and painting over one is expensive. Height comes
/// from the grid (`artworkTileExtent`), so the caption has fixed line
/// counts.
class ArtworkTile extends HookWidget {
  final Artwork artwork;
  final VoidCallback onOpen;

  const ArtworkTile({super.key, required this.artwork, required this.onOpen});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final focused = useState(false);

    final tile = Material(
      type: MaterialType.transparency,
      child: InkWell(
        onTap: onOpen,
        onFocusChange: (value) => focused.value = value,
        borderRadius: BorderRadius.circular(kMatRadius),
        child: _TileLayout(
          // Ink, not a DecoratedBox, so that the hover and press tints land
          // on top of the mat's colour.
          mat: Ink(
            key: Key('artwork_mat_${artwork.id}'),
            decoration: BoxDecoration(
              color: scheme.surfaceContainer,
              borderRadius: BorderRadius.circular(kMatRadius),
              // Focus draws a ring. It is always there and transparent when
              // idle, so focusing never shifts the image.
              border: Border.all(
                color: focused.value
                    ? scheme.primary
                    : scheme.primary.withValues(alpha: 0.0),
                width: 2.0,
              ),
            ),
            padding: const EdgeInsets.all(kMatPadding),
            // The picture flies from here into the detail and back.
            child: ArtworkHero(artwork: artwork, staysInGrid: true),
          ),
          title: Strings.titleOf(artwork),
          byline: artwork.byline,
        ),
      ),
    );

    // The heart is laid over the tile, beside the caption: below the mat,
    // never over the picture.
    return LayoutBuilder(
      builder: (context, constraints) => Stack(
        fit: StackFit.expand,
        children: [
          tile,
          Positioned(
            right: 0.0,
            // The mat is a square as wide as the tile; this is level with
            // the caption's first line.
            top: constraints.maxWidth + kCaptionGap - 6.0,
            child: FavouriteButton(artwork: artwork),
          ),
        ],
      ),
    );
  }
}

/// The shape every tile has: a square [mat], then the caption's two
/// parts. Shared by the tile and its skeleton.
class _TileLayout extends StatelessWidget {
  final Widget mat;
  final String title;
  final String byline;

  const _TileLayout({
    required this.mat,
    required this.title,
    required this.byline,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(aspectRatio: 1.0, child: mat),
        const SizedBox(height: kCaptionGap),
        // The caption stops short of the right edge, where the heart is.
        Padding(
          padding: const EdgeInsets.only(right: kFavouriteButtonSize),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: kCaptionTitleLines,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall,
              ),
              Text(
                byline,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// A tile that has not arrived yet: the tile's own layout, drawn as a
/// skeleton, so nothing moves when the works land.
class ArtworkTileSkeleton extends StatelessWidget {
  const ArtworkTileSkeleton({super.key});

  // Never read: they only decide how long the skeleton's bars are.
  static const String _title = 'Seaside Village in Winter';
  static const String _byline = 'Katsushika Hokusai · 1814';

  @override
  Widget build(BuildContext context) {
    return const AppSkeleton(
      child: _TileLayout(
        mat: Bone(
          width: double.infinity,
          height: double.infinity,
          borderRadius: BorderRadius.all(Radius.circular(kMatRadius)),
        ),
        title: _title,
        byline: _byline,
      ),
    );
  }
}
