import 'package:material_ui/material_ui.dart';

import '../../../data/pagination/paged_artworks.dart';
import '../../../strings.dart';
import '../gallery_helper.dart';
import 'slow_load_note.dart';

/// What sits under the last row of tiles: the way to more of the gallery,
/// the news that a load-more failed, or the end.
class GalleryFooter extends StatelessWidget {
  final PagedArtworks artworks;
  final VoidCallback onMore;
  final VoidCallback onRetry;

  const GalleryFooter({
    super.key,
    required this.artworks,
    required this.onMore,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    final failure = artworks.failure;

    final display = galleryFooterDisplay(
      isLoading: artworks.isLoading,
      hasFailure: failure != null,
      hasMore: artworks.hasMore,
    );

    return Padding(
      // No inset at the sides: the footer sits inside the grid's padding.
      padding: const EdgeInsets.only(top: 24.0, bottom: 32.0),
      child: Column(
        children: [
          switch (display) {
            // The row being fetched is already drawn as skeleton tiles.
            GalleryFooterDisplay.loading => SlowLoadNote(
              loading: artworks.isLoading,
            ),
            GalleryFooterDisplay.failed => Column(
              children: [
                Text(
                  '${Strings.moreFailed} ${Strings.failure(failure!)}',
                  textAlign: TextAlign.center,
                  style: muted,
                ),
                const SizedBox(height: 12.0),
                _FooterButton(label: Strings.retry, onPressed: onRetry),
              ],
            ),
            GalleryFooterDisplay.more => _FooterButton(
              label: Strings.showMore,
              onPressed: onMore,
            ),
            GalleryFooterDisplay.end => const SizedBox.shrink(),
          },
          const SizedBox(height: 24.0),
          Text(
            Strings.attribution,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _FooterButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _FooterButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FilledButton.tonal(
      onPressed: onPressed,
      style: FilledButton.styleFrom(minimumSize: const Size(64.0, 48.0)),
      child: Text(label),
    );
  }
}
