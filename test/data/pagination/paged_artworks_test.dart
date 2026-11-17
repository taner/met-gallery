import 'package:flutter_test/flutter_test.dart';
import 'package:met_gallery/app/data/models/artwork.dart';
import 'package:met_gallery/app/data/pagination/paged_artworks.dart';

import '../../support/fakes.dart';

ArtworkPage page(List<int> ids, {required int total, int? examined}) =>
    ArtworkPage(
      artworks: ids.map(artwork).toList(),
      total: total,
      examined: examined ?? ids.length,
    );

void main() {
  group('PagedArtworks.append (what a page does to the gallery)', () {
    test('appends in order and moves the offset by what was examined', () {
      const artworks = PagedArtworks(query: 'q', isLoading: true);

      // Twelve ids examined, nine of them shown.
      final after = artworks.append(
        page([1, 2, 3, 4, 5, 6, 7, 8, 9], total: 153, examined: 12),
      );

      expect(after.items.map((a) => a.id), [1, 2, 3, 4, 5, 6, 7, 8, 9]);
      expect(after.examined, 12);
      expect(after.isLoading, isFalse);
      expect(after.hasMore, isTrue);
    });

    test('a work already on screen is not shown twice', () {
      // If the collection shifts between two loads, an offset can return
      // the same id again.
      final artworks = const PagedArtworks(query: 'q')
          .append(page([1, 2, 3], total: 9));

      final after = artworks.append(page([3, 4], total: 9));

      expect(after.items.map((a) => a.id), [1, 2, 3, 4]);
    });

    test('a second impression of a print already on screen is not shown '
        'again, in the same page or a later one', () {
      // The museum catalogues every impression of a print as an object of
      // its own, so a search can return the same picture several times.
      Artwork impression(int id, String? print) =>
          artwork(id).copyWith(impressionOf: print);

      final first = const PagedArtworks(query: 'q', isLoading: true).append(
        ArtworkPage(
          artworks: [
            impression(1, 'ushibori'),
            impression(2, 'fujimigahara'),
            impression(3, 'fujimigahara'),
            impression(4, null),
            impression(5, null),
          ],
          total: 492,
          examined: 5,
        ),
      );
      // The first impression is kept. Works that are not prints (no key)
      // are never taken for one another.
      expect(first.items.map((a) => a.id), [1, 2, 4, 5]);

      final second = first.append(
        ArtworkPage(
          artworks: [impression(6, 'fujimigahara'), impression(7, 'the wave')],
          total: 492,
          examined: 2,
        ),
      );
      expect(second.items.map((a) => a.id), [1, 2, 4, 5, 7]);
      // Still seven ids examined: the offset moves on past the repeats.
      expect(second.examined, 7);
    });

    test('"of about N" drops every match we have ruled out', () {
      final artworks = const PagedArtworks(query: 'q')
          .append(page([1, 2, 3, 4], total: 153, examined: 12));

      // 12 examined, 4 shown: 8 ruled out of 153.
      expect(artworks.skipped, 8);
      expect(artworks.approximateTotal, 145);
    });

    test('has-more follows ids examined, not tiles shown', () {
      // The last page of a search: three ids left, none can be shown.
      final artworks = const PagedArtworks(query: 'q')
          .append(page([1], total: 15, examined: 12))
          .append(page([], total: 15, examined: 3));

      expect(artworks.hasMore, isFalse);
      expect(artworks.lastPageEmpty, isTrue);
      expect(artworks.approximateTotal, 1);
    });

    test('a page clears the failure it was the retry for', () {
      const artworks = PagedArtworks(
        query: 'q',
        failure: PageFailure.unreachable,
      );

      expect(artworks.append(page([1], total: 1)).failure, isNull);
    });
  });
}
