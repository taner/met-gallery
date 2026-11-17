import 'package:flutter/painting.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../data/models/artwork.dart';
import '../../data/pagination/paged_artworks.dart';

/// The query the gallery opens on. Hokusai, because nearly every match has
/// an open-access image.
const String kDefaultQuery = 'Hokusai';

/// Starting points offered under the search field: queries where most
/// matches have an open-access image.
const List<String> kStartingPoints = [
  kDefaultQuery,
  'Vermeer',
  'Egyptian cat',
  'Armor',
  'Sunflowers',
];

/// Whether [point] is what the search field holds, ignoring case and
/// spacing.
bool isStartingPointChosen(String point, {required String fieldText}) =>
    normaliseQuery(fieldText).toLowerCase() == point.toLowerCase();

/// [favourites] with [artwork] added on top, or removed if it was there.
List<Artwork> toggleFavourite(List<Artwork> favourites, Artwork artwork) {
  final without = [
    for (final favourite in favourites)
      if (favourite.id != artwork.id) favourite,
  ];
  return without.length == favourites.length
      ? [artwork, ...favourites]
      : without;
}

/// How many searches the history keeps.
const int kSearchHistoryLimit = 8;

/// The shortest text that is remembered just because typing paused on it.
const int kRememberedWhileTypingFrom = 3;

/// Whether [typed] should go into the history. Text [submitted] with Enter
/// does at any length; a pause while typing only from
/// [kRememberedWhileTypingFrom] characters.
bool isWorthRemembering(String typed, {required bool submitted}) {
  final length = normaliseQuery(typed).length;
  return submitted ? length > 0 : length >= kRememberedWhileTypingFrom;
}

/// [history] with [raw] remembered: newest first, at most
/// [kSearchHistoryLimit] long, with no duplicates. When the newest entry is
/// the beginning of this one, the reader was still typing it, and this one
/// replaces it.
List<String> rememberSearch(List<String> history, String raw) {
  final query = normaliseQuery(raw);
  if (query.isEmpty) return history;

  final lower = query.toLowerCase();
  final rest = [
    for (final (index, entry) in history.indexed)
      if (entry.toLowerCase() != lower &&
          !(index == 0 && lower.startsWith(entry.toLowerCase())))
        entry,
  ];
  return [query, ...rest.take(kSearchHistoryLimit - 1)];
}

/// [history] without [query].
List<String> forgetSearch(List<String> history, String query) => [
  for (final entry in history)
    if (entry.toLowerCase() != query.toLowerCase()) entry,
];

/// The entries of [history] to offer while the field holds [typed]: all of
/// them for an empty field, otherwise those that contain it. Never the
/// text itself.
List<String> searchSuggestions(List<String> history, String typed) {
  final lower = normaliseQuery(typed).toLowerCase();
  return [
    for (final entry in history)
      if (entry.toLowerCase() != lower && entry.toLowerCase().contains(lower))
        entry,
  ];
}

/// What someone typed, as the query to run: outer space trimmed and inner
/// runs collapsed. An empty query is a real search, for every work with an
/// image.
String normaliseQuery(String raw) => raw.trim().replaceAll(RegExp(r'\s+'), ' ');

/// The [PagingState] that infinite_scroll_pagination is given:
///
///  * `pages` is never null, so the package never starts a load itself.
///  * While a load runs, placeholder cells (null) follow the works: three
///    rows for a first load, [columns] for a load-more.
///  * After a failure, or a page that added nothing, there is no next
///    page, and the button under the grid takes over.
PagingState<int, Artwork?> galleryPagingState(
  PagedArtworks artworks, {
  required int columns,
}) {
  final placeholders = !artworks.isLoading
      ? 0
      : (artworks.items.isEmpty ? columns * 3 : columns);

  return PagingState<int, Artwork?>(
    pages: [
      [...artworks.items, for (var i = 0; i < placeholders; i++) null],
    ],
    keys: const [0],
    hasNextPage:
        artworks.hasMore && !artworks.lastPageEmpty && artworks.failure == null,
    isLoading: artworks.isLoading,
    error: artworks.failure,
  );
}

/// The one action offered when the gallery has nothing in it and was not
/// stopped by a failure.
enum EmptyGalleryAction {
  /// Matches remain that have not been examined.
  lookFurther,

  /// The search is narrowed to a department: widen it.
  allDepartments,

  /// Nothing left to try: back to the default search.
  defaultSearch,
}

EmptyGalleryAction emptyGalleryAction({
  required bool hasMore,
  required bool isFiltered,
}) {
  if (hasMore) return EmptyGalleryAction.lookFurther;
  if (isFiltered) return EmptyGalleryAction.allDepartments;
  return EmptyGalleryAction.defaultSearch;
}

/// What sits under the last row of tiles.
enum GalleryFooterDisplay { loading, failed, more, end }

GalleryFooterDisplay galleryFooterDisplay({
  required bool isLoading,
  required bool hasFailure,
  required bool hasMore,
}) {
  if (isLoading) return GalleryFooterDisplay.loading;
  if (hasFailure) return GalleryFooterDisplay.failed;
  if (hasMore) return GalleryFooterDisplay.more;
  return GalleryFooterDisplay.end;
}

/// How many works before the last one trigger the next page: none, so a
/// page is fetched only as the last row comes near.
const int kContinueWithinItems = 0;

/// From this width of the search area up, the department filter sits
/// beside the search field; below it, under the field.
const double kFilterBesideSearchFrom = 568.0;

/// The department filter's width when it sits beside the search field.
const double kDepartmentFilterWidth = 300.0;

/// Space between the module's edge and its content, on every side.
const double kGalleryInset = 16.0;

/// Space between a mat and the caption under it.
const double kCaptionGap = 8.0;

/// Slack under each caption, so two rows of tiles never read as one block.
const double kCaptionSlack = 8.0;

/// How many columns the gallery has, for the width the module was given
/// (not the window's).
int galleryColumnsFor(double width) {
  if (width < 600) return 2;
  if (width < 840) return 3;
  return 4;
}

/// Space between tiles, both ways.
double galleryGapFor(double width) => width < 600 ? 12.0 : 16.0;

/// The width of one tile for a gallery of [width], insets and gaps removed.
double artworkTileWidth(double width) {
  final columns = galleryColumnsFor(width);
  final gaps = galleryGapFor(width) * (columns - 1);
  return (width - kGalleryInset * 2 - gaps) / columns;
}

/// Lines of caption under a mat, and the type sizes they are set in. The
/// tile's height is derived from these.
const int kCaptionTitleLines = 2;
const double _titleFontSize = 14.0;
const double _titleLineHeight = 20.0 / 14.0;
const double _bylineFontSize = 12.0;
const double _bylineLineHeight = 16.0 / 12.0;

/// The height of one tile: a square mat, then room for the caption at the
/// reader's text scale.
double artworkTileExtent({
  required double tileWidth,
  required TextScaler textScaler,
}) {
  final title =
      textScaler.scale(_titleFontSize) * _titleLineHeight * kCaptionTitleLines;
  final byline = textScaler.scale(_bylineFontSize) * _bylineLineHeight;
  return tileWidth + kCaptionGap + title + byline + kCaptionSlack;
}
