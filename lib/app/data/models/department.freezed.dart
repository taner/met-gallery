// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'department.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Department {

@JsonKey(fromJson: requiredJsonId) int get departmentId; String get displayName;
/// Create a copy of Department
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DepartmentCopyWith<Department> get copyWith => _$DepartmentCopyWithImpl<Department>(this as Department, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Department;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Department&&(identical(other.departmentId, _this.departmentId) || other.departmentId == _this.departmentId)&&(identical(other.displayName, _this.displayName) || other.displayName == _this.displayName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as Department;
  return Object.hash(runtimeType,_this.departmentId,_this.displayName);
}

@override
String toString() {
  final _this = this as Department;
  return 'Department(departmentId: ${_this.departmentId}, displayName: ${_this.displayName})';
}


}

/// @nodoc
abstract mixin class $DepartmentCopyWith<$Res>  {
  factory $DepartmentCopyWith(Department value, $Res Function(Department) _then) = _$DepartmentCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: requiredJsonId) int departmentId, String displayName
});




}
/// @nodoc
class _$DepartmentCopyWithImpl<$Res>
    implements $DepartmentCopyWith<$Res> {
  _$DepartmentCopyWithImpl(this._self, this._then);

  final Department _self;
  final $Res Function(Department) _then;

/// Create a copy of Department
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? departmentId = null,Object? displayName = null,}) {
  return _then(Department(
departmentId: null == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as int,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Department].
extension DepartmentPatterns on Department {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Department value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Department() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Department value)  $default,){
final _that = this;
switch (_that) {
case _Department():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Department value)?  $default,){
final _that = this;
switch (_that) {
case _Department() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: requiredJsonId)  int departmentId,  String displayName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Department() when $default != null:
return $default(_that.departmentId,_that.displayName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: requiredJsonId)  int departmentId,  String displayName)  $default,) {final _that = this;
switch (_that) {
case _Department():
return $default(_that.departmentId,_that.displayName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: requiredJsonId)  int departmentId,  String displayName)?  $default,) {final _that = this;
switch (_that) {
case _Department() when $default != null:
return $default(_that.departmentId,_that.displayName);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(createToJson: false, converters: safeConverters)
class _Department implements Department {
  const _Department({@JsonKey(fromJson: requiredJsonId) required this.departmentId, this.displayName = ''});
  factory _Department.fromJson(Map<String, dynamic> json) => _$DepartmentFromJson(json);

@override@JsonKey(fromJson: requiredJsonId) final  int departmentId;
@override@JsonKey() final  String displayName;

/// Create a copy of Department
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DepartmentCopyWith<_Department> get copyWith => __$DepartmentCopyWithImpl<_Department>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Department&&(identical(other.departmentId, departmentId) || other.departmentId == departmentId)&&(identical(other.displayName, displayName) || other.displayName == displayName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,departmentId,displayName);
}

@override
String toString() {
    return 'Department(departmentId: $departmentId, displayName: $displayName)';
}


}

/// @nodoc
abstract mixin class _$DepartmentCopyWith<$Res> implements $DepartmentCopyWith<$Res> {
  factory _$DepartmentCopyWith(_Department value, $Res Function(_Department) _then) = __$DepartmentCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: requiredJsonId) int departmentId, String displayName
});




}
/// @nodoc
class __$DepartmentCopyWithImpl<$Res>
    implements _$DepartmentCopyWith<$Res> {
  __$DepartmentCopyWithImpl(this._self, this._then);

  final _Department _self;
  final $Res Function(_Department) _then;

/// Create a copy of Department
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? departmentId = null,Object? displayName = null,}) {
  return _then(_Department(
departmentId: null == departmentId ? _self.departmentId : departmentId // ignore: cast_nullable_to_non_nullable
as int,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$DepartmentListing {

@JsonKey(fromJson: _readDepartments) List<Department> get departments;
/// Create a copy of DepartmentListing
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DepartmentListingCopyWith<DepartmentListing> get copyWith => _$DepartmentListingCopyWithImpl<DepartmentListing>(this as DepartmentListing, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as DepartmentListing;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DepartmentListing&&const DeepCollectionEquality().equals(other.departments, _this.departments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as DepartmentListing;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.departments));
}

@override
String toString() {
  final _this = this as DepartmentListing;
  return 'DepartmentListing(departments: ${_this.departments})';
}


}

/// @nodoc
abstract mixin class $DepartmentListingCopyWith<$Res>  {
  factory $DepartmentListingCopyWith(DepartmentListing value, $Res Function(DepartmentListing) _then) = _$DepartmentListingCopyWithImpl;
@useResult
$Res call({
@JsonKey(fromJson: _readDepartments) List<Department> departments
});




}
/// @nodoc
class _$DepartmentListingCopyWithImpl<$Res>
    implements $DepartmentListingCopyWith<$Res> {
  _$DepartmentListingCopyWithImpl(this._self, this._then);

  final DepartmentListing _self;
  final $Res Function(DepartmentListing) _then;

/// Create a copy of DepartmentListing
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? departments = null,}) {
  return _then(DepartmentListing(
departments: null == departments ? _self.departments : departments // ignore: cast_nullable_to_non_nullable
as List<Department>,
  ));
}

}


