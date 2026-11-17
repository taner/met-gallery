import 'package:flutter_test/flutter_test.dart';
import 'package:met_gallery/app/data/models/collection_object.dart';
import 'package:met_gallery/app/data/models/department.dart';

/// The example record from the specification
/// (https://metmuseum.github.io/#object), field for field.
const Map<String, dynamic> _documentedExample = {
  'objectID': 45734,
  'isHighlight': false,
  'accessionNumber': '36.100.45',
  'accessionYear': '1936',
  'isPublicDomain': true,
  'primaryImage':
      'https://images.metmuseum.org/CRDImages/as/original/DP251139.jpg',
  'primaryImageSmall':
      'https://images.metmuseum.org/CRDImages/as/web-large/DP251139.jpg',
  'additionalImages': [
    'https://images.metmuseum.org/CRDImages/as/original/DP251138.jpg',
    'https://images.metmuseum.org/CRDImages/as/original/DP251120.jpg',
  ],
  'constituents': [
    {
      'constituentID': 11986,
      'role': 'Artist',
      'name': 'Kiyohara Yukinobu',
      'constituentULAN_URL': 'http://vocab.getty.edu/page/ulan/500034433',
      'constituentWikidata_URL': 'https://www.wikidata.org/wiki/Q11560527',
      'gender': 'Female',
    },
  ],
  'department': 'Asian Art',
  'objectName': 'Hanging scroll',
  'title': 'Quail and Millet',
  'culture': 'Japan',
  'period': 'Edo period (1615–1868)',
  'dynasty': '',
  'reign': '',
  'portfolio': '',
  'artistRole': 'Artist',
  'artistPrefix': '',
  'artistDisplayName': 'Kiyohara Yukinobu',
  'artistDisplayBio': 'Japanese, 1643–1682',
  'artistSuffix': '',
  'artistAlphaSort': 'Kiyohara Yukinobu',
  'artistNationality': 'Japanese',
  'artistBeginDate': '1643',
  'artistEndDate': '1682',
  'artistGender': 'Female',
  'artistWikidata_URL': 'https://www.wikidata.org/wiki/Q11560527',
  'artistULAN_URL': 'http://vocab.getty.edu/page/ulan/500034433',
  'objectDate': 'late 17th century',
  'objectBeginDate': 1667,
  'objectEndDate': 1682,
  'medium': 'Hanging scroll; ink and color on silk',
  'dimensions': '46 5/8 x 18 3/4 in. (118.4 x 47.6 cm)',
  'measurements': [
    {
      'elementName': 'Overall',
      'elementDescription': null,
      'elementMeasurements': {'Height': 118.4, 'Width': 47.6},
    },
  ],
  'creditLine': 'The Howard Mansfield Collection, Purchase, Rogers Fund, 1936',
  'geographyType': '',
  'city': '',
  'state': '',
  'county': '',
  'country': '',
  'region': '',
  'subregion': '',
  'locale': '',
  'locus': '',
  'excavation': '',
  'river': '',
  'classification': 'Paintings',
  'rightsAndReproduction': '',
  'linkResource': '',
  'metadataDate': '2020-09-14T12:26:37.48Z',
  'repository': 'Metropolitan Museum of Art, New York, NY',
  'objectURL': 'https://www.metmuseum.org/art/collection/search/45734',
  'tags': [
    {
      'term': 'Birds',
      'AAT_URL': 'http://vocab.getty.edu/page/aat/300266506',
      'Wikidata_URL': 'https://www.wikidata.org/wiki/Q5113',
    },
  ],
  'objectWikidata_URL': 'https://www.wikidata.org/wiki/Q29910832',
  'isTimelineWork': false,
  'GalleryNumber': '',
};

