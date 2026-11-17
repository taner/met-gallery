/// Converters used in place of json_serializable's casts, so that a field
/// of the wrong type costs that field and not the whole record.
///
/// Only an unreadable id fails a record (see [requiredJsonId]).
library;

import 'package:json_annotation/json_annotation.dart';

/// Passed to `@JsonSerializable(converters: ...)` on each model.
const safeConverters = <JsonConverter<dynamic, dynamic>>[
  SafeText(),
  SafeBool(),
  SafeInt(),
  SafeDouble(),
  SafeDate(),
];

/// A trimmed string. A number becomes its text; anything else is empty.
class SafeText extends JsonConverter<String, Object?> {
  const SafeText();

  @override
  String fromJson(Object? json) => switch (json) {
    final String text => text.trim(),
    final num number => number.toString(),
    _ => '',
  };

  @override
  Object? toJson(String object) => object;
}

class SafeBool extends JsonConverter<bool, Object?> {
  const SafeBool();

  @override
  bool fromJson(Object? json) => json == true;

  @override
  Object? toJson(bool object) => object;
}

/// A whole number, also from a string or from `12.0`.
class SafeInt extends JsonConverter<int?, Object?> {
  const SafeInt();

  @override
  int? fromJson(Object? json) => switch (json) {
    final int number => number,
    final double number when number == number.truncateToDouble() =>
      number.toInt(),
    final String text => int.tryParse(text.trim()),
    _ => null,
  };

  @override
  Object? toJson(int? object) => object;
}

/// A number, also from a string.
class SafeDouble extends JsonConverter<double?, Object?> {
  const SafeDouble();

  @override
  double? fromJson(Object? json) => switch (json) {
    final num number => number.toDouble(),
    final String text => double.tryParse(text.trim()),
    _ => null,
  };

  @override
  Object? toJson(double? object) => object;
}

/// An ISO 8601 timestamp.
class SafeDate extends JsonConverter<DateTime?, Object?> {
  const SafeDate();

  @override
  DateTime? fromJson(Object? json) =>
      json is String ? DateTime.tryParse(json.trim()) : null;

  @override
  Object? toJson(DateTime? object) => object?.toIso8601String();
}

/// A record's id. Throws [FormatException] unless it is a positive whole
/// number.
int requiredJsonId(Object? json) {
  final id = const SafeInt().fromJson(json);
  if (id == null || id <= 0) {
    throw FormatException('Not a usable id: $json');
  }
  return id;
}

/// The items of a list that [fromJson] can read. Other items, and a value
/// that is not a list, are skipped.
List<T> safeObjects<T>(
  Object? json,
  T Function(Map<String, dynamic> json) fromJson,
) {
  final items = <T>[];
  if (json is! List) return items;

  for (final item in json) {
    if (item is! Map) continue;
    try {
      items.add(fromJson(item.cast<String, dynamic>()));
    } on FormatException {
      // No usable id: skip it.
    }
  }
  return items;
}
