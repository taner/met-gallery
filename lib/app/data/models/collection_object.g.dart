// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CollectionObject _$CollectionObjectFromJson(
  Map<String, dynamic> json,
) => _CollectionObject(
  objectId: requiredJsonId(json['objectID']),
  isHighlight: json['isHighlight'] == null
      ? false
      : const SafeBool().fromJson(json['isHighlight']),
  accessionNumber: json['accessionNumber'] == null
      ? ''
      : const SafeText().fromJson(json['accessionNumber']),
  accessionYear: json['accessionYear'] == null
      ? ''
      : const SafeText().fromJson(json['accessionYear']),
  isPublicDomain: json['isPublicDomain'] == null
      ? false
      : const SafeBool().fromJson(json['isPublicDomain']),
  primaryImage: json['primaryImage'] == null
      ? ''
      : const SafeText().fromJson(json['primaryImage']),
  primaryImageSmall: json['primaryImageSmall'] == null
      ? ''
      : const SafeText().fromJson(json['primaryImageSmall']),
  additionalImages: json['additionalImages'] == null
      ? const <String>[]
      : _readTexts(json['additionalImages']),
  constituents: json['constituents'] == null
      ? const <ObjectConstituent>[]
      : _readConstituents(json['constituents']),
  department: json['department'] == null
      ? ''
      : const SafeText().fromJson(json['department']),
  objectName: json['objectName'] == null
      ? ''
      : const SafeText().fromJson(json['objectName']),
  title: json['title'] == null ? '' : const SafeText().fromJson(json['title']),
  culture: json['culture'] == null
      ? ''
      : const SafeText().fromJson(json['culture']),
  period: json['period'] == null
      ? ''
      : const SafeText().fromJson(json['period']),
  dynasty: json['dynasty'] == null
      ? ''
      : const SafeText().fromJson(json['dynasty']),
  reign: json['reign'] == null ? '' : const SafeText().fromJson(json['reign']),
  portfolio: json['portfolio'] == null
      ? ''
      : const SafeText().fromJson(json['portfolio']),
  artistRole: json['artistRole'] == null
      ? ''
      : const SafeText().fromJson(json['artistRole']),
  artistPrefix: json['artistPrefix'] == null
      ? ''
      : const SafeText().fromJson(json['artistPrefix']),
  artistDisplayName: json['artistDisplayName'] == null
      ? ''
      : const SafeText().fromJson(json['artistDisplayName']),
  artistDisplayBio: json['artistDisplayBio'] == null
      ? ''
      : const SafeText().fromJson(json['artistDisplayBio']),
  artistSuffix: json['artistSuffix'] == null
      ? ''
      : const SafeText().fromJson(json['artistSuffix']),
  artistAlphaSort: json['artistAlphaSort'] == null
      ? ''
      : const SafeText().fromJson(json['artistAlphaSort']),
  artistNationality: json['artistNationality'] == null
      ? ''
      : const SafeText().fromJson(json['artistNationality']),
  artistBeginDate: json['artistBeginDate'] == null
      ? ''
      : const SafeText().fromJson(json['artistBeginDate']),
  artistEndDate: json['artistEndDate'] == null
      ? ''
      : const SafeText().fromJson(json['artistEndDate']),
  artistGender: json['artistGender'] == null
      ? ''
      : const SafeText().fromJson(json['artistGender']),
  artistWikidataUrl: json['artistWikidata_URL'] == null
      ? ''
      : const SafeText().fromJson(json['artistWikidata_URL']),
  artistUlanUrl: json['artistULAN_URL'] == null
      ? ''
      : const SafeText().fromJson(json['artistULAN_URL']),
  objectDate: json['objectDate'] == null
      ? ''
      : const SafeText().fromJson(json['objectDate']),
  objectBeginDate: const SafeInt().fromJson(json['objectBeginDate']),
  objectEndDate: const SafeInt().fromJson(json['objectEndDate']),
  medium: json['medium'] == null
      ? ''
      : const SafeText().fromJson(json['medium']),
  dimensions: json['dimensions'] == null
      ? ''
      : const SafeText().fromJson(json['dimensions']),
  dimensionsParsed: json['dimensionsParsed'] == null
      ? const <ObjectDimension>[]
      : _readDimensions(json['dimensionsParsed']),
  measurements: json['measurements'] == null
      ? const <ObjectMeasurement>[]
      : _readMeasurements(json['measurements']),
  creditLine: json['creditLine'] == null
      ? ''
      : const SafeText().fromJson(json['creditLine']),
  geographyType: json['geographyType'] == null
      ? ''
      : const SafeText().fromJson(json['geographyType']),
  city: json['city'] == null ? '' : const SafeText().fromJson(json['city']),
  state: json['state'] == null ? '' : const SafeText().fromJson(json['state']),
  county: json['county'] == null
      ? ''
      : const SafeText().fromJson(json['county']),
  country: json['country'] == null
      ? ''
      : const SafeText().fromJson(json['country']),
  region: json['region'] == null
      ? ''
      : const SafeText().fromJson(json['region']),
  subregion: json['subregion'] == null
      ? ''
      : const SafeText().fromJson(json['subregion']),
  locale: json['locale'] == null
      ? ''
      : const SafeText().fromJson(json['locale']),
  locus: json['locus'] == null ? '' : const SafeText().fromJson(json['locus']),
  excavation: json['excavation'] == null
      ? ''
      : const SafeText().fromJson(json['excavation']),
  river: json['river'] == null ? '' : const SafeText().fromJson(json['river']),
  classification: json['classification'] == null
      ? ''
      : const SafeText().fromJson(json['classification']),
  rightsAndReproduction: json['rightsAndReproduction'] == null
      ? ''
      : const SafeText().fromJson(json['rightsAndReproduction']),
  linkResource: json['linkResource'] == null
      ? ''
      : const SafeText().fromJson(json['linkResource']),
  metadataDate: const SafeDate().fromJson(json['metadataDate']),
  repository: json['repository'] == null
      ? ''
      : const SafeText().fromJson(json['repository']),
  objectUrl: json['objectURL'] == null
      ? ''
      : const SafeText().fromJson(json['objectURL']),
  tags: json['tags'] == null ? const <ObjectTag>[] : _readTags(json['tags']),
  objectWikidataUrl: json['objectWikidata_URL'] == null
      ? ''
      : const SafeText().fromJson(json['objectWikidata_URL']),
  isTimelineWork: json['isTimelineWork'] == null
      ? false
      : const SafeBool().fromJson(json['isTimelineWork']),
  galleryNumber: json['GalleryNumber'] == null
      ? ''
      : const SafeText().fromJson(json['GalleryNumber']),
);

