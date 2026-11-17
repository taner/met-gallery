// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'artwork.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Artwork {

 int get id; String get imageUrl; String get pageUrl; String get title; String get artist; String get date; String get medium; String get department;/// Which print this record is an impression of; null when it is not a
/// print. Only the first work with a given value is shown (see
/// `PagedArtworks.append`).
 String? get impressionOf;/// Other pictures of the same work, in the same size as [imageUrl].
 List<String> get moreImageUrls;/// The museum's subject keywords, each usable as a search.
 List<String> get tags;
/// Create a copy of Artwork
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArtworkCopyWith<Artwork> get copyWith => _$ArtworkCopyWithImpl<Artwork>(this as Artwork, _$identity);

  /// Serializes this Artwork to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as Artwork;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Artwork&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.imageUrl, _this.imageUrl) || other.imageUrl == _this.imageUrl)&&(identical(other.pageUrl, _this.pageUrl) || other.pageUrl == _this.pageUrl)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.artist, _this.artist) || other.artist == _this.artist)&&(identical(other.date, _this.date) || other.date == _this.date)&&(identical(other.medium, _this.medium) || other.medium == _this.medium)&&(identical(other.department, _this.department) || other.department == _this.department)&&(identical(other.impressionOf, _this.impressionOf) || other.impressionOf == _this.impressionOf)&&const DeepCollectionEquality().equals(other.moreImageUrls, _this.moreImageUrls)&&const DeepCollectionEquality().equals(other.tags, _this.tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Artwork;
  return Object.hash(runtimeType,_this.id,_this.imageUrl,_this.pageUrl,_this.title,_this.artist,_this.date,_this.medium,_this.department,_this.impressionOf,const DeepCollectionEquality().hash(_this.moreImageUrls),const DeepCollectionEquality().hash(_this.tags));
}

@override
String toString() {
  final _this = this as Artwork;
  return 'Artwork(id: ${_this.id}, imageUrl: ${_this.imageUrl}, pageUrl: ${_this.pageUrl}, title: ${_this.title}, artist: ${_this.artist}, date: ${_this.date}, medium: ${_this.medium}, department: ${_this.department}, impressionOf: ${_this.impressionOf}, moreImageUrls: ${_this.moreImageUrls}, tags: ${_this.tags})';
}


}

