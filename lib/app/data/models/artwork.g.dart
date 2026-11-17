// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artwork.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Artwork _$ArtworkFromJson(Map<String, dynamic> json) => _Artwork(
  id: (json['id'] as num).toInt(),
  imageUrl: json['imageUrl'] as String,
  pageUrl: json['pageUrl'] as String,
  title: json['title'] as String? ?? '',
  artist: json['artist'] as String? ?? '',
  date: json['date'] as String? ?? '',
  medium: json['medium'] as String? ?? '',
  department: json['department'] as String? ?? '',
  impressionOf: json['impressionOf'] as String?,
  moreImageUrls:
      (json['moreImageUrls'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const <String>[],
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const <String>[],
);

Map<String, dynamic> _$ArtworkToJson(_Artwork instance) => <String, dynamic>{
  'id': instance.id,
  'imageUrl': instance.imageUrl,
  'pageUrl': instance.pageUrl,
  'title': instance.title,
  'artist': instance.artist,
  'date': instance.date,
  'medium': instance.medium,
  'department': instance.department,
  'impressionOf': instance.impressionOf,
  'moreImageUrls': instance.moreImageUrls,
  'tags': instance.tags,
};
