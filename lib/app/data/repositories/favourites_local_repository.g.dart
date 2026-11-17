// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourites_local_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(favouritesLocalRepository)
final favouritesLocalRepositoryProvider = FavouritesLocalRepositoryProvider._();

final class FavouritesLocalRepositoryProvider
    extends
        $FunctionalProvider<
          FavouritesLocalRepository,
          FavouritesLocalRepository,
          FavouritesLocalRepository
        >
    with $Provider<FavouritesLocalRepository> {
  FavouritesLocalRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favouritesLocalRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favouritesLocalRepositoryHash();

  @$internal
  @override
  $ProviderElement<FavouritesLocalRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FavouritesLocalRepository create(Ref ref) {
    return favouritesLocalRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FavouritesLocalRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FavouritesLocalRepository>(value),
    );
  }
}

String _$favouritesLocalRepositoryHash() =>
    r'd0f6b1df2a83882df01ec9f67191ce1fc3c8fc09';