_ObjectConstituent _$ObjectConstituentFromJson(Map<String, dynamic> json) =>
    _ObjectConstituent(
      constituentId: const SafeInt().fromJson(json['constituentID']),
      role: json['role'] == null ? '' : const SafeText().fromJson(json['role']),
      name: json['name'] == null ? '' : const SafeText().fromJson(json['name']),
      ulanUrl: json['constituentULAN_URL'] == null
          ? ''
          : const SafeText().fromJson(json['constituentULAN_URL']),
      wikidataUrl: json['constituentWikidata_URL'] == null
          ? ''
          : const SafeText().fromJson(json['constituentWikidata_URL']),
      gender: json['gender'] == null
          ? ''
          : const SafeText().fromJson(json['gender']),
    );

_ObjectMeasurement _$ObjectMeasurementFromJson(Map<String, dynamic> json) =>
    _ObjectMeasurement(
      elementName: json['elementName'] == null
          ? ''
          : const SafeText().fromJson(json['elementName']),
      elementDescription: json['elementDescription'] == null
          ? ''
          : const SafeText().fromJson(json['elementDescription']),
      elementMeasurements: json['elementMeasurements'] == null
          ? const <String, double>{}
          : _readAmounts(json['elementMeasurements']),
    );

_ObjectDimension _$ObjectDimensionFromJson(Map<String, dynamic> json) =>
    _ObjectDimension(
      element: json['element'] == null
          ? ''
          : const SafeText().fromJson(json['element']),
      dimensionType: json['dimensionType'] == null
          ? ''
          : const SafeText().fromJson(json['dimensionType']),
      dimension: const SafeDouble().fromJson(json['dimension']),
    );

_ObjectTag _$ObjectTagFromJson(Map<String, dynamic> json) => _ObjectTag(
  term: json['term'] == null ? '' : const SafeText().fromJson(json['term']),
  aatUrl: json['AAT_URL'] == null
      ? ''
      : const SafeText().fromJson(json['AAT_URL']),
  wikidataUrl: json['Wikidata_URL'] == null
      ? ''
      : const SafeText().fromJson(json['Wikidata_URL']),
);
