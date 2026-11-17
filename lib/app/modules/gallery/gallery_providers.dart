import 'dart:async';

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/models/artwork.dart';
import '../../data/models/department.dart';
import '../../data/pagination/paged_artworks.dart';
import '../../data/repositories/favourites_local_repository.dart';
import '../../data/repositories/search_history_local_repository.dart';
import '../../data/services/collection_service.dart';
import 'gallery_helper.dart';

part 'gallery_providers.g.dart';

/// The query the gallery opens on: `?q=` from the address bar when there is
/// one, otherwise the default search. Nothing is written back to the URL.
@riverpod
String initialQuery(Ref ref) {
  final fromAddress = Uri.base.queryParameters['q'];
  return fromAddress == null ? kDefaultQuery : normaliseQuery(fromAddress);
}

/// The reader's favourites, newest first, kept in local storage.
///
/// Starts empty and fills in when the saved list has been read. Nothing is
/// written before then, and if storage fails the list lasts for the visit.
@riverpod
class Favourites extends _$Favourites {
  /// Done when the saved list has been read, or has failed to be.
  Future<void> _restored = Future<void>.value();

  @override
  List<Artwork> build() {
    _restored = Future.microtask(_restore);
    return const [];
  }

  /// Adds [artwork] to the collection, or removes it if it is in it.
  void toggle(Artwork artwork) {
    if (!ref.mounted) return;

    state = toggleFavourite(state, artwork);
    unawaited(_save());
  }

  Future<void> _restore() async {
    try {
      final saved = await ref.read(favouritesLocalRepositoryProvider).read();
      if (!ref.mounted) return;

      // Anything marked while the saved list was being read stays on top.
      final marked = {for (final artwork in state) artwork.id};
      state = [
        ...state,
        for (final artwork in saved)
          if (marked.add(artwork.id)) artwork,
      ];
    } catch (_) {
      // Nothing saved that can be read.
    }
  }

  Future<void> _save() async {
    await _restored;
    if (!ref.mounted) return;

    try {
      await ref.read(favouritesLocalRepositoryProvider).write(state);
    } catch (_) {
      // Not saved: the favourites last for this visit.
    }
  }
}

/// What the reader has searched for by typing, newest first, kept in local
/// storage. Like [Favourites], it works whether or not storage does.
@riverpod
class SearchHistory extends _$SearchHistory {
  /// Done when the saved list has been read, or has failed to be.
  Future<void> _restored = Future<void>.value();

  @override
  List<String> build() {
    _restored = Future.microtask(_restore);
    return const [];
  }

  /// Adds a search the reader typed. See [rememberSearch] for the rules.
  void remember(String query) => _set(rememberSearch(state, query));

  /// Removes one entry.
  void forget(String query) => _set(forgetSearch(state, query));

  void _set(List<String> history) {
    if (!ref.mounted || _sameEntries(history, state)) return;

    state = history;
    unawaited(_save());
  }

  Future<void> _restore() async {
    try {
      final saved = await ref.read(searchHistoryLocalRepositoryProvider).read();
      if (!ref.mounted) return;

      // Anything searched while the saved list was being read goes on top.
      var history = saved;
      for (final query in state.reversed) {
        history = rememberSearch(history, query);
      }
      state = history.take(kSearchHistoryLimit).toList();
    } catch (_) {
      // Nothing saved that can be read.
    }
  }

  Future<void> _save() async {
    // Never before the saved list has been read: an early write would
    // replace it.
    await _restored;
    if (!ref.mounted) return;

    try {
      await ref.read(searchHistoryLocalRepositoryProvider).write(state);
    } catch (_) {
      // Not saved: the history lasts for this visit.
    }
  }

  static bool _sameEntries(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}

/// The departments the search can be narrowed to.
///
/// A plain notifier holding an [AsyncValue], not a provider that fetches in
/// its build: Riverpod would retry a failing build on top of the HTTP
/// client's own retries. [retry] is what the filter's retry button calls.
@riverpod
class DepartmentOptions extends _$DepartmentOptions {
  @override
  AsyncValue<List<Department>> build() {
    Future.microtask(_load);
    return const AsyncLoading();
  }

  Future<void> retry() => _load();

  Future<void> _load() async {
    if (!ref.mounted) return;

    state = const AsyncLoading();
    final loaded = await AsyncValue.guard(
      ref.read(collectionServiceProvider).departments,
    );
    if (ref.mounted) state = loaded;
  }
}

/// The search results and the four things that can be asked: [search] for
/// something, [filterByDepartment] to narrow it, [loadMore] of the same,
/// [retry] whatever just failed.
@riverpod
class GalleryArtworks extends _$GalleryArtworks {
  /// The token of the one load whose result is still wanted.
  CancelToken? _inFlight;

  @override
  PagedArtworks build() {
    ref.onDispose(() => _inFlight?.cancel());

    final query = ref.watch(initialQueryProvider);
    // The provider starts its own first load, in a microtask because state
    // cannot be set while build() is running.
    Future.microtask(() => _load(query, department: null, fresh: true));
    return PagedArtworks(query: query, isLoading: true);
  }

  /// Starts a new search for [raw], unless that search is already up or on
  /// its way.
  Future<void> search(String raw) async {
    final query = normaliseQuery(raw);
    final sameQuery = query.toLowerCase() == state.query.toLowerCase();
    if (sameQuery && !_failedOutright) return;

    // The department stays: it is a filter on the search, not part of it.
    await _load(query, department: state.department, fresh: true);
  }

  /// Starts a new search for the current query within [department], or
  /// within all of them for null.
  Future<void> filterByDepartment(Department? department) async {
    if (department == state.department && !_failedOutright) return;

    await _load(state.query, department: department, fresh: true);
  }

  Future<void> loadMore() async {
    if (state.isLoading || !state.hasMore) return;

    await _load(state.query, department: state.department, fresh: false);
  }

  /// A failed first load starts again; a failed load-more picks up where
  /// it stopped.
  Future<void> retry() => _load(
    state.query,
    department: state.department,
    fresh: state.items.isEmpty,
  );

  bool get _failedOutright => state.items.isEmpty && state.failure != null;

  Future<void> _load(
    String query, {
    required Department? department,
    required bool fresh,
  }) async {
    if (!ref.mounted) return;

    // Latest request wins: the old one is cancelled, and the identity check
    // below discards anything of it that still lands.
    _inFlight?.cancel();
    final token = _inFlight = CancelToken();

    state = fresh
        ? PagedArtworks(query: query, department: department, isLoading: true)
        : state.copyWith(isLoading: true, failure: null);

    try {
      final page = await ref
          .read(collectionServiceProvider)
          .loadPage(
            query: query,
            offset: state.examined,
            departmentId: department?.departmentId,
            cancelToken: token,
          );
      if (!_owns(token)) return;

      state = state.append(page);
    } catch (error) {
      // A superseded load ends here too: its cancellation is an error.
      if (!_owns(token)) return;

      state = state.copyWith(isLoading: false, failure: pageFailureOf(error));
    }
  }

  bool _owns(CancelToken token) => ref.mounted && identical(token, _inFlight);
}
