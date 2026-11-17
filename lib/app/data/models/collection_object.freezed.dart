// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collection_object.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CollectionObject {

/// `objectID`. Unique; the key of a record.
@JsonKey(name: 'objectID', fromJson: requiredJsonId) int get objectId;/// A popular and important work in the collection.
 bool get isHighlight;/// Not always unique. "67.241".
 String get accessionNumber;/// The year the work was acquired, as text. "1921".
 String get accessionYear; bool get isPublicDomain;/// Full-resolution JPEG. Empty when the image is not open access.
 String get primaryImage;/// Lower-resolution JPEG. Empty when the image is not open access.
 String get primaryImageSmall;@JsonKey(fromJson: _readTexts) List<String> get additionalImages;@JsonKey(fromJson: _readConstituents) List<ObjectConstituent> get constituents;/// The curatorial department responsible. "Egyptian Art".
 String get department;/// The physical type of the object. "Dress", "Painting", "Vase".
 String get objectName; String get title;/// "Afghan", "British", "North African".
 String get culture;/// "Ming dynasty (1368-1644)", "Middle Bronze Age".
 String get period;/// "Kingdom of Benin", "Dynasty 12".
 String get dynasty;/// "Amenhotep III", "Louis XVI".
 String get reign;/// A set of works made as a group. "Birds of America".
 String get portfolio;/// "Artist for Painting", "Designer for Dress".
 String get artistRole;/// An attribution qualifier. "In the Style of", "Possibly by".
 String get artistPrefix;/// The artist's name in display order. "Vincent van Gogh".
 String get artistDisplayName;/// "Dutch, Zundert 1853–1890 Auvers-sur-Oise".
 String get artistDisplayBio;/// "verso only".
 String get artistSuffix;/// The name in sorting order. "Gogh, Vincent van".
 String get artistAlphaSort;/// "Spanish", "French, born Romania".
 String get artistNationality;/// The year the artist was born, as text. "1840".
 String get artistBeginDate;/// The year the artist died, as text. "1926".
 String get artistEndDate;/// Currently holds female designations only.
 String get artistGender;/// `artistWikidata_URL`.
@JsonKey(name: 'artistWikidata_URL') String get artistWikidataUrl;/// `artistULAN_URL`.
@JsonKey(name: 'artistULAN_URL') String get artistUlanUrl;/// When the work was made, for display. "1865–67", "ca. 1796".
 String get objectDate;/// The year the work was begun, machine readable. Negative is BC.
 int? get objectBeginDate;/// The year the work was completed, machine readable. Negative is BC.
 int? get objectEndDate;/// "Oil on canvas", "Watercolor", "Gold".
 String get medium;/// For display. "16 x 20 in. (40.6 x 50.8 cm)".
 String get dimensions;/// Documented, but absent from the records the API serves today.
@JsonKey(fromJson: _readDimensions) List<ObjectDimension> get dimensionsParsed;@JsonKey(fromJson: _readMeasurements) List<ObjectMeasurement> get measurements;/// "Robert Lehman Collection, 1975".
 String get creditLine;/// How the place fields relate to the object. "Made in", "From".
 String get geographyType; String get city;/// State or province. May overlap with [county].
 String get state; String get county; String get country;/// More specific than [country]. "Bohemia", "Midwest".
 String get region;/// More specific than [region]. "Valley of the Kings".
 String get subregion;/// More specific than [subregion]. "Tomb of Perneb".
 String get locale;/// More specific than [locale]. "1st chamber W. wall".
 String get locus;/// "MMA excavations, 1923–24".
 String get excavation; String get river;/// A general term for the type of work. "Ceramics", "Paintings".
 String get classification;/// The credit line for works still under copyright.
 String get rightsAndReproduction;/// The object's page on metmuseum.org. Often empty; see [objectUrl].
 String get linkResource;/// When the record was last updated.
 DateTime? get metadataDate;/// "Metropolitan Museum of Art, New York, NY".
 String get repository;/// `objectURL`. The object's page on metmuseum.org.
@JsonKey(name: 'objectURL') String get objectUrl;@JsonKey(fromJson: _readTags) List<ObjectTag> get tags;/// `objectWikidata_URL`.
@JsonKey(name: 'objectWikidata_URL') String get objectWikidataUrl;/// Whether the object is on the Timeline of Art History website.
 bool get isTimelineWork;/// `GalleryNumber`. Where the work is on view, when it is. "131".
@JsonKey(name: 'GalleryNumber') String get galleryNumber;
/// Create a copy of CollectionObject
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CollectionObjectCopyWith<CollectionObject> get copyWith => _$CollectionObjectCopyWithImpl<CollectionObject>(this as CollectionObject, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CollectionObject;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CollectionObject&&(identical(other.objectId, _this.objectId) || other.objectId == _this.objectId)&&(identical(other.isHighlight, _this.isHighlight) || other.isHighlight == _this.isHighlight)&&(identical(other.accessionNumber, _this.accessionNumber) || other.accessionNumber == _this.accessionNumber)&&(identical(other.accessionYear, _this.accessionYear) || other.accessionYear == _this.accessionYear)&&(identical(other.isPublicDomain, _this.isPublicDomain) || other.isPublicDomain == _this.isPublicDomain)&&(identical(other.primaryImage, _this.primaryImage) || other.primaryImage == _this.primaryImage)&&(identical(other.primaryImageSmall, _this.primaryImageSmall) || other.primaryImageSmall == _this.primaryImageSmall)&&const DeepCollectionEquality().equals(other.additionalImages, _this.additionalImages)&&const DeepCollectionEquality().equals(other.constituents, _this.constituents)&&(identical(other.department, _this.department) || other.department == _this.department)&&(identical(other.objectName, _this.objectName) || other.objectName == _this.objectName)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.culture, _this.culture) || other.culture == _this.culture)&&(identical(other.period, _this.period) || other.period == _this.period)&&(identical(other.dynasty, _this.dynasty) || other.dynasty == _this.dynasty)&&(identical(other.reign, _this.reign) || other.reign == _this.reign)&&(identical(other.portfolio, _this.portfolio) || other.portfolio == _this.portfolio)&&(identical(other.artistRole, _this.artistRole) || other.artistRole == _this.artistRole)&&(identical(other.artistPrefix, _this.artistPrefix) || other.artistPrefix == _this.artistPrefix)&&(identical(other.artistDisplayName, _this.artistDisplayName) || other.artistDisplayName == _this.artistDisplayName)&&(identical(other.artistDisplayBio, _this.artistDisplayBio) || other.artistDisplayBio == _this.artistDisplayBio)&&(identical(other.artistSuffix, _this.artistSuffix) || other.artistSuffix == _this.artistSuffix)&&(identical(other.artistAlphaSort, _this.artistAlphaSort) || other.artistAlphaSort == _this.artistAlphaSort)&&(identical(other.artistNationality, _this.artistNationality) || other.artistNationality == _this.artistNationality)&&(identical(other.artistBeginDate, _this.artistBeginDate) || other.artistBeginDate == _this.artistBeginDate)&&(identical(other.artistEndDate, _this.artistEndDate) || other.artistEndDate == _this.artistEndDate)&&(identical(other.artistGender, _this.artistGender) || other.artistGender == _this.artistGender)&&(identical(other.artistWikidataUrl, _this.artistWikidataUrl) || other.artistWikidataUrl == _this.artistWikidataUrl)&&(identical(other.artistUlanUrl, _this.artistUlanUrl) || other.artistUlanUrl == _this.artistUlanUrl)&&(identical(other.objectDate, _this.objectDate) || other.objectDate == _this.objectDate)&&(identical(other.objectBeginDate, _this.objectBeginDate) || other.objectBeginDate == _this.objectBeginDate)&&(identical(other.objectEndDate, _this.objectEndDate) || other.objectEndDate == _this.objectEndDate)&&(identical(other.medium, _this.medium) || other.medium == _this.medium)&&(identical(other.dimensions, _this.dimensions) || other.dimensions == _this.dimensions)&&const DeepCollectionEquality().equals(other.dimensionsParsed, _this.dimensionsParsed)&&const DeepCollectionEquality().equals(other.measurements, _this.measurements)&&(identical(other.creditLine, _this.creditLine) || other.creditLine == _this.creditLine)&&(identical(other.geographyType, _this.geographyType) || other.geographyType == _this.geographyType)&&(identical(other.city, _this.city) || other.city == _this.city)&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.county, _this.county) || other.county == _this.county)&&(identical(other.country, _this.country) || other.country == _this.country)&&(identical(other.region, _this.region) || other.region == _this.region)&&(identical(other.subregion, _this.subregion) || other.subregion == _this.subregion)&&(identical(other.locale, _this.locale) || other.locale == _this.locale)&&(identical(other.locus, _this.locus) || other.locus == _this.locus)&&(identical(other.excavation, _this.excavation) || other.excavation == _this.excavation)&&(identical(other.river, _this.river) || other.river == _this.river)&&(identical(other.classification, _this.classification) || other.classification == _this.classification)&&(identical(other.rightsAndReproduction, _this.rightsAndReproduction) || other.rightsAndReproduction == _this.rightsAndReproduction)&&(identical(other.linkResource, _this.linkResource) || other.linkResource == _this.linkResource)&&(identical(other.metadataDate, _this.metadataDate) || other.metadataDate == _this.metadataDate)&&(identical(other.repository, _this.repository) || other.repository == _this.repository)&&(identical(other.objectUrl, _this.objectUrl) || other.objectUrl == _this.objectUrl)&&const DeepCollectionEquality().equals(other.tags, _this.tags)&&(identical(other.objectWikidataUrl, _this.objectWikidataUrl) || other.objectWikidataUrl == _this.objectWikidataUrl)&&(identical(other.isTimelineWork, _this.isTimelineWork) || other.isTimelineWork == _this.isTimelineWork)&&(identical(other.galleryNumber, _this.galleryNumber) || other.galleryNumber == _this.galleryNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as CollectionObject;
  return Object.hashAll([runtimeType,_this.objectId,_this.isHighlight,_this.accessionNumber,_this.accessionYear,_this.isPublicDomain,_this.primaryImage,_this.primaryImageSmall,const DeepCollectionEquality().hash(_this.additionalImages),const DeepCollectionEquality().hash(_this.constituents),_this.department,_this.objectName,_this.title,_this.culture,_this.period,_this.dynasty,_this.reign,_this.portfolio,_this.artistRole,_this.artistPrefix,_this.artistDisplayName,_this.artistDisplayBio,_this.artistSuffix,_this.artistAlphaSort,_this.artistNationality,_this.artistBeginDate,_this.artistEndDate,_this.artistGender,_this.artistWikidataUrl,_this.artistUlanUrl,_this.objectDate,_this.objectBeginDate,_this.objectEndDate,_this.medium,_this.dimensions,const DeepCollectionEquality().hash(_this.dimensionsParsed),const DeepCollectionEquality().hash(_this.measurements),_this.creditLine,_this.geographyType,_this.city,_this.state,_this.county,_this.country,_this.region,_this.subregion,_this.locale,_this.locus,_this.excavation,_this.river,_this.classification,_this.rightsAndReproduction,_this.linkResource,_this.metadataDate,_this.repository,_this.objectUrl,const DeepCollectionEquality().hash(_this.tags),_this.objectWikidataUrl,_this.isTimelineWork,_this.galleryNumber]);
}

