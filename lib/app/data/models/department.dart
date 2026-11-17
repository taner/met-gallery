import 'package:freezed_annotation/freezed_annotation.dart';

import '../converters/safe_json.dart';

part 'department.freezed.dart';
part 'department.g.dart';

/// One of the museum's curatorial departments, as `GET /v1/departments`
/// documents it. `fromJson` throws [FormatException] without a
/// [departmentId], which is what the search filter takes.
@Freezed(toJson: false)
abstract class Department with _$Department {
  @JsonSerializable(createToJson: false, converters: safeConverters)
  const factory Department({
    @JsonKey(fromJson: requiredJsonId) required int departmentId,
    @Default('') String displayName,
  }) = _Department;

  factory Department.fromJson(Map<String, dynamic> json) =>
      _$DepartmentFromJson(json);
}

/// The response of `GET /v1/departments`. An entry that cannot be read is
/// skipped.
@Freezed(toJson: false)
abstract class DepartmentListing with _$DepartmentListing {
  @JsonSerializable(createToJson: false)
  const factory DepartmentListing({
    @JsonKey(fromJson: _readDepartments)
    @Default(<Department>[])
    List<Department> departments,
  }) = _DepartmentListing;

  factory DepartmentListing.fromJson(Map<String, dynamic> json) =>
      _$DepartmentListingFromJson(json);
}

List<Department> _readDepartments(Object? json) =>
    safeObjects(json, Department.fromJson);
