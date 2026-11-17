import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {
  RetryInterceptor(this._dio);

  final Dio _dio;

  static const String _retryCountKey = 'app_retry_count';

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final options = err.requestOptions;
    final retryCount = options.extra[_retryCountKey] as int? ?? 0;

    final delay = appRetry(retryCount, err);
    if (delay == null) return handler.next(err);

    await Future<void>.delayed(delay);

    // Cancelled during the backoff: do not send it again.
    final cancelled = options.cancelToken?.cancelError;
    if (cancelled != null) return handler.reject(cancelled);

    options.extra[_retryCountKey] = retryCount + 1;
    try {
      handler.resolve(await _dio.fetch<dynamic>(options));
    } on DioException catch (error) {
      // The retry has already been through this interceptor.
      handler.reject(error);
    }
  }
}

const int kAppRetryLimit = 3;

Duration? appRetry(int retryCount, Object error) {
  if (retryCount >= kAppRetryLimit) return null;
  if (!isTransient(error)) return null;

  return Duration(milliseconds: 200 * (1 << retryCount));
}

bool isTransient(Object error) {
  if (error is! DioException) return false;

  return switch (error.type) {
    DioExceptionType.connectionError => true,
    DioExceptionType.badResponse => _isTransientStatus(
      error.response?.statusCode,
    ),
    _ => false,
  };
}

bool _isTransientStatus(int? status) =>
    status != null && (status >= 500 || status == 429);