@override
String toString() {
  final _this = this as CollectionObject;
  return 'CollectionObject(objectId: ${_this.objectId}, isHighlight: ${_this.isHighlight}, accessionNumber: ${_this.accessionNumber}, accessionYear: ${_this.accessionYear}, isPublicDomain: ${_this.isPublicDomain}, primaryImage: ${_this.primaryImage}, primaryImageSmall: ${_this.primaryImageSmall}, additionalImages: ${_this.additionalImages}, constituents: ${_this.constituents}, department: ${_this.department}, objectName: ${_this.objectName}, title: ${_this.title}, culture: ${_this.culture}, period: ${_this.period}, dynasty: ${_this.dynasty}, reign: ${_this.reign}, portfolio: ${_this.portfolio}, artistRole: ${_this.artistRole}, artistPrefix: ${_this.artistPrefix}, artistDisplayName: ${_this.artistDisplayName}, artistDisplayBio: ${_this.artistDisplayBio}, artistSuffix: ${_this.artistSuffix}, artistAlphaSort: ${_this.artistAlphaSort}, artistNationality: ${_this.artistNationality}, artistBeginDate: ${_this.artistBeginDate}, artistEndDate: ${_this.artistEndDate}, artistGender: ${_this.artistGender}, artistWikidataUrl: ${_this.artistWikidataUrl}, artistUlanUrl: ${_this.artistUlanUrl}, objectDate: ${_this.objectDate}, objectBeginDate: ${_this.objectBeginDate}, objectEndDate: ${_this.objectEndDate}, medium: ${_this.medium}, dimensions: ${_this.dimensions}, dimensionsParsed: ${_this.dimensionsParsed}, measurements: ${_this.measurements}, creditLine: ${_this.creditLine}, geographyType: ${_this.geographyType}, city: ${_this.city}, state: ${_this.state}, county: ${_this.county}, country: ${_this.country}, region: ${_this.region}, subregion: ${_this.subregion}, locale: ${_this.locale}, locus: ${_this.locus}, excavation: ${_this.excavation}, river: ${_this.river}, classification: ${_this.classification}, rightsAndReproduction: ${_this.rightsAndReproduction}, linkResource: ${_this.linkResource}, metadataDate: ${_this.metadataDate}, repository: ${_this.repository}, objectUrl: ${_this.objectUrl}, tags: ${_this.tags}, objectWikidataUrl: ${_this.objectWikidataUrl}, isTimelineWork: ${_this.isTimelineWork}, galleryNumber: ${_this.galleryNumber})';
}


}

