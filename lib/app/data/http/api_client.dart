import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../env.dart';
import 'pacing_interceptor.dart';
import 'retry_interceptor.dart';

part 'api_client.g.dart';

/// The one HTTP client, pointed at the collection API.
///
/// Timeouts are short, because Dio's default is to wait forever. Pacing
/// and retries are interceptors, so they hold for every request, and a
/// retry is paced too.
@Riverpod(keepAlive: true)
Dio apiClient(Ref ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: Env.collectionBaseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 8),
      responseType: ResponseType.json,
    ),
  );
  dio.interceptors.addAll([
    PacingInterceptor(RequestPacer()),
    RetryInterceptor(dio),
  ]);
  ref.onDispose(dio.close);
  return dio;
}