/// Adds pattern-matching-related methods to [DepartmentListing].
extension DepartmentListingPatterns on DepartmentListing {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DepartmentListing value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DepartmentListing() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DepartmentListing value)  $default,){
final _that = this;
switch (_that) {
case _DepartmentListing():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DepartmentListing value)?  $default,){
final _that = this;
switch (_that) {
case _DepartmentListing() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _readDepartments)  List<Department> departments)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DepartmentListing() when $default != null:
return $default(_that.departments);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(fromJson: _readDepartments)  List<Department> departments)  $default,) {final _that = this;
switch (_that) {
case _DepartmentListing():
return $default(_that.departments);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(fromJson: _readDepartments)  List<Department> departments)?  $default,) {final _that = this;
switch (_that) {
case _DepartmentListing() when $default != null:
return $default(_that.departments);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(createToJson: false)
class _DepartmentListing implements DepartmentListing {
  const _DepartmentListing({@JsonKey(fromJson: _readDepartments)  List<Department> departments = const <Department>[]}): _departments = departments;
  factory _DepartmentListing.fromJson(Map<String, dynamic> json) => _$DepartmentListingFromJson(json);

 final  List<Department> _departments;
@override@JsonKey(fromJson: _readDepartments) List<Department> get departments {
  if (_departments is EqualUnmodifiableListView) return _departments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_departments);
}


/// Create a copy of DepartmentListing
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DepartmentListingCopyWith<_DepartmentListing> get copyWith => __$DepartmentListingCopyWithImpl<_DepartmentListing>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _DepartmentListing&&const DeepCollectionEquality().equals(other.departments, _departments));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_departments));
}

@override
String toString() {
    return 'DepartmentListing(departments: $departments)';
}


}

/// @nodoc
abstract mixin class _$DepartmentListingCopyWith<$Res> implements $DepartmentListingCopyWith<$Res> {
  factory _$DepartmentListingCopyWith(_DepartmentListing value, $Res Function(_DepartmentListing) _then) = __$DepartmentListingCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(fromJson: _readDepartments) List<Department> departments
});




}
/// @nodoc
class __$DepartmentListingCopyWithImpl<$Res>
    implements _$DepartmentListingCopyWith<$Res> {
  __$DepartmentListingCopyWithImpl(this._self, this._then);

  final _DepartmentListing _self;
  final $Res Function(_DepartmentListing) _then;

/// Create a copy of DepartmentListing
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? departments = null,}) {
  return _then(_DepartmentListing(
departments: null == departments ? _self._departments : departments // ignore: cast_nullable_to_non_nullable
as List<Department>,
  ));
}


}

// dart format on
