// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paged_artworks.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PagedArtworks {

 String get query;/// The department the search is narrowed to; null for all of them.
 Department? get department; List<Artwork> get items; int get total; int get examined; bool get isLoading; PageFailure? get failure;/// The latest page added no works.
 bool get lastPageEmpty;
/// Create a copy of PagedArtworks
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PagedArtworksCopyWith<PagedArtworks> get copyWith => _$PagedArtworksCopyWithImpl<PagedArtworks>(this as PagedArtworks, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PagedArtworks;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PagedArtworks&&(identical(other.query, _this.query) || other.query == _this.query)&&(identical(other.department, _this.department) || other.department == _this.department)&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.total, _this.total) || other.total == _this.total)&&(identical(other.examined, _this.examined) || other.examined == _this.examined)&&(identical(other.isLoading, _this.isLoading) || other.isLoading == _this.isLoading)&&(identical(other.failure, _this.failure) || other.failure == _this.failure)&&(identical(other.lastPageEmpty, _this.lastPageEmpty) || other.lastPageEmpty == _this.lastPageEmpty));
}


@override
int get hashCode {
  final _this = this as PagedArtworks;
  return Object.hash(runtimeType,_this.query,_this.department,const DeepCollectionEquality().hash(_this.items),_this.total,_this.examined,_this.isLoading,_this.failure,_this.lastPageEmpty);
}

@override
String toString() {
  final _this = this as PagedArtworks;
  return 'PagedArtworks(query: ${_this.query}, department: ${_this.department}, items: ${_this.items}, total: ${_this.total}, examined: ${_this.examined}, isLoading: ${_this.isLoading}, failure: ${_this.failure}, lastPageEmpty: ${_this.lastPageEmpty})';
}


}

/// @nodoc
abstract mixin class $PagedArtworksCopyWith<$Res>  {
  factory $PagedArtworksCopyWith(PagedArtworks value, $Res Function(PagedArtworks) _then) = _$PagedArtworksCopyWithImpl;
@useResult
$Res call({
 String query, Department? department, List<Artwork> items, int total, int examined, bool isLoading, PageFailure? failure, bool lastPageEmpty
});


$DepartmentCopyWith<$Res>? get department;

}
/// @nodoc
class _$PagedArtworksCopyWithImpl<$Res>
    implements $PagedArtworksCopyWith<$Res> {
  _$PagedArtworksCopyWithImpl(this._self, this._then);

  final PagedArtworks _self;
  final $Res Function(PagedArtworks) _then;

/// Create a copy of PagedArtworks
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? department = freezed,Object? items = null,Object? total = null,Object? examined = null,Object? isLoading = null,Object? failure = freezed,Object? lastPageEmpty = null,}) {
  return _then(PagedArtworks(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,department: freezed == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as Department?,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<Artwork>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,examined: null == examined ? _self.examined : examined // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as PageFailure?,lastPageEmpty: null == lastPageEmpty ? _self.lastPageEmpty : lastPageEmpty // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of PagedArtworks
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DepartmentCopyWith<$Res>? get department {
    if (_self.department == null) {
    return null;
  }

  return $DepartmentCopyWith<$Res>(_self.department!, (value) {
    return _then(_self.copyWith(department: value));
  });
}
}


/// Adds pattern-matching-related methods to [PagedArtworks].
extension PagedArtworksPatterns on PagedArtworks {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PagedArtworks value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PagedArtworks() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PagedArtworks value)  $default,){
final _that = this;
switch (_that) {
case _PagedArtworks():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PagedArtworks value)?  $default,){
final _that = this;
switch (_that) {
case _PagedArtworks() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String query,  Department? department,  List<Artwork> items,  int total,  int examined,  bool isLoading,  PageFailure? failure,  bool lastPageEmpty)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PagedArtworks() when $default != null:
return $default(_that.query,_that.department,_that.items,_that.total,_that.examined,_that.isLoading,_that.failure,_that.lastPageEmpty);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String query,  Department? department,  List<Artwork> items,  int total,  int examined,  bool isLoading,  PageFailure? failure,  bool lastPageEmpty)  $default,) {final _that = this;
switch (_that) {
case _PagedArtworks():
return $default(_that.query,_that.department,_that.items,_that.total,_that.examined,_that.isLoading,_that.failure,_that.lastPageEmpty);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String query,  Department? department,  List<Artwork> items,  int total,  int examined,  bool isLoading,  PageFailure? failure,  bool lastPageEmpty)?  $default,) {final _that = this;
switch (_that) {
case _PagedArtworks() when $default != null:
return $default(_that.query,_that.department,_that.items,_that.total,_that.examined,_that.isLoading,_that.failure,_that.lastPageEmpty);case _:
  return null;

}
}

}

