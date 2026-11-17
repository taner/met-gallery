import 'dart:math' as math;

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:material_ui/material_ui.dart';

import '../../../data/models/artwork.dart';
import '../../../data/models/department.dart';
import '../../../data/pagination/paged_artworks.dart';
import '../../../strings.dart';
import '../gallery_helper.dart';
import '../gallery_providers.dart';
import 'artwork_detail.dart';
import 'gallery_footer.dart';
import 'gallery_message.dart';
import 'gallery_search.dart';
import 'slow_load_note.dart';
import 'artwork_tile.dart';

/// The module: search The Met, show the results.
///
/// It takes whatever box its host gives it and brings its own scroll view,
/// states and detail view. The scroll view fills the box, so the scrollbar
/// is at its edge; [maxContentWidth] limits the content inside it.
///
/// The results are an infinite_scroll_pagination grid. What the package is
/// told is decided by pure functions in `gallery_helper.dart`.
class GalleryModule extends HookConsumerWidget {
  /// The widest the content may grow. The scroll view is not limited.
  final double maxContentWidth;

  const GalleryModule({super.key, this.maxContentWidth = double.infinity});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final artworks = ref.watch(galleryArtworksProvider);
    final notifier = ref.read(galleryArtworksProvider.notifier);
    final departments = ref.watch(departmentOptionsProvider);
    final history = ref.watch(searchHistoryProvider);
    final favourites = ref.watch(favouritesProvider);

    // Which of the two the grid is showing: the results of the current
    // search, or the reader's own collection.
    final showingFavourites = useState(false);
    final scrollController = useScrollController();

    // The field opens holding the gallery's query.
    final searchController = useTextEditingController(text: artworks.query);

    // A new search, or the same search in another department, starts from
    // the top.
    ref.listen(
      galleryArtworksProvider.select(
        (artworks) => (artworks.query, artworks.department),
      ),
      (_, _) {
        if (scrollController.hasClients) scrollController.jumpTo(0.0);
      },
    );

    // A search asked for by some other means than the field: the field is
    // brought into line and the search starts at once.
    void searchFor(String query) {
      searchController.text = query;
      notifier.search(query);
    }

    void showDefaultSearch() => searchFor(kDefaultQuery);

    void showFavourites(bool show) {
      showingFavourites.value = show;
      if (scrollController.hasClients) scrollController.jumpTo(0.0);
    }

    // Opens a work. If the reader leaves the detail by choosing one of
    // its subjects, that is the next search.
    Future<void> open(Artwork artwork) async {
      final subject = await showArtworkDetail(context, artwork);
      if (subject == null || !context.mounted) return;

      // Back to the search results, if the collection was showing.
      showFavourites(false);
      searchFor(subject);
    }

    // The one action an empty gallery offers, and what it does.
    final wayOut = emptyGalleryAction(
      hasMore: artworks.hasMore,
      isFiltered: artworks.department != null,
    );
    final (wayOutLabel, onWayOut) = switch (wayOut) {
      EmptyGalleryAction.lookFurther => (
        Strings.lookFurther,
        notifier.loadMore,
      ),
      EmptyGalleryAction.allDepartments => (
        Strings.searchAllDepartments,
        () => notifier.filterByDepartment(null),
      ),
      EmptyGalleryAction.defaultSearch => (
        Strings.backTo(kDefaultQuery),
        showDefaultSearch,
      ),
    };

