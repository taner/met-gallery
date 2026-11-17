import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/artwork.dart';

part 'favourites_local_repository.g.dart';

/// Keeps the favourites in the browser's local storage, through
/// shared_preferences. The whole artwork is saved, so the favourites view
/// needs no request.
///
/// Both methods can throw, for example when storage is blocked.
class FavouritesLocalRepository {
  const FavouritesLocalRepository();

  static const String _key = 'met_gallery.favourites';

  /// The saved favourites, newest first. An entry that cannot be read is
  /// left out.
  Future<List<Artwork>> read() async {
    final saved = await SharedPreferencesAsync().getStringList(_key);
    return [for (final entry in saved ?? const <String>[]) ?_decode(entry)];
  }

  Future<void> write(List<Artwork> favourites) {
    return SharedPreferencesAsync().setStringList(_key, [
      for (final artwork in favourites) jsonEncode(artwork.toJson()),
    ]);
  }

  static Artwork? _decode(String entry) {
    try {
      return Artwork.fromJson(jsonDecode(entry) as Map<String, dynamic>);
    } catch (_) {
      return null;
    }
  }
}

@Riverpod(keepAlive: true)
FavouritesLocalRepository favouritesLocalRepository(Ref ref) {
  return const FavouritesLocalRepository();
}
