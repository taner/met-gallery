import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'search_history_local_repository.g.dart';

/// Keeps the search history in the browser's local storage, through
/// shared_preferences. What goes into the history is decided by
/// `rememberSearch` in `gallery_helper.dart`.
///
/// Both methods can throw, for example when storage is blocked.
class SearchHistoryLocalRepository {
  const SearchHistoryLocalRepository();

  static const String _key = 'met_gallery.search_history';

  /// The saved history, newest first; empty when nothing was saved.
  Future<List<String>> read() async {
    return await SharedPreferencesAsync().getStringList(_key) ?? const [];
  }

  Future<void> write(List<String> history) {
    return SharedPreferencesAsync().setStringList(_key, history);
  }
}

@Riverpod(keepAlive: true)
SearchHistoryLocalRepository searchHistoryLocalRepository(Ref ref) {
  return const SearchHistoryLocalRepository();
}
