import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Every address the app talks to.
///
/// The values come from the `.env` file at the project root, bundled as an
/// asset and read by flutter_dotenv at start. Each has a default here, so
/// a missing file, key or value still gives the museum's real address.
abstract final class Env {
  static const String _defaultCollectionBaseUrl =
      'https://collectionapi.metmuseum.org/public/collection';
  static const String _defaultObjectPageBaseUrl =
      'https://www.metmuseum.org/art/collection/search';

  /// Reads `.env`. Never throws: on any failure the defaults are used.
  static Future<void> load() async {
    try {
      await dotenv.load(isOptional: true);
    } catch (_) {
      // Leaves dotenv uninitialised, which [_read] treats as "use the
      // defaults".
    }
  }

  /// Root of the Met's Collection API, without a version segment: the
  /// version belongs to each endpoint.
  static String get collectionBaseUrl =>
      _read('COLLECTION_BASE_URL', fallback: _defaultCollectionBaseUrl);

  /// Where an artwork's page lives on the museum's site. Used when a
  /// record has no usable `objectURL` of its own.
  static String get objectPageBaseUrl =>
      _read('OBJECT_PAGE_BASE_URL', fallback: _defaultObjectPageBaseUrl);

  static String _read(String key, {required String fallback}) {
    // dotenv throws when read before it has loaded.
    if (!dotenv.isInitialized) return fallback;

    final value = dotenv.maybeGet(key)?.trim() ?? '';
    return value.isEmpty ? fallback : value;
  }
}
