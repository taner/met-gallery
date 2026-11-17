import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../env.dart';
import 'collection_object.dart';

part 'artwork.freezed.dart';
part 'artwork.g.dart';

/// How many further pictures of a work are kept for the detail view.
const int kMoreImagesLimit = 11;

/// One work that can be shown: it has an id and a usable image. Made from
/// a `CollectionObject`; every other field defaults to empty.
@freezed
abstract class Artwork with _$Artwork {
  const Artwork._();

  const factory Artwork({
    required int id,
    required String imageUrl,
    required String pageUrl,
    @Default('') String title,
    @Default('') String artist,
    @Default('') String date,
    @Default('') String medium,
    @Default('') String department,

    /// Which print this record is an impression of; null when it is not a
    /// print. Only the first work with a given value is shown (see
    /// `PagedArtworks.append`).
    String? impressionOf,

    /// Other pictures of the same work, in the same size as [imageUrl].
    @Default(<String>[]) List<String> moreImageUrls,

    /// The museum's subject keywords, each usable as a search.
    @Default(<String>[]) List<String> tags,
  }) = _Artwork;

  /// An artwork as this app saved it (a favourite). A record from the API
  /// goes through [ArtworkJsonHandler.fromRecord] instead.
  factory Artwork.fromJson(Map<String, dynamic> json) =>
      _$ArtworkFromJson(json);

  /// Every picture of the work, the tile's picture first.
  List<String> get imageUrls => [imageUrl, ...moreImageUrls];

  /// The second caption line: artist and date, whichever exist.
  String get byline =>
      [artist, date].where((part) => part.isNotEmpty).join(' · ');
}

extension ArtworkJsonHandler on Artwork {
  /// The artwork in an object record, or null when the record cannot be
  /// shown: not an object, no id, or no usable image. Works in copyright
  /// come back with an empty `primaryImageSmall`.
  static Artwork? fromRecord(Object? json) {
    if (json is! Map) return null;

    final CollectionObject object;
    try {
      object = CollectionObject.fromJson(json.cast<String, dynamic>());
    } on FormatException {
      // No usable `objectID`.
      return null;
    }

    final imageUrl = _httpUrl(object.primaryImageSmall);
    if (imageUrl == null) return null;

    return Artwork(
      id: object.objectId,
      imageUrl: imageUrl,
      // The museum's site addresses every object by id.
      pageUrl:
          _httpUrl(object.objectUrl) ??
          '${Env.objectPageBaseUrl}/${object.objectId}',
      title: object.title,
      // Without a named maker, the caption leads with the culture.
      artist: object.artistDisplayName.isNotEmpty
          ? object.artistDisplayName
          : object.culture,
      date: object.objectDate,
      medium: object.medium,
      department: object.department,
      impressionOf: _impressionOf(object),
      moreImageUrls: _moreImages(object, shown: imageUrl),
      tags: _tags(object),
    );
  }

  /// Further pictures, as the smaller `web-large` version of each original
  /// the record lists. The API does not document that address, so it is an
  /// assumption.
  static List<String> _moreImages(
    CollectionObject object, {
    required String shown,
  }) {
    final urls = <String>{};
    for (final original in object.additionalImages) {
      final url = _httpUrl(original.replaceFirst('/original/', '/web-large/'));
      if (url == null || url == shown) continue;
      urls.add(url);
      if (urls.length == kMoreImagesLimit) break;
    }
    return urls.toList();
  }

  static List<String> _tags(CollectionObject object) => {
    for (final tag in object.tags)
      if (tag.term.isNotEmpty) tag.term,
  }.toList();

  /// The key that impressions of one print share. Only for records the
  /// museum classifies as prints, with a title and a named maker. The
  /// title is compared up to its first parenthesis, because the museum
  /// words the rest differently from record to record.
  static String? _impressionOf(CollectionObject object) {
    if (object.classification.toLowerCase() != 'prints') return null;

    final title = object.title.split('(').first.trim();
    final maker = object.artistDisplayName;
    if (title.isEmpty || maker.isEmpty) return null;

    return [title, maker, object.objectDate].join('|').toLowerCase();
  }

  static String? _httpUrl(String value) {
    final uri = Uri.tryParse(value);
    if (uri == null || !uri.hasAuthority) return null;
    if (uri.scheme != 'https' && uri.scheme != 'http') return null;
    return uri.toString();
  }
}
