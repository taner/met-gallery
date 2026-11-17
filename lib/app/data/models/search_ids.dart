import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_ids.freezed.dart';
part 'search_ids.g.dart';

/// The search response: how many objects matched, and the ids of one page
/// of them. No matches arrive as `"objectIDs": null`, which reads as empty.
@Freezed(toJson: false)
abstract class SearchIds with _$SearchIds {
  @JsonSerializable(createToJson: false)
  const factory SearchIds({
    /// `total`. Every match, across all pages.
    @JsonKey(readValue: _totalOrPageSize) required int total,

    /// `objectIDs`.
    @JsonKey(name: 'objectIDs', fromJson: _positiveIds) required List<int> ids,
  }) = _SearchIds;

  factory SearchIds.fromJson(Map<String, dynamic> json) =>
      _$SearchIdsFromJson(json);
}

extension SearchIdsJsonHandler on SearchIds {
  /// A response body to [SearchIds]. Throws [FormatException] when the
  /// body is not a JSON object, so an error page is never read as "no
  /// matches".
  static SearchIds fromJson(Object? json) {
    if (json is! Map) {
      throw const FormatException('Search response is not a JSON object');
    }

    return SearchIds.fromJson(json.cast<String, dynamic>());
  }
}

List<int> _positiveIds(Object? json) => [
  if (json is List)
    for (final id in json)
      if (id is int && id > 0) id,
];

/// A missing total falls back to the number of ids on this page.
Object? _totalOrPageSize(Map<dynamic, dynamic> json, String key) {
  final total = json[key];
  return total is int && total >= 0
      ? total
      : _positiveIds(json['objectIDs']).length;
}
