// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(collectionService)
final collectionServiceProvider = CollectionServiceProvider._();

final class CollectionServiceProvider
    extends
        $FunctionalProvider<
          CollectionService,
          CollectionService,
          CollectionService
        >
    with $Provider<CollectionService> {
  CollectionServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'collectionServiceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$collectionServiceHash();

  @$internal
  @override
  $ProviderElement<CollectionService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CollectionService create(Ref ref) {
    return collectionService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CollectionService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CollectionService>(value),
    );
  }
}

String _$collectionServiceHash() => r'3d79f5fb53b509b30c5290256f521dbc55110627';