/// @nodoc
abstract mixin class $CollectionObjectCopyWith<$Res>  {
  factory $CollectionObjectCopyWith(CollectionObject value, $Res Function(CollectionObject) _then) = _$CollectionObjectCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'objectID', fromJson: requiredJsonId) int objectId, bool isHighlight, String accessionNumber, String accessionYear, bool isPublicDomain, String primaryImage, String primaryImageSmall,@JsonKey(fromJson: _readTexts) List<String> additionalImages,@JsonKey(fromJson: _readConstituents) List<ObjectConstituent> constituents, String department, String objectName, String title, String culture, String period, String dynasty, String reign, String portfolio, String artistRole, String artistPrefix, String artistDisplayName, String artistDisplayBio, String artistSuffix, String artistAlphaSort, String artistNationality, String artistBeginDate, String artistEndDate, String artistGender,@JsonKey(name: 'artistWikidata_URL') String artistWikidataUrl,@JsonKey(name: 'artistULAN_URL') String artistUlanUrl, String objectDate, int? objectBeginDate, int? objectEndDate, String medium, String dimensions,@JsonKey(fromJson: _readDimensions) List<ObjectDimension> dimensionsParsed,@JsonKey(fromJson: _readMeasurements) List<ObjectMeasurement> measurements, String creditLine, String geographyType, String city, String state, String county, String country, String region, String subregion, String locale, String locus, String excavation, String river, String classification, String rightsAndReproduction, String linkResource, DateTime? metadataDate, String repository,@JsonKey(name: 'objectURL') String objectUrl,@JsonKey(fromJson: _readTags) List<ObjectTag> tags,@JsonKey(name: 'objectWikidata_URL') String objectWikidataUrl, bool isTimelineWork,@JsonKey(name: 'GalleryNumber') String galleryNumber
});




}
/// @nodoc
class _$CollectionObjectCopyWithImpl<$Res>
    implements $CollectionObjectCopyWith<$Res> {
  _$CollectionObjectCopyWithImpl(this._self, this._then);

  final CollectionObject _self;
  final $Res Function(CollectionObject) _then;

/// Create a copy of CollectionObject
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? objectId = null,Object? isHighlight = null,Object? accessionNumber = null,Object? accessionYear = null,Object? isPublicDomain = null,Object? primaryImage = null,Object? primaryImageSmall = null,Object? additionalImages = null,Object? constituents = null,Object? department = null,Object? objectName = null,Object? title = null,Object? culture = null,Object? period = null,Object? dynasty = null,Object? reign = null,Object? portfolio = null,Object? artistRole = null,Object? artistPrefix = null,Object? artistDisplayName = null,Object? artistDisplayBio = null,Object? artistSuffix = null,Object? artistAlphaSort = null,Object? artistNationality = null,Object? artistBeginDate = null,Object? artistEndDate = null,Object? artistGender = null,Object? artistWikidataUrl = null,Object? artistUlanUrl = null,Object? objectDate = null,Object? objectBeginDate = freezed,Object? objectEndDate = freezed,Object? medium = null,Object? dimensions = null,Object? dimensionsParsed = null,Object? measurements = null,Object? creditLine = null,Object? geographyType = null,Object? city = null,Object? state = null,Object? county = null,Object? country = null,Object? region = null,Object? subregion = null,Object? locale = null,Object? locus = null,Object? excavation = null,Object? river = null,Object? classification = null,Object? rightsAndReproduction = null,Object? linkResource = null,Object? metadataDate = freezed,Object? repository = null,Object? objectUrl = null,Object? tags = null,Object? objectWikidataUrl = null,Object? isTimelineWork = null,Object? galleryNumber = null,}) {
  return _then(CollectionObject(
objectId: null == objectId ? _self.objectId : objectId // ignore: cast_nullable_to_non_nullable
as int,isHighlight: null == isHighlight ? _self.isHighlight : isHighlight // ignore: cast_nullable_to_non_nullable
as bool,accessionNumber: null == accessionNumber ? _self.accessionNumber : accessionNumber // ignore: cast_nullable_to_non_nullable
as String,accessionYear: null == accessionYear ? _self.accessionYear : accessionYear // ignore: cast_nullable_to_non_nullable
as String,isPublicDomain: null == isPublicDomain ? _self.isPublicDomain : isPublicDomain // ignore: cast_nullable_to_non_nullable
as bool,primaryImage: null == primaryImage ? _self.primaryImage : primaryImage // ignore: cast_nullable_to_non_nullable
as String,primaryImageSmall: null == primaryImageSmall ? _self.primaryImageSmall : primaryImageSmall // ignore: cast_nullable_to_non_nullable
as String,additionalImages: null == additionalImages ? _self.additionalImages : additionalImages // ignore: cast_nullable_to_non_nullable
as List<String>,constituents: null == constituents ? _self.constituents : constituents // ignore: cast_nullable_to_non_nullable
as List<ObjectConstituent>,department: null == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String,objectName: null == objectName ? _self.objectName : objectName // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,culture: null == culture ? _self.culture : culture // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,dynasty: null == dynasty ? _self.dynasty : dynasty // ignore: cast_nullable_to_non_nullable
as String,reign: null == reign ? _self.reign : reign // ignore: cast_nullable_to_non_nullable
as String,portfolio: null == portfolio ? _self.portfolio : portfolio // ignore: cast_nullable_to_non_nullable
as String,artistRole: null == artistRole ? _self.artistRole : artistRole // ignore: cast_nullable_to_non_nullable
as String,artistPrefix: null == artistPrefix ? _self.artistPrefix : artistPrefix // ignore: cast_nullable_to_non_nullable
as String,artistDisplayName: null == artistDisplayName ? _self.artistDisplayName : artistDisplayName // ignore: cast_nullable_to_non_nullable
as String,artistDisplayBio: null == artistDisplayBio ? _self.artistDisplayBio : artistDisplayBio // ignore: cast_nullable_to_non_nullable
as String,artistSuffix: null == artistSuffix ? _self.artistSuffix : artistSuffix // ignore: cast_nullable_to_non_nullable
as String,artistAlphaSort: null == artistAlphaSort ? _self.artistAlphaSort : artistAlphaSort // ignore: cast_nullable_to_non_nullable
as String,artistNationality: null == artistNationality ? _self.artistNationality : artistNationality // ignore: cast_nullable_to_non_nullable
as String,artistBeginDate: null == artistBeginDate ? _self.artistBeginDate : artistBeginDate // ignore: cast_nullable_to_non_nullable
as String,artistEndDate: null == artistEndDate ? _self.artistEndDate : artistEndDate // ignore: cast_nullable_to_non_nullable
as String,artistGender: null == artistGender ? _self.artistGender : artistGender // ignore: cast_nullable_to_non_nullable
as String,artistWikidataUrl: null == artistWikidataUrl ? _self.artistWikidataUrl : artistWikidataUrl // ignore: cast_nullable_to_non_nullable
as String,artistUlanUrl: null == artistUlanUrl ? _self.artistUlanUrl : artistUlanUrl // ignore: cast_nullable_to_non_nullable
as String,objectDate: null == objectDate ? _self.objectDate : objectDate // ignore: cast_nullable_to_non_nullable
as String,objectBeginDate: freezed == objectBeginDate ? _self.objectBeginDate : objectBeginDate // ignore: cast_nullable_to_non_nullable
as int?,objectEndDate: freezed == objectEndDate ? _self.objectEndDate : objectEndDate // ignore: cast_nullable_to_non_nullable
as int?,medium: null == medium ? _self.medium : medium // ignore: cast_nullable_to_non_nullable
as String,dimensions: null == dimensions ? _self.dimensions : dimensions // ignore: cast_nullable_to_non_nullable
as String,dimensionsParsed: null == dimensionsParsed ? _self.dimensionsParsed : dimensionsParsed // ignore: cast_nullable_to_non_nullable
as List<ObjectDimension>,measurements: null == measurements ? _self.measurements : measurements // ignore: cast_nullable_to_non_nullable
as List<ObjectMeasurement>,creditLine: null == creditLine ? _self.creditLine : creditLine // ignore: cast_nullable_to_non_nullable
as String,geographyType: null == geographyType ? _self.geographyType : geographyType // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,county: null == county ? _self.county : county // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,subregion: null == subregion ? _self.subregion : subregion // ignore: cast_nullable_to_non_nullable
as String,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,locus: null == locus ? _self.locus : locus // ignore: cast_nullable_to_non_nullable
as String,excavation: null == excavation ? _self.excavation : excavation // ignore: cast_nullable_to_non_nullable
as String,river: null == river ? _self.river : river // ignore: cast_nullable_to_non_nullable
as String,classification: null == classification ? _self.classification : classification // ignore: cast_nullable_to_non_nullable
as String,rightsAndReproduction: null == rightsAndReproduction ? _self.rightsAndReproduction : rightsAndReproduction // ignore: cast_nullable_to_non_nullable
as String,linkResource: null == linkResource ? _self.linkResource : linkResource // ignore: cast_nullable_to_non_nullable
as String,metadataDate: freezed == metadataDate ? _self.metadataDate : metadataDate // ignore: cast_nullable_to_non_nullable
as DateTime?,repository: null == repository ? _self.repository : repository // ignore: cast_nullable_to_non_nullable
as String,objectUrl: null == objectUrl ? _self.objectUrl : objectUrl // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<ObjectTag>,objectWikidataUrl: null == objectWikidataUrl ? _self.objectWikidataUrl : objectWikidataUrl // ignore: cast_nullable_to_non_nullable
as String,isTimelineWork: null == isTimelineWork ? _self.isTimelineWork : isTimelineWork // ignore: cast_nullable_to_non_nullable
as bool,galleryNumber: null == galleryNumber ? _self.galleryNumber : galleryNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CollectionObject].
extension CollectionObjectPatterns on CollectionObject {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CollectionObject value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CollectionObject() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CollectionObject value)  $default,){
final _that = this;
switch (_that) {
case _CollectionObject():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CollectionObject value)?  $default,){
final _that = this;
switch (_that) {
case _CollectionObject() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'objectID', fromJson: requiredJsonId)  int objectId,  bool isHighlight,  String accessionNumber,  String accessionYear,  bool isPublicDomain,  String primaryImage,  String primaryImageSmall, @JsonKey(fromJson: _readTexts)  List<String> additionalImages, @JsonKey(fromJson: _readConstituents)  List<ObjectConstituent> constituents,  String department,  String objectName,  String title,  String culture,  String period,  String dynasty,  String reign,  String portfolio,  String artistRole,  String artistPrefix,  String artistDisplayName,  String artistDisplayBio,  String artistSuffix,  String artistAlphaSort,  String artistNationality,  String artistBeginDate,  String artistEndDate,  String artistGender, @JsonKey(name: 'artistWikidata_URL')  String artistWikidataUrl, @JsonKey(name: 'artistULAN_URL')  String artistUlanUrl,  String objectDate,  int? objectBeginDate,  int? objectEndDate,  String medium,  String dimensions, @JsonKey(fromJson: _readDimensions)  List<ObjectDimension> dimensionsParsed, @JsonKey(fromJson: _readMeasurements)  List<ObjectMeasurement> measurements,  String creditLine,  String geographyType,  String city,  String state,  String county,  String country,  String region,  String subregion,  String locale,  String locus,  String excavation,  String river,  String classification,  String rightsAndReproduction,  String linkResource,  DateTime? metadataDate,  String repository, @JsonKey(name: 'objectURL')  String objectUrl, @JsonKey(fromJson: _readTags)  List<ObjectTag> tags, @JsonKey(name: 'objectWikidata_URL')  String objectWikidataUrl,  bool isTimelineWork, @JsonKey(name: 'GalleryNumber')  String galleryNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CollectionObject() when $default != null:
return $default(_that.objectId,_that.isHighlight,_that.accessionNumber,_that.accessionYear,_that.isPublicDomain,_that.primaryImage,_that.primaryImageSmall,_that.additionalImages,_that.constituents,_that.department,_that.objectName,_that.title,_that.culture,_that.period,_that.dynasty,_that.reign,_that.portfolio,_that.artistRole,_that.artistPrefix,_that.artistDisplayName,_that.artistDisplayBio,_that.artistSuffix,_that.artistAlphaSort,_that.artistNationality,_that.artistBeginDate,_that.artistEndDate,_that.artistGender,_that.artistWikidataUrl,_that.artistUlanUrl,_that.objectDate,_that.objectBeginDate,_that.objectEndDate,_that.medium,_that.dimensions,_that.dimensionsParsed,_that.measurements,_that.creditLine,_that.geographyType,_that.city,_that.state,_that.county,_that.country,_that.region,_that.subregion,_that.locale,_that.locus,_that.excavation,_that.river,_that.classification,_that.rightsAndReproduction,_that.linkResource,_that.metadataDate,_that.repository,_that.objectUrl,_that.tags,_that.objectWikidataUrl,_that.isTimelineWork,_that.galleryNumber);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'objectID', fromJson: requiredJsonId)  int objectId,  bool isHighlight,  String accessionNumber,  String accessionYear,  bool isPublicDomain,  String primaryImage,  String primaryImageSmall, @JsonKey(fromJson: _readTexts)  List<String> additionalImages, @JsonKey(fromJson: _readConstituents)  List<ObjectConstituent> constituents,  String department,  String objectName,  String title,  String culture,  String period,  String dynasty,  String reign,  String portfolio,  String artistRole,  String artistPrefix,  String artistDisplayName,  String artistDisplayBio,  String artistSuffix,  String artistAlphaSort,  String artistNationality,  String artistBeginDate,  String artistEndDate,  String artistGender, @JsonKey(name: 'artistWikidata_URL')  String artistWikidataUrl, @JsonKey(name: 'artistULAN_URL')  String artistUlanUrl,  String objectDate,  int? objectBeginDate,  int? objectEndDate,  String medium,  String dimensions, @JsonKey(fromJson: _readDimensions)  List<ObjectDimension> dimensionsParsed, @JsonKey(fromJson: _readMeasurements)  List<ObjectMeasurement> measurements,  String creditLine,  String geographyType,  String city,  String state,  String county,  String country,  String region,  String subregion,  String locale,  String locus,  String excavation,  String river,  String classification,  String rightsAndReproduction,  String linkResource,  DateTime? metadataDate,  String repository, @JsonKey(name: 'objectURL')  String objectUrl, @JsonKey(fromJson: _readTags)  List<ObjectTag> tags, @JsonKey(name: 'objectWikidata_URL')  String objectWikidataUrl,  bool isTimelineWork, @JsonKey(name: 'GalleryNumber')  String galleryNumber)  $default,) {final _that = this;
switch (_that) {
case _CollectionObject():
return $default(_that.objectId,_that.isHighlight,_that.accessionNumber,_that.accessionYear,_that.isPublicDomain,_that.primaryImage,_that.primaryImageSmall,_that.additionalImages,_that.constituents,_that.department,_that.objectName,_that.title,_that.culture,_that.period,_that.dynasty,_that.reign,_that.portfolio,_that.artistRole,_that.artistPrefix,_that.artistDisplayName,_that.artistDisplayBio,_that.artistSuffix,_that.artistAlphaSort,_that.artistNationality,_that.artistBeginDate,_that.artistEndDate,_that.artistGender,_that.artistWikidataUrl,_that.artistUlanUrl,_that.objectDate,_that.objectBeginDate,_that.objectEndDate,_that.medium,_that.dimensions,_that.dimensionsParsed,_that.measurements,_that.creditLine,_that.geographyType,_that.city,_that.state,_that.county,_that.country,_that.region,_that.subregion,_that.locale,_that.locus,_that.excavation,_that.river,_that.classification,_that.rightsAndReproduction,_that.linkResource,_that.metadataDate,_that.repository,_that.objectUrl,_that.tags,_that.objectWikidataUrl,_that.isTimelineWork,_that.galleryNumber);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'objectID', fromJson: requiredJsonId)  int objectId,  bool isHighlight,  String accessionNumber,  String accessionYear,  bool isPublicDomain,  String primaryImage,  String primaryImageSmall, @JsonKey(fromJson: _readTexts)  List<String> additionalImages, @JsonKey(fromJson: _readConstituents)  List<ObjectConstituent> constituents,  String department,  String objectName,  String title,  String culture,  String period,  String dynasty,  String reign,  String portfolio,  String artistRole,  String artistPrefix,  String artistDisplayName,  String artistDisplayBio,  String artistSuffix,  String artistAlphaSort,  String artistNationality,  String artistBeginDate,  String artistEndDate,  String artistGender, @JsonKey(name: 'artistWikidata_URL')  String artistWikidataUrl, @JsonKey(name: 'artistULAN_URL')  String artistUlanUrl,  String objectDate,  int? objectBeginDate,  int? objectEndDate,  String medium,  String dimensions, @JsonKey(fromJson: _readDimensions)  List<ObjectDimension> dimensionsParsed, @JsonKey(fromJson: _readMeasurements)  List<ObjectMeasurement> measurements,  String creditLine,  String geographyType,  String city,  String state,  String county,  String country,  String region,  String subregion,  String locale,  String locus,  String excavation,  String river,  String classification,  String rightsAndReproduction,  String linkResource,  DateTime? metadataDate,  String repository, @JsonKey(name: 'objectURL')  String objectUrl, @JsonKey(fromJson: _readTags)  List<ObjectTag> tags, @JsonKey(name: 'objectWikidata_URL')  String objectWikidataUrl,  bool isTimelineWork, @JsonKey(name: 'GalleryNumber')  String galleryNumber)?  $default,) {final _that = this;
switch (_that) {
case _CollectionObject() when $default != null:
return $default(_that.objectId,_that.isHighlight,_that.accessionNumber,_that.accessionYear,_that.isPublicDomain,_that.primaryImage,_that.primaryImageSmall,_that.additionalImages,_that.constituents,_that.department,_that.objectName,_that.title,_that.culture,_that.period,_that.dynasty,_that.reign,_that.portfolio,_that.artistRole,_that.artistPrefix,_that.artistDisplayName,_that.artistDisplayBio,_that.artistSuffix,_that.artistAlphaSort,_that.artistNationality,_that.artistBeginDate,_that.artistEndDate,_that.artistGender,_that.artistWikidataUrl,_that.artistUlanUrl,_that.objectDate,_that.objectBeginDate,_that.objectEndDate,_that.medium,_that.dimensions,_that.dimensionsParsed,_that.measurements,_that.creditLine,_that.geographyType,_that.city,_that.state,_that.county,_that.country,_that.region,_that.subregion,_that.locale,_that.locus,_that.excavation,_that.river,_that.classification,_that.rightsAndReproduction,_that.linkResource,_that.metadataDate,_that.repository,_that.objectUrl,_that.tags,_that.objectWikidataUrl,_that.isTimelineWork,_that.galleryNumber);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(createToJson: false, converters: safeConverters)
class _CollectionObject implements CollectionObject {
  const _CollectionObject({@JsonKey(name: 'objectID', fromJson: requiredJsonId) required this.objectId, this.isHighlight = false, this.accessionNumber = '', this.accessionYear = '', this.isPublicDomain = false, this.primaryImage = '', this.primaryImageSmall = '', @JsonKey(fromJson: _readTexts)  List<String> additionalImages = const <String>[], @JsonKey(fromJson: _readConstituents)  List<ObjectConstituent> constituents = const <ObjectConstituent>[], this.department = '', this.objectName = '', this.title = '', this.culture = '', this.period = '', this.dynasty = '', this.reign = '', this.portfolio = '', this.artistRole = '', this.artistPrefix = '', this.artistDisplayName = '', this.artistDisplayBio = '', this.artistSuffix = '', this.artistAlphaSort = '', this.artistNationality = '', this.artistBeginDate = '', this.artistEndDate = '', this.artistGender = '', @JsonKey(name: 'artistWikidata_URL') this.artistWikidataUrl = '', @JsonKey(name: 'artistULAN_URL') this.artistUlanUrl = '', this.objectDate = '', this.objectBeginDate, this.objectEndDate, this.medium = '', this.dimensions = '', @JsonKey(fromJson: _readDimensions)  List<ObjectDimension> dimensionsParsed = const <ObjectDimension>[], @JsonKey(fromJson: _readMeasurements)  List<ObjectMeasurement> measurements = const <ObjectMeasurement>[], this.creditLine = '', this.geographyType = '', this.city = '', this.state = '', this.county = '', this.country = '', this.region = '', this.subregion = '', this.locale = '', this.locus = '', this.excavation = '', this.river = '', this.classification = '', this.rightsAndReproduction = '', this.linkResource = '', this.metadataDate, this.repository = '', @JsonKey(name: 'objectURL') this.objectUrl = '', @JsonKey(fromJson: _readTags)  List<ObjectTag> tags = const <ObjectTag>[], @JsonKey(name: 'objectWikidata_URL') this.objectWikidataUrl = '', this.isTimelineWork = false, @JsonKey(name: 'GalleryNumber') this.galleryNumber = ''}): _additionalImages = additionalImages,_constituents = constituents,_dimensionsParsed = dimensionsParsed,_measurements = measurements,_tags = tags;
  factory _CollectionObject.fromJson(Map<String, dynamic> json) => _$CollectionObjectFromJson(json);

/// `objectID`. Unique; the key of a record.
@override@JsonKey(name: 'objectID', fromJson: requiredJsonId) final  int objectId;
/// A popular and important work in the collection.
@override@JsonKey() final  bool isHighlight;
/// Not always unique. "67.241".
@override@JsonKey() final  String accessionNumber;
/// The year the work was acquired, as text. "1921".
@override@JsonKey() final  String accessionYear;
@override@JsonKey() final  bool isPublicDomain;
/// Full-resolution JPEG. Empty when the image is not open access.
@override@JsonKey() final  String primaryImage;
/// Lower-resolution JPEG. Empty when the image is not open access.
@override@JsonKey() final  String primaryImageSmall;
 final  List<String> _additionalImages;
@override@JsonKey(fromJson: _readTexts) List<String> get additionalImages {
  if (_additionalImages is EqualUnmodifiableListView) return _additionalImages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_additionalImages);
}

 final  List<ObjectConstituent> _constituents;
@override@JsonKey(fromJson: _readConstituents) List<ObjectConstituent> get constituents {
  if (_constituents is EqualUnmodifiableListView) return _constituents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_constituents);
}

/// The curatorial department responsible. "Egyptian Art".
@override@JsonKey() final  String department;
/// The physical type of the object. "Dress", "Painting", "Vase".
@override@JsonKey() final  String objectName;
@override@JsonKey() final  String title;
/// "Afghan", "British", "North African".
@override@JsonKey() final  String culture;
/// "Ming dynasty (1368-1644)", "Middle Bronze Age".
@override@JsonKey() final  String period;
/// "Kingdom of Benin", "Dynasty 12".
@override@JsonKey() final  String dynasty;
/// "Amenhotep III", "Louis XVI".
@override@JsonKey() final  String reign;
/// A set of works made as a group. "Birds of America".
@override@JsonKey() final  String portfolio;
/// "Artist for Painting", "Designer for Dress".
@override@JsonKey() final  String artistRole;
/// An attribution qualifier. "In the Style of", "Possibly by".
@override@JsonKey() final  String artistPrefix;
/// The artist's name in display order. "Vincent van Gogh".
@override@JsonKey() final  String artistDisplayName;
/// "Dutch, Zundert 1853–1890 Auvers-sur-Oise".
@override@JsonKey() final  String artistDisplayBio;
/// "verso only".
@override@JsonKey() final  String artistSuffix;
/// The name in sorting order. "Gogh, Vincent van".
@override@JsonKey() final  String artistAlphaSort;
/// "Spanish", "French, born Romania".
@override@JsonKey() final  String artistNationality;
/// The year the artist was born, as text. "1840".
@override@JsonKey() final  String artistBeginDate;
/// The year the artist died, as text. "1926".
@override@JsonKey() final  String artistEndDate;
/// Currently holds female designations only.
@override@JsonKey() final  String artistGender;
/// `artistWikidata_URL`.
@override@JsonKey(name: 'artistWikidata_URL') final  String artistWikidataUrl;
/// `artistULAN_URL`.
@override@JsonKey(name: 'artistULAN_URL') final  String artistUlanUrl;
/// When the work was made, for display. "1865–67", "ca. 1796".
@override@JsonKey() final  String objectDate;
/// The year the work was begun, machine readable. Negative is BC.
@override final  int? objectBeginDate;
/// The year the work was completed, machine readable. Negative is BC.
@override final  int? objectEndDate;
/// "Oil on canvas", "Watercolor", "Gold".
@override@JsonKey() final  String medium;
/// For display. "16 x 20 in. (40.6 x 50.8 cm)".
@override@JsonKey() final  String dimensions;
/// Documented, but absent from the records the API serves today.
 final  List<ObjectDimension> _dimensionsParsed;
/// Documented, but absent from the records the API serves today.
@override@JsonKey(fromJson: _readDimensions) List<ObjectDimension> get dimensionsParsed {
  if (_dimensionsParsed is EqualUnmodifiableListView) return _dimensionsParsed;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dimensionsParsed);
}

 final  List<ObjectMeasurement> _measurements;
