import 'package:freezed_annotation/freezed_annotation.dart';

import '../converters/safe_json.dart';

part 'collection_object.freezed.dart';
part 'collection_object.g.dart';

/// One object record, as `GET /v1/objects/{objectID}` documents it
/// (https://metmuseum.github.io/#object), with names in Dart casing.
///
/// Only [objectId] is required, and `fromJson` throws [FormatException]
/// without it. Any other field reads as empty when it is missing, null or
/// of the wrong type (see `safe_json.dart`).
@Freezed(toJson: false)
abstract class CollectionObject with _$CollectionObject {
  @JsonSerializable(createToJson: false, converters: safeConverters)
  const factory CollectionObject({
    /// `objectID`. Unique; the key of a record.
    @JsonKey(name: 'objectID', fromJson: requiredJsonId) required int objectId,

    /// A popular and important work in the collection.
    @Default(false) bool isHighlight,

    /// Not always unique. "67.241".
    @Default('') String accessionNumber,

    /// The year the work was acquired, as text. "1921".
    @Default('') String accessionYear,
    @Default(false) bool isPublicDomain,

    /// Full-resolution JPEG. Empty when the image is not open access.
    @Default('') String primaryImage,

    /// Lower-resolution JPEG. Empty when the image is not open access.
    @Default('') String primaryImageSmall,
    @JsonKey(fromJson: _readTexts)
    @Default(<String>[])
    List<String> additionalImages,
    @JsonKey(fromJson: _readConstituents)
    @Default(<ObjectConstituent>[])
    List<ObjectConstituent> constituents,

    /// The curatorial department responsible. "Egyptian Art".
    @Default('') String department,

    /// The physical type of the object. "Dress", "Painting", "Vase".
    @Default('') String objectName,
    @Default('') String title,

    /// "Afghan", "British", "North African".
    @Default('') String culture,

    /// "Ming dynasty (1368-1644)", "Middle Bronze Age".
    @Default('') String period,

    /// "Kingdom of Benin", "Dynasty 12".
    @Default('') String dynasty,

    /// "Amenhotep III", "Louis XVI".
    @Default('') String reign,

    /// A set of works made as a group. "Birds of America".
    @Default('') String portfolio,

    /// "Artist for Painting", "Designer for Dress".
    @Default('') String artistRole,

    /// An attribution qualifier. "In the Style of", "Possibly by".
    @Default('') String artistPrefix,

    /// The artist's name in display order. "Vincent van Gogh".
    @Default('') String artistDisplayName,

    /// "Dutch, Zundert 1853–1890 Auvers-sur-Oise".
    @Default('') String artistDisplayBio,

    /// "verso only".
    @Default('') String artistSuffix,

    /// The name in sorting order. "Gogh, Vincent van".
    @Default('') String artistAlphaSort,

    /// "Spanish", "French, born Romania".
    @Default('') String artistNationality,

    /// The year the artist was born, as text. "1840".
    @Default('') String artistBeginDate,

    /// The year the artist died, as text. "1926".
    @Default('') String artistEndDate,

    /// Currently holds female designations only.
    @Default('') String artistGender,

    /// `artistWikidata_URL`.
    @JsonKey(name: 'artistWikidata_URL') @Default('') String artistWikidataUrl,

    /// `artistULAN_URL`.
    @JsonKey(name: 'artistULAN_URL') @Default('') String artistUlanUrl,

    /// When the work was made, for display. "1865–67", "ca. 1796".
    @Default('') String objectDate,

    /// The year the work was begun, machine readable. Negative is BC.
    int? objectBeginDate,

    /// The year the work was completed, machine readable. Negative is BC.
    int? objectEndDate,

    /// "Oil on canvas", "Watercolor", "Gold".
    @Default('') String medium,

    /// For display. "16 x 20 in. (40.6 x 50.8 cm)".
    @Default('') String dimensions,

    /// Documented, but absent from the records the API serves today.
    @JsonKey(fromJson: _readDimensions)
    @Default(<ObjectDimension>[])
    List<ObjectDimension> dimensionsParsed,
    @JsonKey(fromJson: _readMeasurements)
    @Default(<ObjectMeasurement>[])
    List<ObjectMeasurement> measurements,

    /// "Robert Lehman Collection, 1975".
    @Default('') String creditLine,

    /// How the place fields relate to the object. "Made in", "From".
    @Default('') String geographyType,
    @Default('') String city,

    /// State or province. May overlap with [county].
    @Default('') String state,
    @Default('') String county,
    @Default('') String country,

    /// More specific than [country]. "Bohemia", "Midwest".
    @Default('') String region,

    /// More specific than [region]. "Valley of the Kings".
    @Default('') String subregion,

    /// More specific than [subregion]. "Tomb of Perneb".
    @Default('') String locale,

    /// More specific than [locale]. "1st chamber W. wall".
    @Default('') String locus,

    /// "MMA excavations, 1923–24".
    @Default('') String excavation,
    @Default('') String river,

    /// A general term for the type of work. "Ceramics", "Paintings".
    @Default('') String classification,

    /// The credit line for works still under copyright.
    @Default('') String rightsAndReproduction,

    /// The object's page on metmuseum.org. Often empty; see [objectUrl].
    @Default('') String linkResource,

    /// When the record was last updated.
    DateTime? metadataDate,

    /// "Metropolitan Museum of Art, New York, NY".
    @Default('') String repository,

    /// `objectURL`. The object's page on metmuseum.org.
    @JsonKey(name: 'objectURL') @Default('') String objectUrl,
    @JsonKey(fromJson: _readTags) @Default(<ObjectTag>[]) List<ObjectTag> tags,

    /// `objectWikidata_URL`.
    @JsonKey(name: 'objectWikidata_URL') @Default('') String objectWikidataUrl,

    /// Whether the object is on the Timeline of Art History website.
    @Default(false) bool isTimelineWork,

    /// `GalleryNumber`. Where the work is on view, when it is. "131".
    @JsonKey(name: 'GalleryNumber') @Default('') String galleryNumber,
  }) = _CollectionObject;

