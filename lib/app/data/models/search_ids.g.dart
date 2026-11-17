// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_ids.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SearchIds _$SearchIdsFromJson(Map<String, dynamic> json) => _SearchIds(
  total: (_totalOrPageSize(json, 'total') as num).toInt(),
  ids: _positiveIds(json['objectIDs']),
);
