// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_ids.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SearchIds {

/// `total`. Every match, across all pages.
@JsonKey(readValue: _totalOrPageSize) int get total;/// `objectIDs`.
@JsonKey(name: 'objectIDs', fromJson: _positiveIds) List<int> get ids;
/// Create a copy of SearchIds
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchIdsCopyWith<SearchIds> get copyWith => _$SearchIdsCopyWithImpl<SearchIds>(this as SearchIds, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SearchIds;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchIds&&(identical(other.total, _this.total) || other.total == _this.total)&&const DeepCollectionEquality().equals(other.ids, _this.ids));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as SearchIds;
  return Object.hash(runtimeType,_this.total,const DeepCollectionEquality().hash(_this.ids));
}

@override
String toString() {
  final _this = this as SearchIds;
  return 'SearchIds(total: ${_this.total}, ids: ${_this.ids})';
}


}

/// @nodoc
abstract mixin class $SearchIdsCopyWith<$Res>  {
  factory $SearchIdsCopyWith(SearchIds value, $Res Function(SearchIds) _then) = _$SearchIdsCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: _totalOrPageSize) int total,@JsonKey(name: 'objectIDs', fromJson: _positiveIds) List<int> ids
});




}
/// @nodoc
class _$SearchIdsCopyWithImpl<$Res>
    implements $SearchIdsCopyWith<$Res> {
  _$SearchIdsCopyWithImpl(this._self, this._then);

  final SearchIds _self;
  final $Res Function(SearchIds) _then;

/// Create a copy of SearchIds
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? total = null,Object? ids = null,}) {
  return _then(SearchIds(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,ids: null == ids ? _self.ids : ids // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchIds].
extension SearchIdsPatterns on SearchIds {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchIds value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchIds() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchIds value)  $default,){
final _that = this;
switch (_that) {
case _SearchIds():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchIds value)?  $default,){
final _that = this;
switch (_that) {
case _SearchIds() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: _totalOrPageSize)  int total, @JsonKey(name: 'objectIDs', fromJson: _positiveIds)  List<int> ids)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchIds() when $default != null:
return $default(_that.total,_that.ids);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: _totalOrPageSize)  int total, @JsonKey(name: 'objectIDs', fromJson: _positiveIds)  List<int> ids)  $default,) {final _that = this;
switch (_that) {
case _SearchIds():
return $default(_that.total,_that.ids);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: _totalOrPageSize)  int total, @JsonKey(name: 'objectIDs', fromJson: _positiveIds)  List<int> ids)?  $default,) {final _that = this;
switch (_that) {
case _SearchIds() when $default != null:
return $default(_that.total,_that.ids);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(createToJson: false)
class _SearchIds implements SearchIds {
  const _SearchIds({@JsonKey(readValue: _totalOrPageSize) required this.total, @JsonKey(name: 'objectIDs', fromJson: _positiveIds) required  List<int> ids}): _ids = ids;
  factory _SearchIds.fromJson(Map<String, dynamic> json) => _$SearchIdsFromJson(json);

/// `total`. Every match, across all pages.
@override@JsonKey(readValue: _totalOrPageSize) final  int total;
/// `objectIDs`.
 final  List<int> _ids;
/// `objectIDs`.
@override@JsonKey(name: 'objectIDs', fromJson: _positiveIds) List<int> get ids {
  if (_ids is EqualUnmodifiableListView) return _ids;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ids);
}


/// Create a copy of SearchIds
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchIdsCopyWith<_SearchIds> get copyWith => __$SearchIdsCopyWithImpl<_SearchIds>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchIds&&(identical(other.total, total) || other.total == total)&&const DeepCollectionEquality().equals(other.ids, _ids));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,total,const DeepCollectionEquality().hash(_ids));
}

@override
String toString() {
    return 'SearchIds(total: $total, ids: $ids)';
}


}

/// @nodoc
abstract mixin class _$SearchIdsCopyWith<$Res> implements $SearchIdsCopyWith<$Res> {
  factory _$SearchIdsCopyWith(_SearchIds value, $Res Function(_SearchIds) _then) = __$SearchIdsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: _totalOrPageSize) int total,@JsonKey(name: 'objectIDs', fromJson: _positiveIds) List<int> ids
});




}
/// @nodoc
class __$SearchIdsCopyWithImpl<$Res>
    implements _$SearchIdsCopyWith<$Res> {
  __$SearchIdsCopyWithImpl(this._self, this._then);

  final _SearchIds _self;
  final $Res Function(_SearchIds) _then;

/// Create a copy of SearchIds
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? total = null,Object? ids = null,}) {
  return _then(_SearchIds(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,ids: null == ids ? _self._ids : ids // ignore: cast_nullable_to_non_nullable
as List<int>,
  ));
}


}

// dart format on