  factory CollectionObject.fromJson(Map<String, dynamic> json) =>
      _$CollectionObjectFromJson(json);
}

/// A person or organisation connected to an object, and how.
@Freezed(toJson: false)
abstract class ObjectConstituent with _$ObjectConstituent {
  @JsonSerializable(createToJson: false, converters: safeConverters)
  const factory ObjectConstituent({
    /// `constituentID`.
    @JsonKey(name: 'constituentID') int? constituentId,

    /// "Artist", "Publisher".
    @Default('') String role,
    @Default('') String name,

    /// `constituentULAN_URL`.
    @JsonKey(name: 'constituentULAN_URL') @Default('') String ulanUrl,

    /// `constituentWikidata_URL`.
    @JsonKey(name: 'constituentWikidata_URL') @Default('') String wikidataUrl,

    /// Currently holds female designations only.
    @Default('') String gender,
  }) = _ObjectConstituent;

  factory ObjectConstituent.fromJson(Map<String, dynamic> json) =>
      _$ObjectConstituentFromJson(json);
}

/// The measurements of one element of an object ("Overall", "Frame").
@Freezed(toJson: false)
abstract class ObjectMeasurement with _$ObjectMeasurement {
  @JsonSerializable(createToJson: false, converters: safeConverters)
  const factory ObjectMeasurement({
    @Default('') String elementName,

    /// `null` in most records, which reads as empty here.
    @Default('') String elementDescription,

    /// By dimension name ("Height", "Width", "Weight"). Lengths are in
    /// centimetres, weights in kilograms.
    @JsonKey(fromJson: _readAmounts)
    @Default(<String, double>{})
    Map<String, double> elementMeasurements,
  }) = _ObjectMeasurement;

  factory ObjectMeasurement.fromJson(Map<String, dynamic> json) =>
      _$ObjectMeasurementFromJson(json);
}

/// One entry of `dimensionsParsed`: a single dimension of a single element,
/// in centimetres.
@Freezed(toJson: false)
abstract class ObjectDimension with _$ObjectDimension {
  @JsonSerializable(createToJson: false, converters: safeConverters)
  const factory ObjectDimension({
    /// "Sheet", "Plate".
    @Default('') String element,

    /// "Height", "Width".
    @Default('') String dimensionType,
    double? dimension,
  }) = _ObjectDimension;

  factory ObjectDimension.fromJson(Map<String, dynamic> json) =>
      _$ObjectDimensionFromJson(json);
}

/// A subject keyword attached to an object.
@Freezed(toJson: false)
abstract class ObjectTag with _$ObjectTag {
  @JsonSerializable(createToJson: false, converters: safeConverters)
  const factory ObjectTag({
    @Default('') String term,

    /// `AAT_URL`: the term in the Getty Art & Architecture Thesaurus.
    @JsonKey(name: 'AAT_URL') @Default('') String aatUrl,

    /// `Wikidata_URL`.
    @JsonKey(name: 'Wikidata_URL') @Default('') String wikidataUrl,
  }) = _ObjectTag;

  factory ObjectTag.fromJson(Map<String, dynamic> json) =>
      _$ObjectTagFromJson(json);
}

// Readers for the lists and the map. They skip what they cannot read,
// where the generated code would cast and throw.
//
// Named `_readX`, not `_x`: Freezed's generated class has a private field
// `_x` for every collection `x`, which would shadow the function.

List<String> _readTexts(Object? json) => [
  if (json is List)
    for (final item in json)
      if (const SafeText().fromJson(item) case final text when text.isNotEmpty)
        text,
];

List<ObjectConstituent> _readConstituents(Object? json) =>
    safeObjects(json, ObjectConstituent.fromJson);

List<ObjectDimension> _readDimensions(Object? json) =>
    safeObjects(json, ObjectDimension.fromJson);

List<ObjectMeasurement> _readMeasurements(Object? json) =>
    safeObjects(json, ObjectMeasurement.fromJson);

List<ObjectTag> _readTags(Object? json) =>
    safeObjects(json, ObjectTag.fromJson);

Map<String, double> _readAmounts(Object? json) => {
  if (json is Map)
    for (final entry in json.entries)
      const SafeText().fromJson(entry.key): ?const SafeDouble().fromJson(
        entry.value,
      ),
};
