// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The query the gallery opens on: `?q=` from the address bar when there is
/// one, otherwise the default search. Nothing is written back to the URL.

@ProviderFor(initialQuery)
final initialQueryProvider = InitialQueryProvider._();

/// The query the gallery opens on: `?q=` from the address bar when there is
/// one, otherwise the default search. Nothing is written back to the URL.

final class InitialQueryProvider
    extends $FunctionalProvider<String, String, String>
    with $Provider<String> {
  /// The query the gallery opens on: `?q=` from the address bar when there is
  /// one, otherwise the default search. Nothing is written back to the URL.
  InitialQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'initialQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$initialQueryHash();

  @$internal
  @override
  $ProviderElement<String> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  String create(Ref ref) {
    return initialQuery(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$initialQueryHash() => r'3301996e8ec29feb8dea4945882ed627e905e4c1';

/// The reader's favourites, newest first, kept in local storage.
///
/// Starts empty and fills in when the saved list has been read. Nothing is
/// written before then, and if storage fails the list lasts for the visit.

@ProviderFor(Favourites)
final favouritesProvider = FavouritesProvider._();

/// The reader's favourites, newest first, kept in local storage.
///
/// Starts empty and fills in when the saved list has been read. Nothing is
/// written before then, and if storage fails the list lasts for the visit.
final class FavouritesProvider
    extends $NotifierProvider<Favourites, List<Artwork>> {
  /// The reader's favourites, newest first, kept in local storage.
  ///
  /// Starts empty and fills in when the saved list has been read. Nothing is
  /// written before then, and if storage fails the list lasts for the visit.
  FavouritesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favouritesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favouritesHash();

  @$internal
  @override
  Favourites create() => Favourites();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Artwork> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Artwork>>(value),
    );
  }
}

String _$favouritesHash() => r'b3dce6abb523ae95b7b3ff6662c92d9c3bbdfcaf';

/// The reader's favourites, newest first, kept in local storage.
///
/// Starts empty and fills in when the saved list has been read. Nothing is
/// written before then, and if storage fails the list lasts for the visit.

abstract class _$Favourites extends $Notifier<List<Artwork>> {
  List<Artwork> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<Artwork>, List<Artwork>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Artwork>, List<Artwork>>,
              List<Artwork>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// What the reader has searched for by typing, newest first, kept in local
/// storage. Like [Favourites], it works whether or not storage does.

@ProviderFor(SearchHistory)
final searchHistoryProvider = SearchHistoryProvider._();

/// What the reader has searched for by typing, newest first, kept in local
/// storage. Like [Favourites], it works whether or not storage does.
final class SearchHistoryProvider
    extends $NotifierProvider<SearchHistory, List<String>> {
  /// What the reader has searched for by typing, newest first, kept in local
  /// storage. Like [Favourites], it works whether or not storage does.
  SearchHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchHistoryHash();

  @$internal
  @override
  SearchHistory create() => SearchHistory();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>>(value),
    );
  }
}

String _$searchHistoryHash() => r'24fec3fda02e00cf30e22be8258e7c56e1b9b463';

/// What the reader has searched for by typing, newest first, kept in local
/// storage. Like [Favourites], it works whether or not storage does.

abstract class _$SearchHistory extends $Notifier<List<String>> {
  List<String> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<List<String>, List<String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<String>, List<String>>,
              List<String>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// The departments the search can be narrowed to.
///
/// A plain notifier holding an [AsyncValue], not a provider that fetches in
/// its build: Riverpod would retry a failing build on top of the HTTP
/// client's own retries. [retry] is what the filter's retry button calls.

@ProviderFor(DepartmentOptions)
final departmentOptionsProvider = DepartmentOptionsProvider._();

/// The departments the search can be narrowed to.
///
/// A plain notifier holding an [AsyncValue], not a provider that fetches in
/// its build: Riverpod would retry a failing build on top of the HTTP
/// client's own retries. [retry] is what the filter's retry button calls.
final class DepartmentOptionsProvider
    extends $NotifierProvider<DepartmentOptions, AsyncValue<List<Department>>> {
  /// The departments the search can be narrowed to.
  ///
  /// A plain notifier holding an [AsyncValue], not a provider that fetches in
  /// its build: Riverpod would retry a failing build on top of the HTTP
  /// client's own retries. [retry] is what the filter's retry button calls.
  DepartmentOptionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'departmentOptionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$departmentOptionsHash();

  @$internal
  @override
  DepartmentOptions create() => DepartmentOptions();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AsyncValue<List<Department>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AsyncValue<List<Department>>>(value),
    );
  }
}

String _$departmentOptionsHash() => r'b03d594a127072016316b6f9072fa2bad5050316';

/// The departments the search can be narrowed to.
///
/// A plain notifier holding an [AsyncValue], not a provider that fetches in
/// its build: Riverpod would retry a failing build on top of the HTTP
/// client's own retries. [retry] is what the filter's retry button calls.

abstract class _$DepartmentOptions
    extends $Notifier<AsyncValue<List<Department>>> {
  AsyncValue<List<Department>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<Department>>, AsyncValue<List<Department>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<Department>>,
                AsyncValue<List<Department>>
              >,
              AsyncValue<List<Department>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

/// The search results and the four things that can be asked: [search] for
/// something, [filterByDepartment] to narrow it, [loadMore] of the same,
/// [retry] whatever just failed.

@ProviderFor(GalleryArtworks)
final galleryArtworksProvider = GalleryArtworksProvider._();

/// The search results and the four things that can be asked: [search] for
/// something, [filterByDepartment] to narrow it, [loadMore] of the same,
/// [retry] whatever just failed.
final class GalleryArtworksProvider
    extends $NotifierProvider<GalleryArtworks, PagedArtworks> {
  /// The search results and the four things that can be asked: [search] for
  /// something, [filterByDepartment] to narrow it, [loadMore] of the same,
  /// [retry] whatever just failed.
  GalleryArtworksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'galleryArtworksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$galleryArtworksHash();

  @$internal
  @override
  GalleryArtworks create() => GalleryArtworks();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PagedArtworks value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PagedArtworks>(value),
    );
  }
}

String _$galleryArtworksHash() => r'fa7728c02aeeee6a15aefcc2385f8ef2d307e336';

/// The search results and the four things that can be asked: [search] for
/// something, [filterByDepartment] to narrow it, [loadMore] of the same,
/// [retry] whatever just failed.

abstract class _$GalleryArtworks extends $Notifier<PagedArtworks> {
  PagedArtworks build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<PagedArtworks, PagedArtworks>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PagedArtworks, PagedArtworks>,
              PagedArtworks,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
