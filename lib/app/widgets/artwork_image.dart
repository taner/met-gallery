import 'package:material_ui/material_ui.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../strings.dart';
import 'app_skeleton.dart';

/// A museum image, shown whole, with a placeholder while it loads and a
/// quiet fallback if it does not.
///
/// On the web it is an `<img>` element ([WebHtmlElementStrategy]), because
/// `images.metmuseum.org` sends no CORS headers and Flutter cannot fetch
/// the bytes itself. `prefer`, not `fallback`, so that no fetch is tried
/// first.
///
/// The cost: opacity and filters are ignored, so there is no fade-in, and
/// Flutter cannot paint cheaply over the image, so captions sit under it.
/// Other platforms ignore the strategy and fetch the bytes as usual.
class ArtworkImage extends StatelessWidget {
  final String url;

  /// For a thumbnail: the fallback is the icon alone.
  final bool compact;

  const ArtworkImage({super.key, required this.url, this.compact = false});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      url,
      // Contain, never cover: a work is never cropped.
      fit: BoxFit.contain,
      webHtmlElementStrategy: WebHtmlElementStrategy.prefer,
      frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
        if (frame != null || wasSynchronouslyLoaded) return child;
        return const AppSkeleton(
          child: Bone(
            width: double.infinity,
            height: double.infinity,
            borderRadius: BorderRadius.zero,
          ),
        );
      },
      // A broken image shows a fallback in its own tile.
      errorBuilder: (context, error, stackTrace) =>
          _Unavailable(compact: compact),
    );
  }
}

class _Unavailable extends StatelessWidget {
  final bool compact;

  const _Unavailable({required this.compact});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colour = theme.colorScheme.onSurfaceVariant;

    if (compact) {
      return Center(
        child: Icon(Icons.hide_image_outlined, size: 20.0, color: colour),
      );
    }

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.hide_image_outlined, size: 24.0, color: colour),
          const SizedBox(height: 8.0),
          Text(
            Strings.imageUnavailable,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(color: colour),
          ),
        ],
      ),
    );
  }
}