    return LayoutBuilder(
      builder: (context, constraints) {
        // The width the content is laid out in, and the margin that
        // centres it in whatever is left over.
        final width = math.min(constraints.maxWidth, maxContentWidth);
        final margin = (constraints.maxWidth - width) / 2.0;
        final columns = galleryColumnsFor(width);
        final gap = galleryGapFor(width);
        final gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: columns,
          crossAxisSpacing: gap,
          mainAxisSpacing: gap,
          mainAxisExtent: artworkTileExtent(
            tileWidth: artworkTileWidth(width),
            textScaler: MediaQuery.textScalerOf(context),
          ),
        );

        // Only under a gallery with works in it; during a first load the
        // header carries the "still fetching" note.
        Widget footer(BuildContext context) => artworks.items.isEmpty
            ? const SizedBox.shrink()
            : GalleryFooter(
                artworks: artworks,
                onMore: notifier.loadMore,
                onRetry: notifier.retry,
              );

        return CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: margin),
              sliver: SliverToBoxAdapter(
                child: _Header(
                  artworks: artworks,
                  searchController: searchController,
                  onSearch: notifier.search,
                  departments: departments,
                  onDepartment: notifier.filterByDepartment,
                  onRetryDepartments: ref
                      .read(departmentOptionsProvider.notifier)
                      .retry,
                  history: history,
                  onRemember: ref.read(searchHistoryProvider.notifier).remember,
                  onForget: ref.read(searchHistoryProvider.notifier).forget,
                  favouriteCount: favourites.length,
                  showingFavourites: showingFavourites.value,
                  onShowFavourites: showFavourites,
                ),
              ),
            ),
            // The reader's own collection, in the same grid and tiles. It is
            // all in memory, so there is nothing to page.
            if (showingFavourites.value)
              SliverPadding(
                padding: EdgeInsets.fromLTRB(
                  margin + kGalleryInset,
                  0.0,
                  margin + kGalleryInset,
                  32.0,
                ),
                sliver: favourites.isEmpty
                    ? SliverToBoxAdapter(
                        child: GalleryMessage(
                          icon: Icons.favorite_border,
                          title: Strings.noFavouritesTitle,
                          body: Strings.noFavouritesBody,
                          actionLabel: Strings.backToResults,
                          onAction: () => showFavourites(false),
                        ),
                      )
                    : SliverGrid.builder(
                        gridDelegate: gridDelegate,
                        itemCount: favourites.length,
                        itemBuilder: (context, index) {
                          final artwork = favourites[index];
                          return ArtworkTile(
                            key: ValueKey(artwork.id),
                            artwork: artwork,
                            onOpen: () => open(artwork),
                          );
                        },
                      ),
              )
            else
              // The results. What the package is told is decided in
              // `galleryPagingState`.
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: margin + kGalleryInset,
                ),
                sliver: PagedSliverGrid<int, Artwork?>(
                  state: galleryPagingState(artworks, columns: columns),
                  fetchNextPage: notifier.loadMore,
                  gridDelegate: gridDelegate,
                  // Messages take the space they need under the header
                  // instead of being centred in what is left of the screen.
                  shrinkWrapFirstPageIndicators: true,
                  // What follows the grid is the footer, across the full
                  // width, not one more cell in the last row.
                  showNewPageProgressIndicatorAsGridChild: false,
                  showNewPageErrorIndicatorAsGridChild: false,
                  showNoMoreItemsIndicatorAsGridChild: false,
                  builderDelegate: PagedChildBuilderDelegate<Artwork?>(
                    invisibleItemsThreshold: kContinueWithinItems,
                    itemBuilder: (context, artwork, index) => artwork == null
                        ? const ArtworkTileSkeleton()
                        : ArtworkTile(
                            key: ValueKey(artwork.id),
                            artwork: artwork,
                            onOpen: () => open(artwork),
                          ),
                    // Nothing shown and the load failed.
                    firstPageErrorIndicatorBuilder: (_) => GalleryMessage(
                      icon: Icons.cloud_off_outlined,
                      body: Strings.failure(artworks.failure!),
                      actionLabel: Strings.retry,
                      onAction: notifier.retry,
                    ),
                    // Nothing shown and nothing on its way: no matches, or
                    // matches of which none can be shown.
                    noItemsFoundIndicatorBuilder: (_) => artworks.total == 0
                        ? GalleryMessage(
                            icon: Icons.search_off,
                            title: Strings.noMatchesTitle(artworks),
                            body: Strings.noMatchesBody(artworks),
                            actionLabel: wayOutLabel,
                            onAction: onWayOut,
                          )
                        : GalleryMessage(
                            icon: Icons.hide_image_outlined,
                            title: Strings.nothingShownTitle,
                            body: Strings.nothingShownBody(artworks),
                            actionLabel: wayOutLabel,
                            onAction: onWayOut,
                          ),
                    // One footer for all three of the package's "after the
                    // grid" slots (see `galleryFooterDisplay`).
                    newPageProgressIndicatorBuilder: footer,
                    newPageErrorIndicatorBuilder: footer,
                    noMoreItemsIndicatorBuilder: footer,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  final PagedArtworks artworks;
  final TextEditingController searchController;
  final ValueChanged<String> onSearch;
  final AsyncValue<List<Department>> departments;
  final ValueChanged<Department?> onDepartment;
  final VoidCallback onRetryDepartments;
  final List<String> history;
  final ValueChanged<String> onRemember;
  final ValueChanged<String> onForget;
  final int favouriteCount;
  final bool showingFavourites;
  final ValueChanged<bool> onShowFavourites;

  const _Header({
    required this.artworks,
    required this.searchController,
    required this.onSearch,
    required this.departments,
    required this.onDepartment,
    required this.onRetryDepartments,
    required this.history,
    required this.onRemember,
    required this.onForget,
    required this.favouriteCount,
    required this.showingFavourites,
    required this.onShowFavourites,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
    );
    final status = Strings.status(artworks);

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        kGalleryInset,
        24.0,
        kGalleryInset,
        kGalleryInset,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  Strings.moduleTitle,
                  style: theme.textTheme.headlineMedium,
                ),
              ),
              // Switches the grid between the search results and the
              // collection, and shows how many works are in it.
              FilterChip(
                key: const Key('favourites_toggle'),
                avatar: Icon(
                  showingFavourites ? Icons.favorite : Icons.favorite_border,
                  size: 18.0,
                ),
                label: Text(
                  favouriteCount == 0
                      ? Strings.favourites
                      : '${Strings.favourites} · '
                            '${Strings.count(favouriteCount)}',
                ),
                selected: showingFavourites,
                onSelected: onShowFavourites,
              ),
            ],
          ),
          const SizedBox(height: 4.0),
          Text(Strings.moduleSubtitle, style: muted),
          const SizedBox(height: 16.0),
          // The collection is not a search: while it is showing, the
          // search and everything about it stand aside.
          if (showingFavourites)
            Text(
              favouriteCount == 0
                  ? ''
                  : Strings.favouritesStatus(favouriteCount),
              style: muted,
            )
          else ...[
            GallerySearch(
              controller: searchController,
              onSearch: onSearch,
              departments: departments,
              department: artworks.department,
              onDepartment: onDepartment,
              onRetryDepartments: onRetryDepartments,
              history: history,
              onRemember: onRemember,
              onForget: onForget,
            ),
            const SizedBox(height: 8.0),
            Text(status, style: muted),
            // Only while there are no tiles; with tiles on screen the
            // footer carries this note, down where the loading is.
            if (artworks.items.isEmpty)
              SlowLoadNote(loading: artworks.isLoading),
          ],
        ],
      ),
    );
  }
}