@override@JsonKey(fromJson: _readMeasurements) List<ObjectMeasurement> get measurements {
  if (_measurements is EqualUnmodifiableListView) return _measurements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_measurements);
}

/// "Robert Lehman Collection, 1975".
@override@JsonKey() final  String creditLine;
/// How the place fields relate to the object. "Made in", "From".
@override@JsonKey() final  String geographyType;
@override@JsonKey() final  String city;
/// State or province. May overlap with [county].
@override@JsonKey() final  String state;
@override@JsonKey() final  String county;
@override@JsonKey() final  String country;
/// More specific than [country]. "Bohemia", "Midwest".
@override@JsonKey() final  String region;
/// More specific than [region]. "Valley of the Kings".
@override@JsonKey() final  String subregion;
/// More specific than [subregion]. "Tomb of Perneb".
@override@JsonKey() final  String locale;
/// More specific than [locale]. "1st chamber W. wall".
@override@JsonKey() final  String locus;
/// "MMA excavations, 1923–24".
@override@JsonKey() final  String excavation;
@override@JsonKey() final  String river;
/// A general term for the type of work. "Ceramics", "Paintings".
@override@JsonKey() final  String classification;
/// The credit line for works still under copyright.
@override@JsonKey() final  String rightsAndReproduction;
/// The object's page on metmuseum.org. Often empty; see [objectUrl].
@override@JsonKey() final  String linkResource;
/// When the record was last updated.
@override final  DateTime? metadataDate;
/// "Metropolitan Museum of Art, New York, NY".
@override@JsonKey() final  String repository;
/// `objectURL`. The object's page on metmuseum.org.
@override@JsonKey(name: 'objectURL') final  String objectUrl;
 final  List<ObjectTag> _tags;
@override@JsonKey(fromJson: _readTags) List<ObjectTag> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

/// `objectWikidata_URL`.
@override@JsonKey(name: 'objectWikidata_URL') final  String objectWikidataUrl;
/// Whether the object is on the Timeline of Art History website.
@override@JsonKey() final  bool isTimelineWork;
/// `GalleryNumber`. Where the work is on view, when it is. "131".
@override@JsonKey(name: 'GalleryNumber') final  String galleryNumber;

