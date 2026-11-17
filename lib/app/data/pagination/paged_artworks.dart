import 'dart:math' as math;

import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/artwork.dart';
import '../models/department.dart';

part 'paged_artworks.freezed.dart';

/// Why a load failed, as the screen needs to know it.
enum PageFailure {
  /// No response: offline, or refused by the museum's firewall.
  unreachable,

  /// The museum answered, with a 5xx or a 429.
  unavailable,

  /// A 4xx, or a body that is not the documented shape.
  unexpected,
}

/// The result of one load.
class ArtworkPage {
  /// The works that can be shown, in search order.
  final List<Artwork> artworks;

  /// How many ids the search says match in all.
  final int total;

  /// How many of this page's ids were settled, counted from the front.
  /// The next load starts after them.
  final int examined;

  const ArtworkPage({
    required this.artworks,
    required this.total,
    required this.examined,
  });
}

/// The state of a search: the works loaded so far, with the loading and
/// failure flags beside them, so a failed load keeps the works.
///
/// The API pages by offset, and [examined] is the next offset.
@freezed
abstract class PagedArtworks with _$PagedArtworks {
  const PagedArtworks._();

  const factory PagedArtworks({
    required String query,

    /// The department the search is narrowed to; null for all of them.
    Department? department,
    @Default([]) List<Artwork> items,
    @Default(0) int total,
    @Default(0) int examined,
    @Default(false) bool isLoading,
    PageFailure? failure,

    /// The latest page added no works.
    @Default(false) bool lastPageEmpty,
  }) = _PagedArtworks;

  /// Whether there are ids left to ask about.
  bool get hasMore => examined < total;

  /// Ids that were examined and produced no work.
  int get skipped => examined - items.length;

  /// The "of about N" figure: the total less the ids ruled out so far,
  /// and never below the number of works loaded.
  int get approximateTotal => math.max(items.length, total - skipped);

  /// This state with [page] added. Works already loaded, and further
  /// impressions of a print already loaded, are dropped.
  PagedArtworks append(ArtworkPage page) {
    final loadedIds = {for (final artwork in items) artwork.id};
    final loadedPrints = {for (final artwork in items) ?artwork.impressionOf};

    bool isNew(Artwork artwork) {
      if (!loadedIds.add(artwork.id)) return false;
      final print = artwork.impressionOf;
      return print == null || loadedPrints.add(print);
    }

    final fresh = page.artworks.where(isNew).toList();

    return copyWith(
      items: [...items, ...fresh],
      total: page.total,
      examined: examined + page.examined,
      isLoading: false,
      failure: null,
      lastPageEmpty: fresh.isEmpty,
    );
  }
}