/// @nodoc
abstract mixin class $ArtworkCopyWith<$Res>  {
  factory $ArtworkCopyWith(Artwork value, $Res Function(Artwork) _then) = _$ArtworkCopyWithImpl;
@useResult
$Res call({
 int id, String imageUrl, String pageUrl, String title, String artist, String date, String medium, String department, String? impressionOf, List<String> moreImageUrls, List<String> tags
});




}
/// @nodoc
class _$ArtworkCopyWithImpl<$Res>
    implements $ArtworkCopyWith<$Res> {
  _$ArtworkCopyWithImpl(this._self, this._then);

  final Artwork _self;
  final $Res Function(Artwork) _then;

/// Create a copy of Artwork
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? imageUrl = null,Object? pageUrl = null,Object? title = null,Object? artist = null,Object? date = null,Object? medium = null,Object? department = null,Object? impressionOf = freezed,Object? moreImageUrls = null,Object? tags = null,}) {
  return _then(Artwork(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,pageUrl: null == pageUrl ? _self.pageUrl : pageUrl // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,artist: null == artist ? _self.artist : artist // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,medium: null == medium ? _self.medium : medium // ignore: cast_nullable_to_non_nullable
as String,department: null == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String,impressionOf: freezed == impressionOf ? _self.impressionOf : impressionOf // ignore: cast_nullable_to_non_nullable
as String?,moreImageUrls: null == moreImageUrls ? _self.moreImageUrls : moreImageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [Artwork].
extension ArtworkPatterns on Artwork {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Artwork value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Artwork() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Artwork value)  $default,){
final _that = this;
switch (_that) {
case _Artwork():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Artwork value)?  $default,){
final _that = this;
switch (_that) {
case _Artwork() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String imageUrl,  String pageUrl,  String title,  String artist,  String date,  String medium,  String department,  String? impressionOf,  List<String> moreImageUrls,  List<String> tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Artwork() when $default != null:
return $default(_that.id,_that.imageUrl,_that.pageUrl,_that.title,_that.artist,_that.date,_that.medium,_that.department,_that.impressionOf,_that.moreImageUrls,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String imageUrl,  String pageUrl,  String title,  String artist,  String date,  String medium,  String department,  String? impressionOf,  List<String> moreImageUrls,  List<String> tags)  $default,) {final _that = this;
switch (_that) {
case _Artwork():
return $default(_that.id,_that.imageUrl,_that.pageUrl,_that.title,_that.artist,_that.date,_that.medium,_that.department,_that.impressionOf,_that.moreImageUrls,_that.tags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String imageUrl,  String pageUrl,  String title,  String artist,  String date,  String medium,  String department,  String? impressionOf,  List<String> moreImageUrls,  List<String> tags)?  $default,) {final _that = this;
switch (_that) {
case _Artwork() when $default != null:
return $default(_that.id,_that.imageUrl,_that.pageUrl,_that.title,_that.artist,_that.date,_that.medium,_that.department,_that.impressionOf,_that.moreImageUrls,_that.tags);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Artwork extends Artwork {
  const _Artwork({required this.id, required this.imageUrl, required this.pageUrl, this.title = '', this.artist = '', this.date = '', this.medium = '', this.department = '', this.impressionOf,  List<String> moreImageUrls = const <String>[],  List<String> tags = const <String>[]}): _moreImageUrls = moreImageUrls,_tags = tags,super._();
  factory _Artwork.fromJson(Map<String, dynamic> json) => _$ArtworkFromJson(json);

@override final  int id;
@override final  String imageUrl;
@override final  String pageUrl;
@override@JsonKey() final  String title;
@override@JsonKey() final  String artist;
@override@JsonKey() final  String date;
@override@JsonKey() final  String medium;
@override@JsonKey() final  String department;
/// Which print this record is an impression of; null when it is not a
/// print. Only the first work with a given value is shown (see
/// `PagedArtworks.append`).
@override final  String? impressionOf;
/// Other pictures of the same work, in the same size as [imageUrl].
 final  List<String> _moreImageUrls;
/// Other pictures of the same work, in the same size as [imageUrl].
@override@JsonKey() List<String> get moreImageUrls {
  if (_moreImageUrls is EqualUnmodifiableListView) return _moreImageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_moreImageUrls);
}

/// The museum's subject keywords, each usable as a search.
 final  List<String> _tags;
/// The museum's subject keywords, each usable as a search.
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}


/// Create a copy of Artwork
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArtworkCopyWith<_Artwork> get copyWith => __$ArtworkCopyWithImpl<_Artwork>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArtworkToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Artwork&&(identical(other.id, id) || other.id == id)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.pageUrl, pageUrl) || other.pageUrl == pageUrl)&&(identical(other.title, title) || other.title == title)&&(identical(other.artist, artist) || other.artist == artist)&&(identical(other.date, date) || other.date == date)&&(identical(other.medium, medium) || other.medium == medium)&&(identical(other.department, department) || other.department == department)&&(identical(other.impressionOf, impressionOf) || other.impressionOf == impressionOf)&&const DeepCollectionEquality().equals(other.moreImageUrls, _moreImageUrls)&&const DeepCollectionEquality().equals(other.tags, _tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,imageUrl,pageUrl,title,artist,date,medium,department,impressionOf,const DeepCollectionEquality().hash(_moreImageUrls),const DeepCollectionEquality().hash(_tags));
}

@override
String toString() {
    return 'Artwork(id: $id, imageUrl: $imageUrl, pageUrl: $pageUrl, title: $title, artist: $artist, date: $date, medium: $medium, department: $department, impressionOf: $impressionOf, moreImageUrls: $moreImageUrls, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$ArtworkCopyWith<$Res> implements $ArtworkCopyWith<$Res> {
  factory _$ArtworkCopyWith(_Artwork value, $Res Function(_Artwork) _then) = __$ArtworkCopyWithImpl;
@override @useResult
$Res call({
 int id, String imageUrl, String pageUrl, String title, String artist, String date, String medium, String department, String? impressionOf, List<String> moreImageUrls, List<String> tags
});




}
/// @nodoc
class __$ArtworkCopyWithImpl<$Res>
    implements _$ArtworkCopyWith<$Res> {
  __$ArtworkCopyWithImpl(this._self, this._then);

  final _Artwork _self;
  final $Res Function(_Artwork) _then;

/// Create a copy of Artwork
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? imageUrl = null,Object? pageUrl = null,Object? title = null,Object? artist = null,Object? date = null,Object? medium = null,Object? department = null,Object? impressionOf = freezed,Object? moreImageUrls = null,Object? tags = null,}) {
  return _then(_Artwork(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,pageUrl: null == pageUrl ? _self.pageUrl : pageUrl // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,artist: null == artist ? _self.artist : artist // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,medium: null == medium ? _self.medium : medium // ignore: cast_nullable_to_non_nullable
as String,department: null == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as String,impressionOf: freezed == impressionOf ? _self.impressionOf : impressionOf // ignore: cast_nullable_to_non_nullable
as String?,moreImageUrls: null == moreImageUrls ? _self._moreImageUrls : moreImageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