/// Create a copy of CollectionObject
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CollectionObjectCopyWith<_CollectionObject> get copyWith => __$CollectionObjectCopyWithImpl<_CollectionObject>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CollectionObject&&(identical(other.objectId, objectId) || other.objectId == objectId)&&(identical(other.isHighlight, isHighlight) || other.isHighlight == isHighlight)&&(identical(other.accessionNumber, accessionNumber) || other.accessionNumber == accessionNumber)&&(identical(other.accessionYear, accessionYear) || other.accessionYear == accessionYear)&&(identical(other.isPublicDomain, isPublicDomain) || other.isPublicDomain == isPublicDomain)&&(identical(other.primaryImage, primaryImage) || other.primaryImage == primaryImage)&&(identical(other.primaryImageSmall, primaryImageSmall) || other.primaryImageSmall == primaryImageSmall)&&const DeepCollectionEquality().equals(other.additionalImages, _additionalImages)&&const DeepCollectionEquality().equals(other.constituents, _constituents)&&(identical(other.department, department) || other.department == department)&&(identical(other.objectName, objectName) || other.objectName == objectName)&&(identical(other.title, title) || other.title == title)&&(identical(other.culture, culture) || other.culture == culture)&&(identical(other.period, period) || other.period == period)&&(identical(other.dynasty, dynasty) || other.dynasty == dynasty)&&(identical(other.reign, reign) || other.reign == reign)&&(identical(other.portfolio, portfolio) || other.portfolio == portfolio)&&(identical(other.artistRole, artistRole) || other.artistRole == artistRole)&&(identical(other.artistPrefix, artistPrefix) || other.artistPrefix == artistPrefix)&&(identical(other.artistDisplayName, artistDisplayName) || other.artistDisplayName == artistDisplayName)&&(identical(other.artistDisplayBio, artistDisplayBio) || other.artistDisplayBio == artistDisplayBio)&&(identical(other.artistSuffix, artistSuffix) || other.artistSuffix == artistSuffix)&&(identical(other.artistAlphaSort, artistAlphaSort) || other.artistAlphaSort == artistAlphaSort)&&(identical(other.artistNationality, artistNationality) || other.artistNationality == artistNationality)&&(identical(other.artistBeginDate, artistBeginDate) || other.artistBeginDate == artistBeginDate)&&(identical(other.artistEndDate, artistEndDate) || other.artistEndDate == artistEndDate)&&(identical(other.artistGender, artistGender) || other.artistGender == artistGender)&&(identical(other.artistWikidataUrl, artistWikidataUrl) || other.artistWikidataUrl == artistWikidataUrl)&&(identical(other.artistUlanUrl, artistUlanUrl) || other.artistUlanUrl == artistUlanUrl)&&(identical(other.objectDate, objectDate) || other.objectDate == objectDate)&&(identical(other.objectBeginDate, objectBeginDate) || other.objectBeginDate == objectBeginDate)&&(identical(other.objectEndDate, objectEndDate) || other.objectEndDate == objectEndDate)&&(identical(other.medium, medium) || other.medium == medium)&&(identical(other.dimensions, dimensions) || other.dimensions == dimensions)&&const DeepCollectionEquality().equals(other.dimensionsParsed, _dimensionsParsed)&&const DeepCollectionEquality().equals(other.measurements, _measurements)&&(identical(other.creditLine, creditLine) || other.creditLine == creditLine)&&(identical(other.geographyType, geographyType) || other.geographyType == geographyType)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.county, county) || other.county == county)&&(identical(other.country, country) || other.country == country)&&(identical(other.region, region) || other.region == region)&&(identical(other.subregion, subregion) || other.subregion == subregion)&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.locus, locus) || other.locus == locus)&&(identical(other.excavation, excavation) || other.excavation == excavation)&&(identical(other.river, river) || other.river == river)&&(identical(other.classification, classification) || other.classification == classification)&&(identical(other.rightsAndReproduction, rightsAndReproduction) || other.rightsAndReproduction == rightsAndReproduction)&&(identical(other.linkResource, linkResource) || other.linkResource == linkResource)&&(identical(other.metadataDate, metadataDate) || other.metadataDate == metadataDate)&&(identical(other.repository, repository) || other.repository == repository)&&(identical(other.objectUrl, objectUrl) || other.objectUrl == objectUrl)&&const DeepCollectionEquality().equals(other.tags, _tags)&&(identical(other.objectWikidataUrl, objectWikidataUrl) || other.objectWikidataUrl == objectWikidataUrl)&&(identical(other.isTimelineWork, isTimelineWork) || other.isTimelineWork == isTimelineWork)&&(identical(other.galleryNumber, galleryNumber) || other.galleryNumber == galleryNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hashAll([runtimeType,objectId,isHighlight,accessionNumber,accessionYear,isPublicDomain,primaryImage,primaryImageSmall,const DeepCollectionEquality().hash(_additionalImages),const DeepCollectionEquality().hash(_constituents),department,objectName,title,culture,period,dynasty,reign,portfolio,artistRole,artistPrefix,artistDisplayName,artistDisplayBio,artistSuffix,artistAlphaSort,artistNationality,artistBeginDate,artistEndDate,artistGender,artistWikidataUrl,artistUlanUrl,objectDate,objectBeginDate,objectEndDate,medium,dimensions,const DeepCollectionEquality().hash(_dimensionsParsed),const DeepCollectionEquality().hash(_measurements),creditLine,geographyType,city,state,county,country,region,subregion,locale,locus,excavation,river,classification,rightsAndReproduction,linkResource,metadataDate,repository,objectUrl,const DeepCollectionEquality().hash(_tags),objectWikidataUrl,isTimelineWork,galleryNumber]);
}

@override
String toString() {
    return 'CollectionObject(objectId: $objectId, isHighlight: $isHighlight, accessionNumber: $accessionNumber, accessionYear: $accessionYear, isPublicDomain: $isPublicDomain, primaryImage: $primaryImage, primaryImageSmall: $primaryImageSmall, additionalImages: $additionalImages, constituents: $constituents, department: $department, objectName: $objectName, title: $title, culture: $culture, period: $period, dynasty: $dynasty, reign: $reign, portfolio: $portfolio, artistRole: $artistRole, artistPrefix: $artistPrefix, artistDisplayName: $artistDisplayName, artistDisplayBio: $artistDisplayBio, artistSuffix: $artistSuffix, artistAlphaSort: $artistAlphaSort, artistNationality: $artistNationality, artistBeginDate: $artistBeginDate, artistEndDate: $artistEndDate, artistGender: $artistGender, artistWikidataUrl: $artistWikidataUrl, artistUlanUrl: $artistUlanUrl, objectDate: $objectDate, objectBeginDate: $objectBeginDate, objectEndDate: $objectEndDate, medium: $medium, dimensions: $dimensions, dimensionsParsed: $dimensionsParsed, measurements: $measurements, creditLine: $creditLine, geographyType: $geographyType, city: $city, state: $state, county: $county, country: $country, region: $region, subregion: $subregion, locale: $locale, locus: $locus, excavation: $excavation, river: $river, classification: $classification, rightsAndReproduction: $rightsAndReproduction, linkResource: $linkResource, metadataDate: $metadataDate, repository: $repository, objectUrl: $objectUrl, tags: $tags, objectWikidataUrl: $objectWikidataUrl, isTimelineWork: $isTimelineWork, galleryNumber: $galleryNumber)';
}


}