void main() {
  group('CollectionObject.fromJson (generated, with safe converters)', () {
    test('reads the documented example, nested parts and odd key names '
        'included', () {
      final object = CollectionObject.fromJson(_documentedExample);

      expect(object.objectId, 45734);
      expect(object.isPublicDomain, isTrue);
      expect(object.title, 'Quail and Millet');
      expect(object.additionalImages, hasLength(2));
      expect(object.objectBeginDate, 1667);
      expect(object.metadataDate, DateTime.utc(2020, 9, 14, 12, 26, 37, 480));

      // Keys that do not follow the API's own casing.
      expect(object.artistUlanUrl, endsWith('/ulan/500034433'));
      expect(object.artistWikidataUrl, endsWith('/Q11560527'));
      expect(object.objectWikidataUrl, endsWith('/Q29910832'));
      expect(object.objectUrl, endsWith('/search/45734'));
      expect(object.galleryNumber, '');

      expect(
        object.constituents.single,
        const ObjectConstituent(
          constituentId: 11986,
          role: 'Artist',
          name: 'Kiyohara Yukinobu',
          ulanUrl: 'http://vocab.getty.edu/page/ulan/500034433',
          wikidataUrl: 'https://www.wikidata.org/wiki/Q11560527',
          gender: 'Female',
        ),
      );
      expect(
        object.measurements.single,
        const ObjectMeasurement(
          elementName: 'Overall',
          elementMeasurements: {'Height': 118.4, 'Width': 47.6},
        ),
      );
      expect(
        object.tags.single,
        const ObjectTag(
          term: 'Birds',
          aatUrl: 'http://vocab.getty.edu/page/aat/300266506',
          wikidataUrl: 'https://www.wikidata.org/wiki/Q5113',
        ),
      );
    });

    // What the live API sends and the specification does not mention:
    // `null` where a list is documented, whole numbers where a float is,
    // and no `dimensionsParsed` key at all.
    test('a list sent as null is an empty list, not a crash', () {
      final object = CollectionObject.fromJson({
        ..._documentedExample,
        'constituents': null,
        'tags': null,
        'additionalImages': null,
        'measurements': [
          {
            'elementName': 'Overall',
            'elementMeasurements': {'Height': 140, 'Width': 140},
          },
        ],
      });

      expect(object.constituents, isEmpty);
      expect(object.tags, isEmpty);
      expect(object.additionalImages, isEmpty);
      expect(object.dimensionsParsed, isEmpty);
      expect(object.measurements.single.elementMeasurements, {
        'Height': 140.0,
        'Width': 140.0,
      });
    });

    test('a field of the wrong type costs that field, not the record', () {
      final object = CollectionObject.fromJson({
        'objectID': '45734',
        'title': 'Quail and Millet',
        'medium': ['ink', 'silk'],
        'isHighlight': 'yes',
        'objectBeginDate': 'late',
        'metadataDate': 'yesterday',
        'tags': [
          'Birds',
          {'term': 'Millet'},
        ],
        'measurements': 'unknown',
        'additionalImages': {'first': 'a.jpg'},
      });

      expect(object.objectId, 45734);
      expect(object.title, 'Quail and Millet');
      expect(object.medium, '');
      expect(object.isHighlight, isFalse);
      expect(object.objectBeginDate, isNull);
      expect(object.metadataDate, isNull);
      expect(object.tags, const [ObjectTag(term: 'Millet')]);
      expect(object.measurements, isEmpty);
      expect(object.additionalImages, isEmpty);
    });

    test('without a usable objectID there is no record to read', () {
      for (final json in <Map<String, dynamic>>[
        {'title': 'No id'},
        {'objectID': 0},
        {'objectID': null},
        {'objectID': 'abc'},
      ]) {
        expect(
          () => CollectionObject.fromJson(json),
          throwsFormatException,
          reason: '$json',
        );
      }
    });
  });

  group('DepartmentListing.fromJson', () {
    test('reads the documented listing and skips an entry it cannot use', () {
      final listing = DepartmentListing.fromJson({
        'departments': [
          {'departmentId': 1, 'displayName': 'American Decorative Arts'},
          {'displayName': 'No id'},
          'Asian Art',
          {'departmentId': 6, 'displayName': 'Asian Art'},
        ],
      });

      expect(listing.departments, const [
        Department(departmentId: 1, displayName: 'American Decorative Arts'),
        Department(departmentId: 6, displayName: 'Asian Art'),
      ]);
    });

    test('no departments key, or one that is not a list, is an empty list', () {
      expect(DepartmentListing.fromJson({}).departments, isEmpty);
      expect(
        DepartmentListing.fromJson({'departments': 'none'}).departments,
        isEmpty,
      );
    });
  });
}
