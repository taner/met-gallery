// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_remote_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(collectionRemoteRepository)
final collectionRemoteRepositoryProvider =
    CollectionRemoteRepositoryProvider._();

final class CollectionRemoteRepositoryProvider
    extends
        $FunctionalProvider<
          CollectionRemoteRepository,
          CollectionRemoteRepository,
          CollectionRemoteRepository
        >
    with $Provider<CollectionRemoteRepository> {
  CollectionRemoteRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'collectionRemoteRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$collectionRemoteRepositoryHash();

  @$internal
  @override
  $ProviderElement<CollectionRemoteRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CollectionRemoteRepository create(Ref ref) {
    return collectionRemoteRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CollectionRemoteRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CollectionRemoteRepository>(value),
    );
  }
}

String _$collectionRemoteRepositoryHash() =>
    r'50799fca21e5d3141dfc72e88f8563b0b0709902';