/// @nodoc


class _PagedArtworks extends PagedArtworks {
  const _PagedArtworks({required this.query, this.department,  List<Artwork> items = const [], this.total = 0, this.examined = 0, this.isLoading = false, this.failure, this.lastPageEmpty = false}): _items = items,super._();
  

@override final  String query;
/// The department the search is narrowed to; null for all of them.
@override final  Department? department;
 final  List<Artwork> _items;
@override@JsonKey() List<Artwork> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override@JsonKey() final  int total;
@override@JsonKey() final  int examined;
@override@JsonKey() final  bool isLoading;
@override final  PageFailure? failure;
/// The latest page added no works.
@override@JsonKey() final  bool lastPageEmpty;

/// Create a copy of PagedArtworks
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PagedArtworksCopyWith<_PagedArtworks> get copyWith => __$PagedArtworksCopyWithImpl<_PagedArtworks>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PagedArtworks&&(identical(other.query, query) || other.query == query)&&(identical(other.department, department) || other.department == department)&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.total, total) || other.total == total)&&(identical(other.examined, examined) || other.examined == examined)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.failure, failure) || other.failure == failure)&&(identical(other.lastPageEmpty, lastPageEmpty) || other.lastPageEmpty == lastPageEmpty));
}


@override
int get hashCode {
    return Object.hash(runtimeType,query,department,const DeepCollectionEquality().hash(_items),total,examined,isLoading,failure,lastPageEmpty);
}

@override
String toString() {
    return 'PagedArtworks(query: $query, department: $department, items: $items, total: $total, examined: $examined, isLoading: $isLoading, failure: $failure, lastPageEmpty: $lastPageEmpty)';
}


}

/// @nodoc
abstract mixin class _$PagedArtworksCopyWith<$Res> implements $PagedArtworksCopyWith<$Res> {
  factory _$PagedArtworksCopyWith(_PagedArtworks value, $Res Function(_PagedArtworks) _then) = __$PagedArtworksCopyWithImpl;
@override @useResult
$Res call({
 String query, Department? department, List<Artwork> items, int total, int examined, bool isLoading, PageFailure? failure, bool lastPageEmpty
});


@override $DepartmentCopyWith<$Res>? get department;

}
/// @nodoc
class __$PagedArtworksCopyWithImpl<$Res>
    implements _$PagedArtworksCopyWith<$Res> {
  __$PagedArtworksCopyWithImpl(this._self, this._then);

  final _PagedArtworks _self;
  final $Res Function(_PagedArtworks) _then;

/// Create a copy of PagedArtworks
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? department = freezed,Object? items = null,Object? total = null,Object? examined = null,Object? isLoading = null,Object? failure = freezed,Object? lastPageEmpty = null,}) {
  return _then(_PagedArtworks(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,department: freezed == department ? _self.department : department // ignore: cast_nullable_to_non_nullable
as Department?,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<Artwork>,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,examined: null == examined ? _self.examined : examined // ignore: cast_nullable_to_non_nullable
as int,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as PageFailure?,lastPageEmpty: null == lastPageEmpty ? _self.lastPageEmpty : lastPageEmpty // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of PagedArtworks
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DepartmentCopyWith<$Res>? get department {
    if (_self.department == null) {
    return null;
  }

  return $DepartmentCopyWith<$Res>(_self.department!, (value) {
    return _then(_self.copyWith(department: value));
  });
}
}

// dart format on
