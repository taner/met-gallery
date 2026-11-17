import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:met_gallery/app/data/http/retry_interceptor.dart';

import '../../support/fakes.dart';

DioException timeout() => DioException.receiveTimeout(
  timeout: const Duration(seconds: 8),
  requestOptions: RequestOptions(path: '/'),
);

void main() {
  group('appRetry (retry only what can change by itself)', () {
    test('a dead connection, a 5xx and a 429 are asked again', () {
      for (final error in [connectionError(), httpError(503), httpError(429)]) {
        expect(appRetry(0, error), isNotNull, reason: '$error');
      }
    });

    test('an answer is not asked again', () {
      // 410 is the live case: the retired v1 search endpoint.
      for (final status in [400, 403, 404, 410]) {
        expect(appRetry(0, httpError(status)), isNull, reason: '$status');
      }
    });

    test('a timeout goes straight to the retry button', () {
      // Someone has already watched a skeleton for eight seconds.
      expect(appRetry(0, timeout()), isNull);
    });

    test('a bug is not asked again', () {
      expect(appRetry(0, const FormatException('not json')), isNull);
      expect(appRetry(0, StateError('oops')), isNull);
    });

    test('backs off 200 ms doubling, and stops after three retries', () {
      final error = connectionError();

      expect(appRetry(0, error), const Duration(milliseconds: 200));
      expect(appRetry(1, error), const Duration(milliseconds: 400));
      expect(appRetry(2, error), const Duration(milliseconds: 800));
      expect(appRetry(kAppRetryLimit, error), isNull);
    });
  });
}