/// @nodoc
abstract mixin class _$CollectionObjectCopyWith<$Res> implements $CollectionObjectCopyWith<$Res> {
  factory _$CollectionObjectCopyWith(_CollectionObject value, $Res Function(_CollectionObject) _then) = __$CollectionObjectCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'objectID', fromJson: requiredJsonId) int objectId, bool isHighlight, String accessionNumber, String accessionYear, bool isPublicDomain, String primaryImage, String primaryImageSmall,@JsonKey(fromJson: _readTexts) List<String> additionalImages,@JsonKey(fromJson: _readConstituents) List<ObjectConstituent> constituents, String department, String objectName, String title, String culture, String period, String dynasty, String reign, String portfolio, String artistRole, String artistPrefix, String artistDisplayName, String artistDisplayBio, String artistSuffix, String artistAlphaSort, String artistNationality, String artistBeginDate, String artistEndDate, String artistGender,@JsonKey(name: 'artistWikidata_URL') String artistWikidataUrl,@JsonKey(name: 'artistULAN_URL') String artistUlanUrl, String objectDate, int? objectBeginDate, int? objectEndDate, String medium, String dimensions,@JsonKey(fromJson: _readDimensions) List<ObjectDimension> dimensionsParsed,@JsonKey(fromJson: _readMeasurements) List<ObjectMeasurement> measurements, String creditLine, String geographyType, String city, String state, String county, String country, String region, String subregion, String locale, String locus, String excavation, String river, String classification, String rightsAndReproduction, String linkResource, DateTime? metadataDate, String repository,@JsonKey(name: 'objectURL') String objectUrl,@JsonKey(fromJson: _readTags) List<ObjectTag> tags,@JsonKey(name: 'objectWikidata_URL') String objectWikidataUrl, bool isTimelineWork,@JsonKey(name: 'GalleryNumber') String galleryNumber
});




}
/// @nodoc
class __$CollectionObjectCopyWithImpl<$Res>
    implements _$CollectionObjectCopyWith<$Res> {
  __$CollectionObjectCopyWithImpl(this._self, this._then);

  final _CollectionObject _self;
  final $Res Function(_CollectionObject) _then;

/// Create a copy of CollectionObject
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? objectId = null,Object? isHighlight = null,Object? accessionNumber = null,Object? accessionYear = null,Object? isPublicDomain = null,Object? primaryImage = null,Object? primaryImageSmall = null,Object? additionalImages = null,Object? constituents = null,Object? department = null,Object? objectName = null,Object? title = null,Object? culture = null,Object? period = null,Object? dynasty = null,Object? reign = null,Object? portfolio = null,Object? artistRole = null,Object? artistPrefix = null,Object? artistDisplayName = null,Object? artistDisplayBio = null,Object? artistSuffix = null,Object? artistAlphaSort = null,Object? artistNationality = null,Object? artistBeginDate = null,Object? artistEndDate = null,Object? artistGender = null,Object? artistWikidataUrl = null,Object? artistUlanUrl = null,Object? objectDate = null,Object? objectBeginDate = freezed,Object? objectEndDate = freezed,Object? medium = null,Object? dimensions = null,Object? dimensionsParsed = null,Object? measurements = null,Object? creditLine = null,Object? geographyType = null,Object? city = null,Object? state = null,Object? county = null,Object? country = null,Object? region = null,Object? subregion = null,Object? locale = null,Object? locus = null,Object? excavation = null,Object? river = null,Object? classification = null,Object? rightsAndReproduction = null,Object? linkResource = null,Object? metadataDate = freezed,Object? repository = null,Object? objectUrl = null,Object? tags = null,Object? objectWikidataUrl = null,Object? isTimelineWork = null,Object? galleryNumber = null,}) {
  return _then(_CollectionObject(
objectId: null == objectId ? _self.objectId : objectId // ignore: cast_nullable_to_non_nullable
as int,isHighlight: null == isHighlight ? _self.isHighlight : isHighlight // ignore: cast_nullable_to_non_nullable
as bool,accessionNumber: null == accessionNumber ? _self.accessionNumber : accessionNumber // ignore: cast_nullable_to_non_nullable
as String,accessionYear: null == accessionYear ? _self.accessionYear : accessionYear // ignore: cast_nullable_to_non_nullable
as String,isPublicDomain: null == isPublicDomain ? _self.isPublicDomain : isPublicDomain // ignore: cast_nullable_to_non_nullable
as bool,primaryImage: null == primaryImage ? _self.primaryImage : primaryImage // ignore: cast_nullable_to_non_nullable
as String,primaryImageSmall: null == primaryImageSmall ? _self.primaryImageSmall : primaryImageSmall // ignore: cast_nullable_to_non_nullable
as String,additionalImages: null == additionalImages ? _self._additionalImages : additionalImages // ignore: cast_nullable_to_non_nullable
as List<String>,constituents: null == constituents ? _self._constituents : constituents // ignore: cast_nullable_to_non_nullable
as List<ObjectConstituent>,department: null == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String,objectName: null == objectName ? _self.objectName : objectName // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,culture: null == culture ? _self.culture : culture // ignore: cast_nullable_to_non_nullable
as String,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as String,dynasty: null == dynasty ? _self.dynasty : dynasty // ignore: cast_nullable_to_non_nullable
as String,reign: null == reign ? _self.reign : reign // ignore: cast_nullable_to_non_nullable
as String,portfolio: null == portfolio ? _self.portfolio : portfolio // ignore: cast_nullable_to_non_nullable
as String,artistRole: null == artistRole ? _self.artistRole : artistRole // ignore: cast_nullable_to_non_nullable
as String,artistPrefix: null == artistPrefix ? _self.artistPrefix : artistPrefix // ignore: cast_nullable_to_non_nullable
as String,artistDisplayName: null == artistDisplayName ? _self.artistDisplayName : artistDisplayName // ignore: cast_nullable_to_non_nullable
as String,artistDisplayBio: null == artistDisplayBio ? _self.artistDisplayBio : artistDisplayBio // ignore: cast_nullable_to_non_nullable
as String,artistSuffix: null == artistSuffix ? _self.artistSuffix : artistSuffix // ignore: cast_nullable_to_non_nullable
as String,artistAlphaSort: null == artistAlphaSort ? _self.artistAlphaSort : artistAlphaSort // ignore: cast_nullable_to_non_nullable
as String,artistNationality: null == artistNationality ? _self.artistNationality : artistNationality // ignore: cast_nullable_to_non_nullable
as String,artistBeginDate: null == artistBeginDate ? _self.artistBeginDate : artistBeginDate // ignore: cast_nullable_to_non_nullable
as String,artistEndDate: null == artistEndDate ? _self.artistEndDate : artistEndDate // ignore: cast_nullable_to_non_nullable
as String,artistGender: null == artistGender ? _self.artistGender : artistGender // ignore: cast_nullable_to_non_nullable
as String,artistWikidataUrl: null == artistWikidataUrl ? _self.artistWikidataUrl : artistWikidataUrl // ignore: cast_nullable_to_non_nullable
as String,artistUlanUrl: null == artistUlanUrl ? _self.artistUlanUrl : artistUlanUrl // ignore: cast_nullable_to_non_nullable
as String,objectDate: null == objectDate ? _self.objectDate : objectDate // ignore: cast_nullable_to_non_nullable
as String,objectBeginDate: freezed == objectBeginDate ? _self.objectBeginDate : objectBeginDate // ignore: cast_nullable_to_non_nullable
as int?,objectEndDate: freezed == objectEndDate ? _self.objectEndDate : objectEndDate // ignore: cast_nullable_to_non_nullable
as int?,medium: null == medium ? _self.medium : medium // ignore: cast_nullable_to_non_nullable
as String,dimensions: null == dimensions ? _self.dimensions : dimensions // ignore: cast_nullable_to_non_nullable
as String,dimensionsParsed: null == dimensionsParsed ? _self._dimensionsParsed : dimensionsParsed // ignore: cast_nullable_to_non_nullable
as List<ObjectDimension>,measurements: null == measurements ? _self._measurements : measurements // ignore: cast_nullable_to_non_nullable
as List<ObjectMeasurement>,creditLine: null == creditLine ? _self.creditLine : creditLine // ignore: cast_nullable_to_non_nullable
as String,geographyType: null == geographyType ? _self.geographyType : geographyType // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String,county: null == county ? _self.county : county // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,subregion: null == subregion ? _self.subregion : subregion // ignore: cast_nullable_to_non_nullable
as String,locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as String,locus: null == locus ? _self.locus : locus // ignore: cast_nullable_to_non_nullable
as String,excavation: null == excavation ? _self.excavation : excavation // ignore: cast_nullable_to_non_nullable
as String,river: null == river ? _self.river : river // ignore: cast_nullable_to_non_nullable
as String,classification: null == classification ? _self.classification : classification // ignore: cast_nullable_to_non_nullable
as String,rightsAndReproduction: null == rightsAndReproduction ? _self.rightsAndReproduction : rightsAndReproduction // ignore: cast_nullable_to_non_nullable
as String,linkResource: null == linkResource ? _self.linkResource : linkResource // ignore: cast_nullable_to_non_nullable
as String,metadataDate: freezed == metadataDate ? _self.metadataDate : metadataDate // ignore: cast_nullable_to_non_nullable
as DateTime?,repository: null == repository ? _self.repository : repository // ignore: cast_nullable_to_non_nullable
as String,objectUrl: null == objectUrl ? _self.objectUrl : objectUrl // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<ObjectTag>,objectWikidataUrl: null == objectWikidataUrl ? _self.objectWikidataUrl : objectWikidataUrl // ignore: cast_nullable_to_non_nullable
as String,isTimelineWork: null == isTimelineWork ? _self.isTimelineWork : isTimelineWork // ignore: cast_nullable_to_non_nullable
as bool,galleryNumber: null == galleryNumber ? _self.galleryNumber : galleryNumber // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ObjectConstituent {

/// `constituentID`.
@JsonKey(name: 'constituentID') int? get constituentId;/// "Artist", "Publisher".
 String get role; String get name;/// `constituentULAN_URL`.
@JsonKey(name: 'constituentULAN_URL') String get ulanUrl;/// `constituentWikidata_URL`.
@JsonKey(name: 'constituentWikidata_URL') String get wikidataUrl;/// Currently holds female designations only.
 String get gender;
/// Create a copy of ObjectConstituent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ObjectConstituentCopyWith<ObjectConstituent> get copyWith => _$ObjectConstituentCopyWithImpl<ObjectConstituent>(this as ObjectConstituent, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ObjectConstituent;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ObjectConstituent&&(identical(other.constituentId, _this.constituentId) || other.constituentId == _this.constituentId)&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.name, _this.name) || other.name == _this.name)&&(identical(other.ulanUrl, _this.ulanUrl) || other.ulanUrl == _this.ulanUrl)&&(identical(other.wikidataUrl, _this.wikidataUrl) || other.wikidataUrl == _this.wikidataUrl)&&(identical(other.gender, _this.gender) || other.gender == _this.gender));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ObjectConstituent;
  return Object.hash(runtimeType,_this.constituentId,_this.role,_this.name,_this.ulanUrl,_this.wikidataUrl,_this.gender);
}

@override
String toString() {
  final _this = this as ObjectConstituent;
  return 'ObjectConstituent(constituentId: ${_this.constituentId}, role: ${_this.role}, name: ${_this.name}, ulanUrl: ${_this.ulanUrl}, wikidataUrl: ${_this.wikidataUrl}, gender: ${_this.gender})';
}


}

/// @nodoc
abstract mixin class $ObjectConstituentCopyWith<$Res>  {
  factory $ObjectConstituentCopyWith(ObjectConstituent value, $Res Function(ObjectConstituent) _then) = _$ObjectConstituentCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'constituentID') int? constituentId, String role, String name,@JsonKey(name: 'constituentULAN_URL') String ulanUrl,@JsonKey(name: 'constituentWikidata_URL') String wikidataUrl, String gender
});




}
/// @nodoc
class _$ObjectConstituentCopyWithImpl<$Res>
    implements $ObjectConstituentCopyWith<$Res> {
  _$ObjectConstituentCopyWithImpl(this._self, this._then);

  final ObjectConstituent _self;
  final $Res Function(ObjectConstituent) _then;

/// Create a copy of ObjectConstituent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? constituentId = freezed,Object? role = null,Object? name = null,Object? ulanUrl = null,Object? wikidataUrl = null,Object? gender = null,}) {
  return _then(ObjectConstituent(
constituentId: freezed == constituentId ? _self.constituentId : constituentId // ignore: cast_nullable_to_non_nullable
as int?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,ulanUrl: null == ulanUrl ? _self.ulanUrl : ulanUrl // ignore: cast_nullable_to_non_nullable
as String,wikidataUrl: null == wikidataUrl ? _self.wikidataUrl : wikidataUrl // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ObjectConstituent].
extension ObjectConstituentPatterns on ObjectConstituent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ObjectConstituent value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ObjectConstituent() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ObjectConstituent value)  $default,){
final _that = this;
switch (_that) {
case _ObjectConstituent():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ObjectConstituent value)?  $default,){
final _that = this;
switch (_that) {
case _ObjectConstituent() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'constituentID')  int? constituentId,  String role,  String name, @JsonKey(name: 'constituentULAN_URL')  String ulanUrl, @JsonKey(name: 'constituentWikidata_URL')  String wikidataUrl,  String gender)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ObjectConstituent() when $default != null:
return $default(_that.constituentId,_that.role,_that.name,_that.ulanUrl,_that.wikidataUrl,_that.gender);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'constituentID')  int? constituentId,  String role,  String name, @JsonKey(name: 'constituentULAN_URL')  String ulanUrl, @JsonKey(name: 'constituentWikidata_URL')  String wikidataUrl,  String gender)  $default,) {final _that = this;
switch (_that) {
case _ObjectConstituent():
return $default(_that.constituentId,_that.role,_that.name,_that.ulanUrl,_that.wikidataUrl,_that.gender);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'constituentID')  int? constituentId,  String role,  String name, @JsonKey(name: 'constituentULAN_URL')  String ulanUrl, @JsonKey(name: 'constituentWikidata_URL')  String wikidataUrl,  String gender)?  $default,) {final _that = this;
switch (_that) {
case _ObjectConstituent() when $default != null:
return $default(_that.constituentId,_that.role,_that.name,_that.ulanUrl,_that.wikidataUrl,_that.gender);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(createToJson: false, converters: safeConverters)
class _ObjectConstituent implements ObjectConstituent {
  const _ObjectConstituent({@JsonKey(name: 'constituentID') this.constituentId, this.role = '', this.name = '', @JsonKey(name: 'constituentULAN_URL') this.ulanUrl = '', @JsonKey(name: 'constituentWikidata_URL') this.wikidataUrl = '', this.gender = ''});
  factory _ObjectConstituent.fromJson(Map<String, dynamic> json) => _$ObjectConstituentFromJson(json);

/// `constituentID`.
@override@JsonKey(name: 'constituentID') final  int? constituentId;
/// "Artist", "Publisher".
@override@JsonKey() final  String role;
@override@JsonKey() final  String name;
/// `constituentULAN_URL`.
@override@JsonKey(name: 'constituentULAN_URL') final  String ulanUrl;
/// `constituentWikidata_URL`.
@override@JsonKey(name: 'constituentWikidata_URL') final  String wikidataUrl;
/// Currently holds female designations only.
@override@JsonKey() final  String gender;

/// Create a copy of ObjectConstituent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ObjectConstituentCopyWith<_ObjectConstituent> get copyWith => __$ObjectConstituentCopyWithImpl<_ObjectConstituent>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ObjectConstituent&&(identical(other.constituentId, constituentId) || other.constituentId == constituentId)&&(identical(other.role, role) || other.role == role)&&(identical(other.name, name) || other.name == name)&&(identical(other.ulanUrl, ulanUrl) || other.ulanUrl == ulanUrl)&&(identical(other.wikidataUrl, wikidataUrl) || other.wikidataUrl == wikidataUrl)&&(identical(other.gender, gender) || other.gender == gender));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,constituentId,role,name,ulanUrl,wikidataUrl,gender);
}

@override
String toString() {
    return 'ObjectConstituent(constituentId: $constituentId, role: $role, name: $name, ulanUrl: $ulanUrl, wikidataUrl: $wikidataUrl, gender: $gender)';
}


}

/// @nodoc
abstract mixin class _$ObjectConstituentCopyWith<$Res> implements $ObjectConstituentCopyWith<$Res> {
  factory _$ObjectConstituentCopyWith(_ObjectConstituent value, $Res Function(_ObjectConstituent) _then) = __$ObjectConstituentCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'constituentID') int? constituentId, String role, String name,@JsonKey(name: 'constituentULAN_URL') String ulanUrl,@JsonKey(name: 'constituentWikidata_URL') String wikidataUrl, String gender
});




}
/// @nodoc
class __$ObjectConstituentCopyWithImpl<$Res>
    implements _$ObjectConstituentCopyWith<$Res> {
  __$ObjectConstituentCopyWithImpl(this._self, this._then);

  final _ObjectConstituent _self;
  final $Res Function(_ObjectConstituent) _then;

/// Create a copy of ObjectConstituent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? constituentId = freezed,Object? role = null,Object? name = null,Object? ulanUrl = null,Object? wikidataUrl = null,Object? gender = null,}) {
  return _then(_ObjectConstituent(
constituentId: freezed == constituentId ? _self.constituentId : constituentId // ignore: cast_nullable_to_non_nullable
as int?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,ulanUrl: null == ulanUrl ? _self.ulanUrl : ulanUrl // ignore: cast_nullable_to_non_nullable
as String,wikidataUrl: null == wikidataUrl ? _self.wikidataUrl : wikidataUrl // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ObjectMeasurement {

 String get elementName;/// `null` in most records, which reads as empty here.
 String get elementDescription;/// By dimension name ("Height", "Width", "Weight"). Lengths are in
/// centimetres, weights in kilograms.
@JsonKey(fromJson: _readAmounts) Map<String, double> get elementMeasurements;
/// Create a copy of ObjectMeasurement
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ObjectMeasurementCopyWith<ObjectMeasurement> get copyWith => _$ObjectMeasurementCopyWithImpl<ObjectMeasurement>(this as ObjectMeasurement, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ObjectMeasurement;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ObjectMeasurement&&(identical(other.elementName, _this.elementName) || other.elementName == _this.elementName)&&(identical(other.elementDescription, _this.elementDescription) || other.elementDescription == _this.elementDescription)&&const DeepCollectionEquality().equals(other.elementMeasurements, _this.elementMeasurements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ObjectMeasurement;
  return Object.hash(runtimeType,_this.elementName,_this.elementDescription,const DeepCollectionEquality().hash(_this.elementMeasurements));
}

@override
String toString() {
  final _this = this as ObjectMeasurement;
  return 'ObjectMeasurement(elementName: ${_this.elementName}, elementDescription: ${_this.elementDescription}, elementMeasurements: ${_this.elementMeasurements})';
}


}

/// @nodoc
abstract mixin class $ObjectMeasurementCopyWith<$Res>  {
  factory $ObjectMeasurementCopyWith(ObjectMeasurement value, $Res Function(ObjectMeasurement) _then) = _$ObjectMeasurementCopyWithImpl;
@useResult
$Res call({
 String elementName, String elementDescription,@JsonKey(fromJson: _readAmounts) Map<String, double> elementMeasurements
});




}
/// @nodoc
class _$ObjectMeasurementCopyWithImpl<$Res>
    implements $ObjectMeasurementCopyWith<$Res> {
  _$ObjectMeasurementCopyWithImpl(this._self, this._then);

  final ObjectMeasurement _self;
  final $Res Function(ObjectMeasurement) _then;

/// Create a copy of ObjectMeasurement
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? elementName = null,Object? elementDescription = null,Object? elementMeasurements = null,}) {
  return _then(ObjectMeasurement(
elementName: null == elementName ? _self.elementName : elementName // ignore: cast_nullable_to_non_nullable
as String,elementDescription: null == elementDescription ? _self.elementDescription : elementDescription // ignore: cast_nullable_to_non_nullable
as String,elementMeasurements: null == elementMeasurements ? _self.elementMeasurements : elementMeasurements // ignore: cast_nullable_to_non_nullable
as Map<String, double>,
  ));
}

}


/// Adds pattern-matching-related methods to [ObjectMeasurement].
extension ObjectMeasurementPatterns on ObjectMeasurement {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ObjectMeasurement value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ObjectMeasurement() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ObjectMeasurement value)  $default,){
final _that = this;
switch (_that) {
case _ObjectMeasurement():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ObjectMeasurement value)?  $default,){
final _that = this;
switch (_that) {
case _ObjectMeasurement() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String elementName,  String elementDescription, @JsonKey(fromJson: _readAmounts)  Map<String, double> elementMeasurements)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ObjectMeasurement() when $default != null:
return $default(_that.elementName,_that.elementDescription,_that.elementMeasurements);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String elementName,  String elementDescription, @JsonKey(fromJson: _readAmounts)  Map<String, double> elementMeasurements)  $default,) {final _that = this;
switch (_that) {
case _ObjectMeasurement():
return $default(_that.elementName,_that.elementDescription,_that.elementMeasurements);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String elementName,  String elementDescription, @JsonKey(fromJson: _readAmounts)  Map<String, double> elementMeasurements)?  $default,) {final _that = this;
switch (_that) {
case _ObjectMeasurement() when $default != null:
return $default(_that.elementName,_that.elementDescription,_that.elementMeasurements);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(createToJson: false, converters: safeConverters)
class _ObjectMeasurement implements ObjectMeasurement {
  const _ObjectMeasurement({this.elementName = '', this.elementDescription = '', @JsonKey(fromJson: _readAmounts)  Map<String, double> elementMeasurements = const <String, double>{}}): _elementMeasurements = elementMeasurements;
  factory _ObjectMeasurement.fromJson(Map<String, dynamic> json) => _$ObjectMeasurementFromJson(json);

@override@JsonKey() final  String elementName;
/// `null` in most records, which reads as empty here.
@override@JsonKey() final  String elementDescription;
/// By dimension name ("Height", "Width", "Weight"). Lengths are in
/// centimetres, weights in kilograms.
 final  Map<String, double> _elementMeasurements;
/// By dimension name ("Height", "Width", "Weight"). Lengths are in
/// centimetres, weights in kilograms.
@override@JsonKey(fromJson: _readAmounts) Map<String, double> get elementMeasurements {
  if (_elementMeasurements is EqualUnmodifiableMapView) return _elementMeasurements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_elementMeasurements);
}


/// Create a copy of ObjectMeasurement
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ObjectMeasurementCopyWith<_ObjectMeasurement> get copyWith => __$ObjectMeasurementCopyWithImpl<_ObjectMeasurement>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ObjectMeasurement&&(identical(other.elementName, elementName) || other.elementName == elementName)&&(identical(other.elementDescription, elementDescription) || other.elementDescription == elementDescription)&&const DeepCollectionEquality().equals(other.elementMeasurements, _elementMeasurements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,elementName,elementDescription,const DeepCollectionEquality().hash(_elementMeasurements));
}

@override
String toString() {
    return 'ObjectMeasurement(elementName: $elementName, elementDescription: $elementDescription, elementMeasurements: $elementMeasurements)';
}


}

