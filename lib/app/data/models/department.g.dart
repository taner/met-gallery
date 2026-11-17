// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'department.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Department _$DepartmentFromJson(Map<String, dynamic> json) => _Department(
  departmentId: requiredJsonId(json['departmentId']),
  displayName: json['displayName'] == null
      ? ''
      : const SafeText().fromJson(json['displayName']),
);

_DepartmentListing _$DepartmentListingFromJson(Map<String, dynamic> json) =>
    _DepartmentListing(
      departments: json['departments'] == null
          ? const <Department>[]
          : _readDepartments(json['departments']),
    );
