import 'package:flutter_test/flutter_test.dart';
import 'package:met_gallery/app/data/models/department.dart';
import 'package:met_gallery/app/data/pagination/paged_artworks.dart';
import 'package:met_gallery/app/data/repositories/favourites_local_repository.dart';
import 'package:met_gallery/app/data/repositories/search_history_local_repository.dart';
import 'package:met_gallery/app/data/services/collection_service.dart';
import 'package:met_gallery/app/modules/gallery/gallery_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../support/fakes.dart';

void main() {
  late FakeCollectionService service;
  late ProviderContainer container;

  PagedArtworks artworks() => container.read(galleryArtworksProvider);
  GalleryArtworks notifier() =>
      container.read(galleryArtworksProvider.notifier);

  setUp(() async {
    service = FakeCollectionService();
    container = ProviderContainer.test(
      overrides: [
        collectionServiceProvider.overrideWithValue(service),
        initialQueryProvider.overrideWithValue('hokusai'),
      ],
    );
    // Something must be listening, as the module would be, or the
    // provider is disposed between reads.
    container.listen(galleryArtworksProvider, (_, _) {});
    await pumpEventQueue();
  });

  test('starts its own first load, so the module is never an empty box', () {
    expect(artworks().isLoading, isTrue);
    expect(service.calls.single.query, 'hokusai');
    expect(service.calls.single.offset, 0);
  });

  test('latest search wins over a slower earlier one', () async {
    final hokusai = service.calls.single;

    notifier().search('vermeer');
    final vermeer = service.calls.last;

    // The old request is told to stop…
    expect(hokusai.cancelToken!.isCancelled, isTrue);

    // …and when its response lands anyway, after the newer one, it is
    // not allowed onto the gallery.
    vermeer.complete([10, 11], total: 34);
    await pumpEventQueue();
    hokusai.complete([1, 2, 3], total: 492);
    await pumpEventQueue();

    expect(artworks().query, 'vermeer');
    expect(artworks().items.map((a) => a.id), [10, 11]);
    expect(artworks().total, 34);
  });

  test('a superseded search that fails does not put up an error', () async {
    final hokusai = service.calls.single;
    notifier().search('vermeer');
    service.calls.last.complete([10], total: 1);
    await pumpEventQueue();

    hokusai.fail(connectionError());
    await pumpEventQueue();

    expect(artworks().failure, isNull);
    expect(artworks().items, hasLength(1));
  });

  test('searching for what is already on screen asks for nothing', () async {
    service.calls.single.complete([1, 2], total: 2);
    await pumpEventQueue();

    // What the debounce does after Enter or a chip has already searched.
    await notifier().search('  Hokusai ');

    expect(service.calls, hasLength(1));
  });

  test('load-more asks from where the last page stopped', () async {
    // Twelve ids examined to show nine.
    service.calls.single.complete(
      [1, 2, 3, 4, 5, 6, 7, 8, 9],
      total: 153,
      examined: 12,
    );
    await pumpEventQueue();

    notifier().loadMore();

    expect(service.calls.last.query, 'hokusai');
    expect(service.calls.last.offset, 12);
    // The tiles stay up while more is fetched.
    expect(artworks().isLoading, isTrue);
    expect(artworks().items, hasLength(9));
  });

  test('a failed load-more keeps the tiles already shown', () async {
    service.calls.single.complete([1, 2, 3], total: 153, examined: 12);
    await pumpEventQueue();

    notifier().loadMore();
    service.calls.last.fail(connectionError());
    await pumpEventQueue();

    expect(artworks().items.map((a) => a.id), [1, 2, 3]);
    expect(artworks().failure, PageFailure.unreachable);
    expect(artworks().isLoading, isFalse);

    // Retry picks up at the same offset, not from the top.
    notifier().retry();
    expect(service.calls.last.offset, 12);
    expect(artworks().items, hasLength(3));
  });

  test('a failed first load retries from the start, and Enter on the same '
      'search is that retry', () async {
    service.calls.single.fail(httpError(503));
    await pumpEventQueue();
    expect(artworks().failure, PageFailure.unavailable);

    notifier().search('hokusai');

    expect(service.calls, hasLength(2));
    expect(service.calls.last.offset, 0);
    expect(artworks().isLoading, isTrue);
    expect(artworks().failure, isNull);
  });

  test(
    'load-more is ignored while loading and at the end of the gallery',
    () async {
      notifier().loadMore(); // first load still in flight
      expect(service.calls, hasLength(1));

      service.calls.single.complete([1, 2], total: 2);
      await pumpEventQueue();
      notifier().loadMore(); // nothing left to ask about

      expect(service.calls, hasLength(1));
    },
  );

  group('department filter', () {
    const asianArt = Department(departmentId: 6, displayName: 'Asian Art');

    test('narrows the search on screen, from the top, and stays put for '
        'more of it and for the next search', () async {
      service.calls.single.complete([1, 2, 3], total: 492);
      await pumpEventQueue();

      notifier().filterByDepartment(asianArt);

      // A new search of the same query: nothing carried over, offset 0.
      expect(artworks().department, asianArt);
      expect(artworks().items, isEmpty);
      expect(service.calls.last.query, 'hokusai');
      expect(service.calls.last.offset, 0);
      expect(service.calls.last.departmentId, 6);

      service.calls.last.complete([1, 2], total: 466);
      await pumpEventQueue();
      notifier().loadMore();
      expect(service.calls.last.offset, 2);
      expect(service.calls.last.departmentId, 6);

      notifier().search('vermeer');
      expect(service.calls.last.query, 'vermeer');
      expect(service.calls.last.departmentId, 6);

      notifier().filterByDepartment(null);
      expect(artworks().department, isNull);
      expect(service.calls.last.query, 'vermeer');
      expect(service.calls.last.departmentId, isNull);
    });

    test(
      'choosing the department already on screen asks for nothing',
      () async {
        service.calls.single.complete([1, 2], total: 2);
        await pumpEventQueue();

        await notifier().filterByDepartment(null);
        expect(service.calls, hasLength(1));

        notifier().filterByDepartment(asianArt);
        service.calls.last.complete([1], total: 1);
        await pumpEventQueue();
        await notifier().filterByDepartment(asianArt);
        expect(service.calls, hasLength(2));
      },
    );
  });

  group('search history', () {
    ProviderContainer containerWith(FakeSearchHistoryRepository store) {
      final container = ProviderContainer.test(
        overrides: [
          searchHistoryLocalRepositoryProvider.overrideWithValue(store),
        ],
      );
      container.listen(searchHistoryProvider, (_, _) {});
      return container;
    }

    test(
      'starts with what the last visit saved, and saves every change',
      () async {
        final store = FakeSearchHistoryRepository(['vermeer']);
        final container = containerWith(store);
        await pumpEventQueue();
        expect(container.read(searchHistoryProvider), ['vermeer']);

        container.read(searchHistoryProvider.notifier).remember('armor');
        await pumpEventQueue();
        expect(store.saved, ['armor', 'vermeer']);

        container.read(searchHistoryProvider.notifier).forget('vermeer');
        await pumpEventQueue();
        expect(store.saved, ['armor']);
      },
    );

    test('a search made before the saved list has been read goes on top '
        'of it', () async {
      final store = FakeSearchHistoryRepository(['vermeer']);
      final container = containerWith(store);

      container.read(searchHistoryProvider.notifier).remember('armor');
      await pumpEventQueue();

      expect(container.read(searchHistoryProvider), ['armor', 'vermeer']);
      // And it was not written over what was saved: an early write would
      // have left storage holding 'armor' alone.
      expect(store.saved, ['armor', 'vermeer']);
    });

    test(
      'with storage blocked the history still works for this visit',
      () async {
        final store = FakeSearchHistoryRepository()..broken = true;
        final container = containerWith(store);
        await pumpEventQueue();

        container.read(searchHistoryProvider.notifier).remember('armor');
        await pumpEventQueue();

        expect(container.read(searchHistoryProvider), ['armor']);
      },
    );
  });

  group('favourites', () {
    ProviderContainer containerWith(FakeFavouritesRepository store) {
      final container = ProviderContainer.test(
        overrides: [favouritesLocalRepositoryProvider.overrideWithValue(store)],
      );
      container.listen(favouritesProvider, (_, _) {});
      return container;
    }

    List<int> ids(ProviderContainer container) => [
      for (final artwork in container.read(favouritesProvider)) artwork.id,
    ];

    test(
      'starts with what the last visit saved, and saves every change',
      () async {
        final store = FakeFavouritesRepository([artwork(1)]);
        final container = containerWith(store);
        await pumpEventQueue();
        expect(ids(container), [1]);

        container.read(favouritesProvider.notifier).toggle(artwork(2));
        await pumpEventQueue();
        expect(store.saved.map((a) => a.id), [2, 1]);

        container.read(favouritesProvider.notifier).toggle(artwork(1));
        await pumpEventQueue();
        expect(store.saved.map((a) => a.id), [2]);
      },
    );

    test('a work marked before the saved list has been read is added to '
        'it, not written over it', () async {
      final store = FakeFavouritesRepository([artwork(1)]);
      final container = containerWith(store);

      container.read(favouritesProvider.notifier).toggle(artwork(2));
      await pumpEventQueue();

      expect(ids(container), [2, 1]);
      expect(store.saved.map((a) => a.id), [2, 1]);
    });

    test(
      'with storage blocked the collection still works for this visit',
      () async {
        final store = FakeFavouritesRepository()..broken = true;
        final container = containerWith(store);
        await pumpEventQueue();

        container.read(favouritesProvider.notifier).toggle(artwork(2));
        await pumpEventQueue();

        expect(ids(container), [2]);
      },
    );
  });
}
