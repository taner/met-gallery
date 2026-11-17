import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:met_gallery/app/data/models/department.dart';
import 'package:met_gallery/app/data/pagination/paged_artworks.dart';
import 'package:met_gallery/app/data/services/collection_service.dart';

import '../../support/fakes.dart';

Map<String, Object?> page(List<int> ids, {int? total}) => {
  'total': total ?? ids.length,
  'objectIDs': ids,
};

void main() {
  group('CollectionService.loadPage', () {
    test(
      'shows what it can, in search order, when some ids give nothing',
      () async {
        final remote = FakeRemoteRepository(
          onSearch: (_, _) => page([1, 2, 3, 4, 5], total: 153),
          objects: {
            2: () => throw httpError(404), // listed by search, record gone
            3: objectJson(
              3,
              overrides: {'primaryImageSmall': ''},
            ), // in copyright
            4: '<html>not a record</html>', // malformed
          },
        );

        final loaded = await CollectionService(remote)
            .loadPage(query: 'sunflowers', offset: 0);

        expect(loaded.artworks.map((a) => a.id), [1, 5]);
        // All five were settled, so the next load starts after all five.
        expect(loaded.examined, 5);
        expect(loaded.total, 153);
      },
    );

    test('never has more than the pool size in flight', () async {
      final remote = FakeRemoteRepository(
        onSearch: (_, _) => page([for (var id = 1; id <= 12; id++) id]),
      )..hold = Completer<void>();

      final loading = CollectionService(remote).loadPage(query: 'q', offset: 0);
      await pumpEventQueue();

      expect(remote.inFlight, kObjectPoolSize);

      remote.hold!.complete();
      final loaded = await loading;
      expect(loaded.artworks, hasLength(12));
      expect(remote.peakInFlight, kObjectPoolSize);
    });

    test('an id that was settled is never requested again', () async {
      final remote = FakeRemoteRepository(
        onSearch: (_, _) => page([1, 2, 3]),
        objects: {2: () => throw httpError(404)},
      );
      final service = CollectionService(remote);

      await service.loadPage(query: 'a', offset: 0);
      remote.log.clear();
      final again = await service.loadPage(query: 'b', offset: 0);

      // The search is asked; the three objects, including the one that
      // was settled as "nothing to show", come from memory.
      expect(remote.log, ['search:b@0']);
      expect(again.artworks.map((a) => a.id), [1, 3]);
    });

    test('a page stops just before an id that never answered, and the '
        'next load re-asks only that id', () async {
      var networkDown = true;
      final remote = FakeRemoteRepository(
        onSearch: (_, offset) =>
            page([for (var id = offset + 1; id <= 6; id++) id], total: 6),
        objects: {
          4: () => networkDown ? throw connectionError() : objectJson(4),
        },
      );
      final service = CollectionService(remote);

      final first = await service.loadPage(query: 'q', offset: 0);

      // 1–3 are shown. 4 never answered, so it is not counted as skipped,
      // and neither is anything after it.
      expect(first.artworks.map((a) => a.id), [1, 2, 3]);
      expect(first.examined, 3);

      networkDown = false;
      remote.log.clear();
      final second = await service.loadPage(query: 'q', offset: 3);

      expect(second.artworks.map((a) => a.id), [4, 5, 6]);
      // 5 and 6 answered during the first load and were remembered.
      expect(remote.log, ['search:q@3', 'object:4']);
    });

    test('a page that settles nothing throws instead of reporting an '
        'empty page', () async {
      final remote = FakeRemoteRepository(
        onSearch: (_, _) => page([1, 2, 3]),
        objects: {1: () => throw connectionError()},
      );

      await expectLater(
        CollectionService(remote).loadPage(query: 'q', offset: 0),
        throwsA(isA<DioException>()),
      );
    });

    test('an error from the client is passed on as it is: retrying is the '
        'client\'s business, and it has already happened', () async {
      final remote = FakeRemoteRepository(
        onSearch: (_, _) => throw httpError(503),
      );

      await expectLater(
        CollectionService(remote).loadPage(query: 'q', offset: 0),
        throwsA(isA<DioException>()),
      );
      expect(remote.log, ['search:q@0']);
    });

    test('an empty page ends the gallery, whatever the total claims', () async {
      final remote = FakeRemoteRepository(
        onSearch: (_, _) => {'total': 500, 'objectIDs': null},
      );

      final loaded = await CollectionService(remote)
          .loadPage(query: 'q', offset: 24);

      // Total pulled down to the offset: has-more is false and the gallery
      // stops asking for this page.
      expect(loaded.total, 24);
      expect(loaded.examined, 0);
    });
  });

  group('pageFailureOf (an exception → what to tell the reader)', () {
    test('no response at all is "unreachable"', () {
      expect(pageFailureOf(connectionError()), PageFailure.unreachable);
    });

    test('a 5xx, a 429 and the firewall\'s 403 are the museum\'s state', () {
      for (final status in [500, 503, 429, 403]) {
        expect(
          pageFailureOf(httpError(status)),
          PageFailure.unavailable,
          reason: '$status',
        );
      }
    });

    test('a retired endpoint or an unreadable body is ours to fix', () {
      expect(pageFailureOf(httpError(410)), PageFailure.unexpected);
      expect(
        pageFailureOf(const FormatException('not json')),
        PageFailure.unexpected,
      );
    });
  });

  test(
    'a department is sent with the search, and only when there is one',
    () async {
      final remote = FakeRemoteRepository(onSearch: (_, _) => page([1]));
      final service = CollectionService(remote);

      await service.loadPage(query: 'hokusai', offset: 0, departmentId: 6);
      await service.loadPage(query: 'hokusai', offset: 0);

      expect(remote.searchedDepartments, [6, null]);
    },
  );

  group('CollectionService.departments', () {
    final listing = departmentsJson({6: 'Asian Art', 11: 'European Paintings'});

    test(
      'is asked for once, however often and however early it is wanted',
      () async {
        final remote = FakeRemoteRepository(onDepartments: () => listing)
          ..holdDepartments = Completer<void>();
        final service = CollectionService(remote);

        // Two callers before the answer is in share the one request...
        final first = service.departments();
        final second = service.departments();
        remote.holdDepartments!.complete();

        expect(await first, const [
          Department(departmentId: 6, displayName: 'Asian Art'),
          Department(departmentId: 11, displayName: 'European Paintings'),
        ]);
        expect(await second, await first);

        // ...and one after it gets the kept answer.
        expect(await service.departments(), await first);
        expect(remote.log, ['departments']);
      },
    );

    test('a failure is not kept: the next call asks again', () async {
      var attempt = 0;
      final remote = FakeRemoteRepository(
        onDepartments: () => ++attempt == 1 ? throw httpError(404) : listing,
      );
      final service = CollectionService(remote);

      await expectLater(service.departments(), throwsA(isA<DioException>()));

      expect(await service.departments(), hasLength(2));
      expect(remote.log, ['departments', 'departments']);
    });

    test('a body without departments in it is a failure, not an empty '
        'list to remember', () async {
      for (final body in [
        '<html>502 Bad Gateway</html>',
        null,
        <String, dynamic>{},
        {'departments': <Object>[]},
        {
          'departments': [
            {'displayName': 'No id'},
          ],
        },
      ]) {
        final remote = FakeRemoteRepository(onDepartments: () => body);
        final service = CollectionService(remote);

        await expectLater(
          service.departments(),
          throwsFormatException,
          reason: '$body',
        );
        // Not remembered: asking again goes back to the museum.
        await expectLater(service.departments(), throwsFormatException);
        expect(remote.log, ['departments', 'departments'], reason: '$body');
      }
    });
  });
}