/// @nodoc
abstract mixin class _$ObjectMeasurementCopyWith<$Res> implements $ObjectMeasurementCopyWith<$Res> {
  factory _$ObjectMeasurementCopyWith(_ObjectMeasurement value, $Res Function(_ObjectMeasurement) _then) = __$ObjectMeasurementCopyWithImpl;
@override @useResult
$Res call({
 String elementName, String elementDescription,@JsonKey(fromJson: _readAmounts) Map<String, double> elementMeasurements
});




}
/// @nodoc
class __$ObjectMeasurementCopyWithImpl<$Res>
    implements _$ObjectMeasurementCopyWith<$Res> {
  __$ObjectMeasurementCopyWithImpl(this._self, this._then);

  final _ObjectMeasurement _self;
  final $Res Function(_ObjectMeasurement) _then;

/// Create a copy of ObjectMeasurement
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? elementName = null,Object? elementDescription = null,Object? elementMeasurements = null,}) {
  return _then(_ObjectMeasurement(
elementName: null == elementName ? _self.elementName : elementName // ignore: cast_nullable_to_non_nullable
as String,elementDescription: null == elementDescription ? _self.elementDescription : elementDescription // ignore: cast_nullable_to_non_nullable
as String,elementMeasurements: null == elementMeasurements ? _self._elementMeasurements : elementMeasurements // ignore: cast_nullable_to_non_nullable
as Map<String, double>,
  ));
}


}


/// @nodoc
mixin _$ObjectDimension {

/// "Sheet", "Plate".
 String get element;/// "Height", "Width".
 String get dimensionType; double? get dimension;
/// Create a copy of ObjectDimension
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ObjectDimensionCopyWith<ObjectDimension> get copyWith => _$ObjectDimensionCopyWithImpl<ObjectDimension>(this as ObjectDimension, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ObjectDimension;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ObjectDimension&&(identical(other.element, _this.element) || other.element == _this.element)&&(identical(other.dimensionType, _this.dimensionType) || other.dimensionType == _this.dimensionType)&&(identical(other.dimension, _this.dimension) || other.dimension == _this.dimension));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ObjectDimension;
  return Object.hash(runtimeType,_this.element,_this.dimensionType,_this.dimension);
}

