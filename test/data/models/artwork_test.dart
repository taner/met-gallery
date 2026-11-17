import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:met_gallery/app/data/models/artwork.dart';
import 'package:met_gallery/app/data/models/search_ids.dart';

import '../../support/fakes.dart';

void main() {
  group(
    'ArtworkJsonHandler.fromRecord (an object record → a tile, or not)',
    () {
      test('reads the fields the caption and the label are made of', () {
        final artwork = ArtworkJsonHandler.fromRecord(objectJson(436524))!;

        expect(artwork.id, 436524);
        expect(artwork.title, 'Work 436524');
        expect(artwork.byline, 'Artist 436524 · 1830');
        expect(artwork.imageUrl, 'https://images.test/web-large/436524.jpg');
        expect(artwork.pageUrl, 'https://museum.test/art/436524');
      });

      test('a work whose image is not open access cannot be shown', () {
        // What `hasImages=true` really returns for anything still in
        // copyright: the record, with an empty image field.
        final json = objectJson(1, overrides: {'primaryImageSmall': ''});

        expect(ArtworkJsonHandler.fromRecord(json), isNull);
      });

      test('an image field that is not a web address cannot be shown', () {
        for (final bad in [
          null,
          42,
          'not a url',
          'ftp://host/a.jpg',
          '/a.jpg',
        ]) {
          final json = objectJson(1, overrides: {'primaryImageSmall': bad});

          expect(ArtworkJsonHandler.fromRecord(json), isNull, reason: '$bad');
        }
      });

      test('a body that is not a record at all is nothing, not a crash', () {
        for (final body in [null, 'Service Unavailable', 7, <Object>[]]) {
          expect(ArtworkJsonHandler.fromRecord(body), isNull, reason: '$body');
        }
        expect(ArtworkJsonHandler.fromRecord({'title': 'No id'}), isNull);
      });

      test(
        'a wrong type in a caption field costs that field, not the work',
        () {
          final artwork = ArtworkJsonHandler.fromRecord(
            objectJson(
              1,
              overrides: {
                'title': null,
                'objectDate': 1887,
                'medium': ['oil', 'canvas'],
                'department': {'name': 'European Paintings'},
              },
            ),
          )!;

          expect(artwork.title, '');
          expect(artwork.date, '1887');
          expect(artwork.medium, '');
          expect(artwork.department, '');
        },
      );

      test('with no named maker the caption leads with the culture', () {
        final artwork = ArtworkJsonHandler.fromRecord(
          objectJson(
            1,
            overrides: {'artistDisplayName': '', 'culture': 'Greek, Attic'},
          ),
        )!;

        expect(artwork.byline, 'Greek, Attic · 1830');
      });

      test('a byline has no stray separator when a half is missing', () {
        final noDate = ArtworkJsonHandler.fromRecord(
          objectJson(1, overrides: {'objectDate': ''}),
        )!;
        final neither = ArtworkJsonHandler.fromRecord(
          objectJson(1, overrides: {'objectDate': '', 'artistDisplayName': ''}),
        )!;

        expect(noDate.byline, 'Artist 1');
        expect(neither.byline, '');
      });

      test('a record without its own link gets the museum page for its id', () {
        final artwork = ArtworkJsonHandler.fromRecord(
          objectJson(436524, overrides: {'objectURL': ''}),
        )!;

        expect(
          artwork.pageUrl,
          'https://www.metmuseum.org/art/collection/search/436524',
        );
      });
    },
  );

  group('Artwork.impressionOf (which print a record is an impression of)', () {
    Artwork print(int id, Map<String, dynamic> overrides) =>
        ArtworkJsonHandler.fromRecord(
          objectJson(
            id,
            overrides: {
              'classification': 'Prints',
              'artistDisplayName': 'Katsushika Hokusai',
              'objectDate': 'ca. 1830–32',
              ...overrides,
            },
          ),
        )!;

    test('two records of one print agree, however the museum worded the '
        'rest of the title', () {
      // The two Great Waves, as the API titles them.
      final one = print(39799, {
        'title':
            'Under the Wave off Kanagawa (Kanagawa oki nami ura), or The '
            'Great Wave, from the series Thirty-six Views of Mount Fuji',
      });
      final other = print(45434, {
        'title':
            'Under the Wave off Kanagawa (Kanagawa oki nami ura), also '
            'known as The Great Wave, from the series Thirty-six Views of '
            'Mount Fuji (Fugaku sanjūrokkei)',
      });

      expect(one.impressionOf, isNotNull);
      expect(one.impressionOf, other.impressionOf);
    });

    test('a different print, artist or date is a different work', () {
      final wave = print(1, {'title': 'Under the Wave off Kanagawa (…)'});

      expect(
        print(2, {'title': 'Fujimigahara in Owari Province (…)'}).impressionOf,
        isNot(wave.impressionOf),
      );
      expect(
        print(3, {
          'title': 'Under the Wave off Kanagawa (…)',
          'artistDisplayName': 'After Katsushika Hokusai',
        }).impressionOf,
        isNot(wave.impressionOf),
      );
      expect(
        print(4, {
          'title': 'Under the Wave off Kanagawa (…)',
          'objectDate': '19th century',
        }).impressionOf,
        isNot(wave.impressionOf),
      );
    });

    test('only prints are ever taken for the same work: hiding a distinct '
        'work is worse than showing a repeat', () {
      // Two different albums the museum gives the same title and date.
      const album = {
        'title': 'Album of Sketches by Katsushika Hokusai and His Disciples',
        'classification': 'Paintings',
      };
      expect(print(40011, album).impressionOf, isNull);

      // A print with nothing to tell it by.
      expect(print(1, {'title': ''}).impressionOf, isNull);
      expect(
        print(2, {'title': 'Scarf', 'artistDisplayName': ''}).impressionOf,
        isNull,
      );
      // And a record with no classification at all.
      expect(
        ArtworkJsonHandler.fromRecord(objectJson(3))!.impressionOf,
        isNull,
      );
    });
  });

  group(
    'other views and subjects (what the detail offers beyond the tile)',
    () {
      const originals = 'https://images.metmuseum.org/CRDImages/as/original';
      const small = 'https://images.metmuseum.org/CRDImages/as/web-large';

      test('further pictures are offered in the small size, not as the '
          'full-size originals the record lists', () {
        final artwork = ArtworkJsonHandler.fromRecord(
          objectJson(
            1,
            overrides: {
              'primaryImageSmall': '$small/DP251139.jpg',
              'additionalImages': [
                '$originals/DP251138.jpg',
                '$originals/DP251120.jpg',
              ],
            },
          ),
        )!;

        expect(artwork.moreImageUrls, [
          '$small/DP251138.jpg',
          '$small/DP251120.jpg',
        ]);
        // The tile's picture comes first among the views.
        expect(artwork.imageUrls.first, artwork.imageUrl);
        expect(artwork.imageUrls, hasLength(3));
      });

      test('the tile\'s own picture is not offered twice, junk is passed '
          'over, and an album of hundreds is cut short', () {
        final artwork = ArtworkJsonHandler.fromRecord(
          objectJson(
            1,
            overrides: {
              'primaryImageSmall': '$small/a.jpg',
              'additionalImages': [
                '$originals/a.jpg',
                'not a url',
                42,
                '$originals/b.jpg',
                '$originals/b.jpg',
                for (var i = 0; i < 260; i++) '$originals/leaf$i.jpg',
              ],
            },
          ),
        )!;

        expect(artwork.moreImageUrls.first, '$small/b.jpg');
        expect(artwork.moreImageUrls, hasLength(kMoreImagesLimit));
        expect(artwork.moreImageUrls.toSet(), hasLength(kMoreImagesLimit));
        expect(artwork.moreImageUrls, isNot(contains('$small/a.jpg')));
      });

      test(
        'subjects are the tags\' terms, once each; none is an empty list',
        () {
          final artwork = ArtworkJsonHandler.fromRecord(
            objectJson(
              1,
              overrides: {
                'tags': [
                  {'term': 'Birds', 'AAT_URL': 'http://vocab.getty.edu/x'},
                  {'term': 'Mountains'},
                  {'term': 'Birds'},
                  {'term': ''},
                  'Snow',
                ],
              },
            ),
          )!;

          expect(artwork.tags, ['Birds', 'Mountains']);
          expect(
            ArtworkJsonHandler.fromRecord(
              objectJson(2, overrides: {'tags': null}),
            )!.tags,
            isEmpty,
          );
        },
      );
    },
  );

  test('an artwork survives being saved and read back whole (the form a '
      'favourite is kept in)', () {
    final original = ArtworkJsonHandler.fromRecord(
      objectJson(
        45734,
        overrides: {
          'classification': 'Prints',
          'additionalImages': ['https://images.test/original/back.jpg'],
          'tags': [
            {'term': 'Birds'},
          ],
        },
      ),
    )!;

    final restored = Artwork.fromJson(
      jsonDecode(jsonEncode(original.toJson())) as Map<String, dynamic>,
    );

    expect(restored, original);
    expect(restored.moreImageUrls, hasLength(1));
    expect(restored.tags, ['Birds']);
    expect(restored.impressionOf, isNotNull);
  });

  group('SearchIdsJsonHandler.fromJson', () {
    test('reads a page of ids and the total', () {
      final found = SearchIdsJsonHandler.fromJson({
        'total': 153,
        'objectIDs': [436524, 480725],
      });

      expect(found.total, 153);
      expect(found.ids, [436524, 480725]);
    });

    test('no matches arrive as null ids, and that is an empty page', () {
      // The API's real answer for a query that matches nothing.
      final found = SearchIdsJsonHandler.fromJson({
        'total': 0,
        'objectIDs': null,
      });

      expect(found.total, 0);
      expect(found.ids, isEmpty);
    });

    test('ids that are not positive integers are dropped, the rest kept', () {
      final found = SearchIdsJsonHandler.fromJson({
        'total': 5,
        'objectIDs': [1, '2', null, -3, 4.5, 6],
      });

      expect(found.ids, [1, 6]);
    });

    test('a missing total falls back to what the page held', () {
      final found = SearchIdsJsonHandler.fromJson({
        'objectIDs': [1, 2, 3],
      });

      expect(found.total, 3);
    });

    test('a body that is not an object fails the search', () {
      // Read tolerantly, an HTML error page would become "no matches".
      for (final body in [
        null,
        '<html>Just a moment…</html>',
        <int>[1, 2],
      ]) {
        expect(
          () => SearchIdsJsonHandler.fromJson(body),
          throwsFormatException,
          reason: '$body',
        );
      }
    });
  });
}
