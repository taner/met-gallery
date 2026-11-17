import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:met_gallery/app/data/models/department.dart';
import 'package:met_gallery/app/data/pagination/paged_artworks.dart';
import 'package:met_gallery/app/modules/gallery/gallery_helper.dart';
import 'package:met_gallery/app/strings.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../support/fakes.dart';

void main() {
  group('galleryPagingState (what infinite_scroll_pagination is told, and so '
      'what it shows and whether it asks for more)', () {
    final shown = [artwork(1), artwork(2), artwork(3)];

    PagingState<int, Object?> stateOf(PagedArtworks artworks) =>
        galleryPagingState(artworks, columns: 4);

    test('a first load is three rows of placeholders, and the package is '
        'never left to start a load of its own', () {
      final state = stateOf(const PagedArtworks(query: 'q', isLoading: true));

      expect(state.items, List<Object?>.filled(12, null));
      // `loadingFirstPage` is the status in which the package fetches by
      // itself. The notifier has already started this load.
      expect(state.status, isNot(PagingStatus.loadingFirstPage));
      expect(state.hasNextPage, isFalse);
    });

    test('with works shown and more to come, scrolling may ask for more', () {
      final state = stateOf(
        PagedArtworks(query: 'q', items: shown, total: 153, examined: 12),
      );

      expect(state.items, shown);
      expect(state.status, PagingStatus.ongoing);
    });

    test('a load-more puts one row of placeholders after the works', () {
      final state = stateOf(
        PagedArtworks(
          query: 'q',
          items: shown,
          total: 153,
          examined: 12,
          isLoading: true,
        ),
      );

      expect(state.items, [...shown, null, null, null, null]);
      expect(state.isLoading, isTrue);
    });

    test('a failed load-more keeps the works and stops the automatic '
        'loads: retrying is the reader\'s decision', () {
      final artworks = PagedArtworks(
        query: 'q',
        items: shown,
        total: 153,
        examined: 12,
        failure: PageFailure.unreachable,
      );
      final state = stateOf(artworks);

      expect(state.items, shown);
      // The package asks for the next page whenever it believes there is
      // one, error or not. Leaving this true is a retry loop.
      expect(artworks.hasMore, isTrue);
      expect(state.hasNextPage, isFalse);
    });

    test(
      'after a page that added nothing the package is told there is no '
      'next page, though the gallery has more: only the button continues',
      () {
        final artworks = PagedArtworks(
          query: 'picasso',
          items: shown,
          total: 700,
          examined: 24,
          lastPageEmpty: true,
        );

        expect(artworks.hasMore, isTrue);
        expect(stateOf(artworks).hasNextPage, isFalse);
        expect(stateOf(artworks).status, PagingStatus.completed);
      },
    );

    test('at the end of the matches there is no next page', () {
      final state = stateOf(
        PagedArtworks(query: 'q', items: shown, total: 3, examined: 3),
      );

      expect(state.status, PagingStatus.completed);
    });

    test('nothing shown and the load failed is the first-page error', () {
      final state = stateOf(
        const PagedArtworks(query: 'q', failure: PageFailure.unreachable),
      );

      expect(state.status, PagingStatus.firstPageError);
    });

    test('nothing shown and nothing on its way is "no items", whether the '
        'search matched nothing or matched only what cannot be shown', () {
      expect(
        stateOf(const PagedArtworks(query: 'zzq')).status,
        PagingStatus.noItemsFound,
      );
      // Matches remain, but the package must not walk them unattended.
      final nothingShown = stateOf(
        const PagedArtworks(
          query: 'picasso',
          total: 700,
          examined: 12,
          lastPageEmpty: true,
        ),
      );
      expect(nothingShown.status, PagingStatus.noItemsFound);
      expect(nothingShown.hasNextPage, isFalse);
    });
  });

  group('galleryFooterDisplay', () {
    test('loading, then failure, then more, then the end', () {
      GalleryFooterDisplay footer({
        bool loading = false,
        bool failed = false,
        bool more = false,
      }) => galleryFooterDisplay(
        isLoading: loading,
        hasFailure: failed,
        hasMore: more,
      );

      expect(footer(loading: true, more: true), GalleryFooterDisplay.loading);
      // Failure beats "more": the reader is offered the retry, not a
      // button that looks as if nothing had gone wrong.
      expect(footer(failed: true, more: true), GalleryFooterDisplay.failed);
      expect(footer(more: true), GalleryFooterDisplay.more);
      expect(footer(), GalleryFooterDisplay.end);
    });
  });

  group('gallery geometry', () {
    test('columns follow the width the module is given', () {
      expect(galleryColumnsFor(390), 2);
      expect(galleryColumnsFor(599), 2);
      expect(galleryColumnsFor(600), 3);
      expect(galleryColumnsFor(839), 3);
      expect(galleryColumnsFor(840), 4);
      expect(galleryColumnsFor(1120), 4);
    });

    test('tiles, gaps and insets add up to exactly the width', () {
      for (final width in [390.0, 700.0, 1120.0]) {
        final columns = galleryColumnsFor(width);
        final used =
            artworkTileWidth(width) * columns +
            galleryGapFor(width) * (columns - 1) +
            kGalleryInset * 2;

        expect(used, closeTo(width, 0.001), reason: '$width');
      }
    });

    test('the caption\'s share of a tile grows with the text scale', () {
      double captionAt(double scale) =>
          artworkTileExtent(
            tileWidth: 200.0,
            textScaler: TextScaler.linear(scale),
          ) -
          200.0;

      // Two title lines at 20 and a byline at 16, plus 8 above and below.
      expect(captionAt(1.0), 8.0 + 40.0 + 16.0 + 8.0);
      // At 1.5× the text needs 84, not 56; a fixed extent would clip it.
      expect(captionAt(1.5), 8.0 + 60.0 + 24.0 + 8.0);
    });
  });

  group('normaliseQuery', () {
    test('trims, and collapses inner runs of space', () {
      expect(normaliseQuery('  egyptian   cat '), 'egyptian cat');
    });

    test('nothing typed stays nothing: an empty query is a search of its '
        'own, for the whole collection', () {
      expect(normaliseQuery(''), '');
      expect(normaliseQuery('   '), '');
    });
  });

  group('emptyGalleryAction (the one action an empty gallery offers)', () {
    test('further in, while matches remain unexamined', () {
      expect(
        emptyGalleryAction(hasMore: true, isFiltered: true),
        EmptyGalleryAction.lookFurther,
      );
      expect(
        emptyGalleryAction(hasMore: true, isFiltered: false),
        EmptyGalleryAction.lookFurther,
      );
    });

    test('out of the department before out of the search: the default '
        'search inside the same department may be just as empty', () {
      expect(
        emptyGalleryAction(hasMore: false, isFiltered: true),
        EmptyGalleryAction.allDepartments,
      );
    });

    test('back to the default search when there is nothing left to widen', () {
      expect(
        emptyGalleryAction(hasMore: false, isFiltered: false),
        EmptyGalleryAction.defaultSearch,
      );
    });
  });

  group('the words for a search, with and without a query or a department', () {
    const asianArt = Department(departmentId: 6, displayName: 'Asian Art');

    PagedArtworks artworksOf(String query, {Department? department}) =>
        PagedArtworks(
          query: query,
          department: department,
          items: [artwork(1), artwork(2)],
          total: 500,
          examined: 2,
        );

    test('the status line names what there is to name', () {
      expect(
        Strings.status(artworksOf('Hokusai')),
        'Showing 2 of about 500 for “Hokusai”',
      );
      expect(
        Strings.status(artworksOf('Hokusai', department: asianArt)),
        'Showing 2 of about 500 for “Hokusai” in Asian Art',
      );
      // No query: the number needs a noun, and there are no empty quotes.
      expect(Strings.status(artworksOf('')), 'Showing 2 of about 500 works');
      expect(
        Strings.status(artworksOf('', department: asianArt)),
        'Showing 2 of about 500 works in Asian Art',
      );
    });

    test('loading and empty searches never show a pair of empty quotes', () {
      expect(
        Strings.status(const PagedArtworks(query: '', isLoading: true)),
        'Looking through the collection…',
      );
      expect(
        Strings.status(
          const PagedArtworks(query: '', department: asianArt, isLoading: true),
        ),
        'Looking through Asian Art…',
      );
      expect(
        Strings.noMatchesTitle(
          const PagedArtworks(query: '', department: asianArt),
        ),
        'Nothing to show in Asian Art',
      );
      expect(
        Strings.noMatchesTitle(
          const PagedArtworks(query: 'zzq', department: asianArt),
        ),
        'Nothing matches “zzq” in Asian Art',
      );
    });
  });

  group('search history rules', () {
    test('the newest search goes on top; searching for one again moves it '
        'there instead of listing it twice', () {
      var history = rememberSearch(const [], 'vermeer');
      history = rememberSearch(history, 'armor');
      expect(history, ['armor', 'vermeer']);

      expect(rememberSearch(history, '  VERMEER '), ['VERMEER', 'armor']);
    });

    test('a pause half-way through a word does not leave the half behind', () {
      // The gallery searches as you type, so "ver" was a search too.
      var history = rememberSearch(const ['armor'], 'ver');
      history = rememberSearch(history, 'vermeer');

      expect(history, ['vermeer', 'armor']);
      // Only the newest entry is taken for unfinished typing: an older
      // "ver" that someone searched for on its own stays.
      expect(rememberSearch(const ['armor', 'ver'], 'vermeer'), [
        'vermeer',
        'armor',
        'ver',
      ]);
    });

    test('nothing typed is not remembered, and the list has a ceiling', () {
      expect(rememberSearch(const ['armor'], '   '), ['armor']);

      var history = const <String>[];
      for (var i = 0; i < kSearchHistoryLimit + 3; i++) {
        history = rememberSearch(history, 'search $i x');
      }
      expect(history, hasLength(kSearchHistoryLimit));
      expect(history.first, 'search ${kSearchHistoryLimit + 2} x');
    });

    test('a pause on a letter or two is not remembered; Enter always is', () {
      expect(isWorthRemembering('r', submitted: false), isFalse);
      expect(isWorthRemembering(' ve ', submitted: false), isFalse);
      expect(isWorthRemembering('ver', submitted: false), isTrue);

      expect(isWorthRemembering('r', submitted: true), isTrue);
      expect(isWorthRemembering('   ', submitted: true), isFalse);
    });

    test('forgetting removes the one entry', () {
      expect(forgetSearch(const ['armor', 'Vermeer'], 'vermeer'), ['armor']);
    });

    test('suggestions are the entries containing what is typed, never the '
        'typed text itself, and all of them for an empty field', () {
      const history = ['vermeer', 'armor', 'Egyptian cat'];

      expect(searchSuggestions(history, ''), history);
      expect(searchSuggestions(history, 'ER'), ['vermeer']);
      expect(searchSuggestions(history, 'a'), ['armor', 'Egyptian cat']);
      expect(searchSuggestions(history, 'Armor'), isEmpty);
    });
  });

  test('toggleFavourite adds a work on top, and takes it out if it is '
      'there, going by its id', () {
    final one = [artwork(1)];

    expect(toggleFavourite(one, artwork(2)).map((a) => a.id), [2, 1]);
    // The same work, as another search returned it.
    expect(
      toggleFavourite(one, artwork(1).copyWith(title: 'Renamed')),
      isEmpty,
    );
  });
}
