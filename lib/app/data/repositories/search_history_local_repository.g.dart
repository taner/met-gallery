// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_history_local_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(searchHistoryLocalRepository)
final searchHistoryLocalRepositoryProvider =
    SearchHistoryLocalRepositoryProvider._();

final class SearchHistoryLocalRepositoryProvider
    extends
        $FunctionalProvider<
          SearchHistoryLocalRepository,
          SearchHistoryLocalRepository,
          SearchHistoryLocalRepository
        >
    with $Provider<SearchHistoryLocalRepository> {
  SearchHistoryLocalRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchHistoryLocalRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchHistoryLocalRepositoryHash();

  @$internal
  @override
  $ProviderElement<SearchHistoryLocalRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SearchHistoryLocalRepository create(Ref ref) {
    return searchHistoryLocalRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SearchHistoryLocalRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SearchHistoryLocalRepository>(value),
    );
  }
}

String _$searchHistoryLocalRepositoryHash() =>
    r'f79433fc9ed6640b434779ea18286bae1c1357eb';
