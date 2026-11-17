// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The one HTTP client, pointed at the collection API.
///
/// Timeouts are short on purpose. Dio's default is to wait forever, and a
/// grid of skeletons that never resolves is the worst state this module
/// has; an object record normally arrives in well under a second, so eight
/// is already generous. A timeout is not retried (see `appRetry`).
///
/// Two policies ride on the client as interceptors, so that they hold for
/// every request and no caller has to opt in: each request waits its turn
/// in the pacer, and a failure that might clear by itself is asked again.
/// A retry is a request through this same client, so it is paced too.

@ProviderFor(apiClient)
final apiClientProvider = ApiClientProvider._();

/// The one HTTP client, pointed at the collection API.
///
/// Timeouts are short on purpose. Dio's default is to wait forever, and a
/// grid of skeletons that never resolves is the worst state this module
/// has; an object record normally arrives in well under a second, so eight
/// is already generous. A timeout is not retried (see `appRetry`).
///
/// Two policies ride on the client as interceptors, so that they hold for
/// every request and no caller has to opt in: each request waits its turn
/// in the pacer, and a failure that might clear by itself is asked again.
/// A retry is a request through this same client, so it is paced too.

final class ApiClientProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  /// The one HTTP client, pointed at the collection API.
  ///
  /// Timeouts are short on purpose. Dio's default is to wait forever, and a
  /// grid of skeletons that never resolves is the worst state this module
  /// has; an object record normally arrives in well under a second, so eight
  /// is already generous. A timeout is not retried (see `appRetry`).
  ///
  /// Two policies ride on the client as interceptors, so that they hold for
  /// every request and no caller has to opt in: each request waits its turn
  /// in the pacer, and a failure that might clear by itself is asked again.
  /// A retry is a request through this same client, so it is paced too.
  ApiClientProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'apiClientProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$apiClientHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return apiClient(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$apiClientHash() => r'b677fadb8ae68cce2e30a0dccc2278e8e9d41683';
