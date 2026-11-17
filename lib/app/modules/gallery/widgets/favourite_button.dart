import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';

import '../../../data/models/artwork.dart';
import '../../../strings.dart';
import '../gallery_providers.dart';

/// The side of the heart under a tile, and so the width the caption
/// leaves free for it.
const double kFavouriteButtonSize = 40.0;

/// Whether [artwork] is in the favourites. Watched narrowly, so marking
/// one work rebuilds that work's buttons and not every heart on screen.
bool _watchIsFavourite(WidgetRef ref, Artwork artwork) => ref.watch(
  favouritesProvider.select(
    (favourites) => favourites.any((favourite) => favourite.id == artwork.id),
  ),
);

/// The heart under a tile: adds the work to the favourites, or takes it
/// out again.
class FavouriteButton extends ConsumerWidget {
  final Artwork artwork;

  const FavouriteButton({super.key, required this.artwork});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavourite = _watchIsFavourite(ref, artwork);

    return SizedBox.square(
      dimension: kFavouriteButtonSize,
      child: IconButton(
        key: Key('favourite_${artwork.id}'),
        isSelected: isFavourite,
        // The tooltip names what pressing will do.
        tooltip: isFavourite
            ? Strings.removeFromFavourites
            : Strings.addToFavourites,
        style: IconButton.styleFrom(
          minimumSize: const Size.square(kFavouriteButtonSize),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        icon: const Icon(Icons.favorite_border, size: 20.0),
        selectedIcon: const Icon(Icons.favorite, size: 20.0),
        onPressed: () => ref.read(favouritesProvider.notifier).toggle(artwork),
      ),
    );
  }
}

/// The same choice with its words written out, for the detail view where
/// there is room for them.
class FavouriteLabelledButton extends ConsumerWidget {
  final Artwork artwork;

  const FavouriteLabelledButton({super.key, required this.artwork});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavourite = _watchIsFavourite(ref, artwork);

    return OutlinedButton.icon(
      key: Key('favourite_detail_${artwork.id}'),
      onPressed: () => ref.read(favouritesProvider.notifier).toggle(artwork),
      style: OutlinedButton.styleFrom(minimumSize: const Size(64.0, 48.0)),
      icon: Icon(
        isFavourite ? Icons.favorite : Icons.favorite_border,
        size: 18.0,
      ),
      label: Text(
        isFavourite ? Strings.removeFromFavourites : Strings.addToFavourites,
      ),
    );
  }
}