@override
String toString() {
  final _this = this as ObjectDimension;
  return 'ObjectDimension(element: ${_this.element}, dimensionType: ${_this.dimensionType}, dimension: ${_this.dimension})';
}


}

/// @nodoc
abstract mixin class $ObjectDimensionCopyWith<$Res>  {
  factory $ObjectDimensionCopyWith(ObjectDimension value, $Res Function(ObjectDimension) _then) = _$ObjectDimensionCopyWithImpl;
@useResult
$Res call({
 String element, String dimensionType, double? dimension
});




}
/// @nodoc
class _$ObjectDimensionCopyWithImpl<$Res>
    implements $ObjectDimensionCopyWith<$Res> {
  _$ObjectDimensionCopyWithImpl(this._self, this._then);

  final ObjectDimension _self;
  final $Res Function(ObjectDimension) _then;

/// Create a copy of ObjectDimension
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? element = null,Object? dimensionType = null,Object? dimension = freezed,}) {
  return _then(ObjectDimension(
element: null == element ? _self.element : element // ignore: cast_nullable_to_non_nullable
as String,dimensionType: null == dimensionType ? _self.dimensionType : dimensionType // ignore: cast_nullable_to_non_nullable
as String,dimension: freezed == dimension ? _self.dimension : dimension // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [ObjectDimension].
extension ObjectDimensionPatterns on ObjectDimension {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ObjectDimension value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ObjectDimension() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ObjectDimension value)  $default,){
final _that = this;
switch (_that) {
case _ObjectDimension():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ObjectDimension value)?  $default,){
final _that = this;
switch (_that) {
case _ObjectDimension() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String element,  String dimensionType,  double? dimension)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ObjectDimension() when $default != null:
return $default(_that.element,_that.dimensionType,_that.dimension);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String element,  String dimensionType,  double? dimension)  $default,) {final _that = this;
switch (_that) {
case _ObjectDimension():
return $default(_that.element,_that.dimensionType,_that.dimension);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String element,  String dimensionType,  double? dimension)?  $default,) {final _that = this;
switch (_that) {
case _ObjectDimension() when $default != null:
return $default(_that.element,_that.dimensionType,_that.dimension);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(createToJson: false, converters: safeConverters)
class _ObjectDimension implements ObjectDimension {
  const _ObjectDimension({this.element = '', this.dimensionType = '', this.dimension});
  factory _ObjectDimension.fromJson(Map<String, dynamic> json) => _$ObjectDimensionFromJson(json);

/// "Sheet", "Plate".
@override@JsonKey() final  String element;
/// "Height", "Width".
@override@JsonKey() final  String dimensionType;
@override final  double? dimension;

/// Create a copy of ObjectDimension
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ObjectDimensionCopyWith<_ObjectDimension> get copyWith => __$ObjectDimensionCopyWithImpl<_ObjectDimension>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ObjectDimension&&(identical(other.element, element) || other.element == element)&&(identical(other.dimensionType, dimensionType) || other.dimensionType == dimensionType)&&(identical(other.dimension, dimension) || other.dimension == dimension));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,element,dimensionType,dimension);
}

@override
String toString() {
    return 'ObjectDimension(element: $element, dimensionType: $dimensionType, dimension: $dimension)';
}


}

/// @nodoc
abstract mixin class _$ObjectDimensionCopyWith<$Res> implements $ObjectDimensionCopyWith<$Res> {
  factory _$ObjectDimensionCopyWith(_ObjectDimension value, $Res Function(_ObjectDimension) _then) = __$ObjectDimensionCopyWithImpl;
@override @useResult
$Res call({
 String element, String dimensionType, double? dimension
});




}
/// @nodoc
class __$ObjectDimensionCopyWithImpl<$Res>
    implements _$ObjectDimensionCopyWith<$Res> {
  __$ObjectDimensionCopyWithImpl(this._self, this._then);

  final _ObjectDimension _self;
  final $Res Function(_ObjectDimension) _then;

/// Create a copy of ObjectDimension
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? element = null,Object? dimensionType = null,Object? dimension = freezed,}) {
  return _then(_ObjectDimension(
element: null == element ? _self.element : element // ignore: cast_nullable_to_non_nullable
as String,dimensionType: null == dimensionType ? _self.dimensionType : dimensionType // ignore: cast_nullable_to_non_nullable
as String,dimension: freezed == dimension ? _self.dimension : dimension // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}


/// @nodoc
mixin _$ObjectTag {

 String get term;/// `AAT_URL`: the term in the Getty Art & Architecture Thesaurus.
@JsonKey(name: 'AAT_URL') String get aatUrl;/// `Wikidata_URL`.
@JsonKey(name: 'Wikidata_URL') String get wikidataUrl;
/// Create a copy of ObjectTag
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ObjectTagCopyWith<ObjectTag> get copyWith => _$ObjectTagCopyWithImpl<ObjectTag>(this as ObjectTag, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as ObjectTag;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ObjectTag&&(identical(other.term, _this.term) || other.term == _this.term)&&(identical(other.aatUrl, _this.aatUrl) || other.aatUrl == _this.aatUrl)&&(identical(other.wikidataUrl, _this.wikidataUrl) || other.wikidataUrl == _this.wikidataUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ObjectTag;
  return Object.hash(runtimeType,_this.term,_this.aatUrl,_this.wikidataUrl);
}

@override
String toString() {
  final _this = this as ObjectTag;
  return 'ObjectTag(term: ${_this.term}, aatUrl: ${_this.aatUrl}, wikidataUrl: ${_this.wikidataUrl})';
}


}

/// @nodoc
abstract mixin class $ObjectTagCopyWith<$Res>  {
  factory $ObjectTagCopyWith(ObjectTag value, $Res Function(ObjectTag) _then) = _$ObjectTagCopyWithImpl;
@useResult
$Res call({
 String term,@JsonKey(name: 'AAT_URL') String aatUrl,@JsonKey(name: 'Wikidata_URL') String wikidataUrl
});




}
/// @nodoc
class _$ObjectTagCopyWithImpl<$Res>
    implements $ObjectTagCopyWith<$Res> {
  _$ObjectTagCopyWithImpl(this._self, this._then);

  final ObjectTag _self;
  final $Res Function(ObjectTag) _then;

/// Create a copy of ObjectTag
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? term = null,Object? aatUrl = null,Object? wikidataUrl = null,}) {
  return _then(ObjectTag(
term: null == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as String,aatUrl: null == aatUrl ? _self.aatUrl : aatUrl // ignore: cast_nullable_to_non_nullable
as String,wikidataUrl: null == wikidataUrl ? _self.wikidataUrl : wikidataUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ObjectTag].
extension ObjectTagPatterns on ObjectTag {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ObjectTag value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ObjectTag() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ObjectTag value)  $default,){
final _that = this;
switch (_that) {
case _ObjectTag():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ObjectTag value)?  $default,){
final _that = this;
switch (_that) {
case _ObjectTag() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String term, @JsonKey(name: 'AAT_URL')  String aatUrl, @JsonKey(name: 'Wikidata_URL')  String wikidataUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ObjectTag() when $default != null:
return $default(_that.term,_that.aatUrl,_that.wikidataUrl);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String term, @JsonKey(name: 'AAT_URL')  String aatUrl, @JsonKey(name: 'Wikidata_URL')  String wikidataUrl)  $default,) {final _that = this;
switch (_that) {
case _ObjectTag():
return $default(_that.term,_that.aatUrl,_that.wikidataUrl);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String term, @JsonKey(name: 'AAT_URL')  String aatUrl, @JsonKey(name: 'Wikidata_URL')  String wikidataUrl)?  $default,) {final _that = this;
switch (_that) {
case _ObjectTag() when $default != null:
return $default(_that.term,_that.aatUrl,_that.wikidataUrl);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(createToJson: false, converters: safeConverters)
class _ObjectTag implements ObjectTag {
  const _ObjectTag({this.term = '', @JsonKey(name: 'AAT_URL') this.aatUrl = '', @JsonKey(name: 'Wikidata_URL') this.wikidataUrl = ''});
  factory _ObjectTag.fromJson(Map<String, dynamic> json) => _$ObjectTagFromJson(json);

@override@JsonKey() final  String term;
/// `AAT_URL`: the term in the Getty Art & Architecture Thesaurus.
@override@JsonKey(name: 'AAT_URL') final  String aatUrl;
/// `Wikidata_URL`.
@override@JsonKey(name: 'Wikidata_URL') final  String wikidataUrl;

/// Create a copy of ObjectTag
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ObjectTagCopyWith<_ObjectTag> get copyWith => __$ObjectTagCopyWithImpl<_ObjectTag>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ObjectTag&&(identical(other.term, term) || other.term == term)&&(identical(other.aatUrl, aatUrl) || other.aatUrl == aatUrl)&&(identical(other.wikidataUrl, wikidataUrl) || other.wikidataUrl == wikidataUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,term,aatUrl,wikidataUrl);
}

@override
String toString() {
    return 'ObjectTag(term: $term, aatUrl: $aatUrl, wikidataUrl: $wikidataUrl)';
}


}

/// @nodoc
abstract mixin class _$ObjectTagCopyWith<$Res> implements $ObjectTagCopyWith<$Res> {
  factory _$ObjectTagCopyWith(_ObjectTag value, $Res Function(_ObjectTag) _then) = __$ObjectTagCopyWithImpl;
@override @useResult
$Res call({
 String term,@JsonKey(name: 'AAT_URL') String aatUrl,@JsonKey(name: 'Wikidata_URL') String wikidataUrl
});




}
/// @nodoc
class __$ObjectTagCopyWithImpl<$Res>
    implements _$ObjectTagCopyWith<$Res> {
  __$ObjectTagCopyWithImpl(this._self, this._then);

  final _ObjectTag _self;
  final $Res Function(_ObjectTag) _then;

/// Create a copy of ObjectTag
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? term = null,Object? aatUrl = null,Object? wikidataUrl = null,}) {
  return _then(_ObjectTag(
term: null == term ? _self.term : term // ignore: cast_nullable_to_non_nullable
as String,aatUrl: null == aatUrl ? _self.aatUrl : aatUrl // ignore: cast_nullable_to_non_nullable
as String,wikidataUrl: null == wikidataUrl ? _self.wikidataUrl : wikidataUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
