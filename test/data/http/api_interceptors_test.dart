import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:met_gallery/app/data/http/api_client.dart';
import 'package:met_gallery/app/data/http/pacing_interceptor.dart';
import 'package:met_gallery/app/data/http/retry_interceptor.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// The network, scripted: [answer] gives the status for each request, or
/// throws. Every request is written to [sent] with the fake time it left
/// at.
class ScriptedNetwork implements HttpClientAdapter {
  ScriptedNetwork(this._async, this.answer);

  final FakeAsync _async;
  int Function(RequestOptions options) answer;

  final List<(String path, Duration at)> sent = [];

  List<String> get paths => [for (final (path, _) in sent) path];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    sent.add((options.path, _async.elapsed));
    return ResponseBody.fromString(
      '{"ok":true}',
      answer(options),
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  /// A client wired as the app's is, on fake time, with a small budget:
  /// [limit] requests per ten seconds.
  (Dio, ScriptedNetwork) clientOn(
    FakeAsync async, {
    required int Function(RequestOptions options) answer,
    int limit = 100,
  }) {
    final epoch = DateTime(2026, 11, 17);
    final network = ScriptedNetwork(async, answer);
    final dio = Dio(BaseOptions(baseUrl: 'https://museum.test'))
      ..httpClientAdapter = network;
    dio.interceptors.addAll([
      PacingInterceptor(
        RequestPacer(
          limit: limit,
          window: const Duration(seconds: 10),
          now: () => epoch.add(async.elapsed),
        ),
      ),
      RetryInterceptor(dio),
    ]);
    return (dio, network);
  }

  DioException connectionError(RequestOptions options) =>
      DioException.connectionError(requestOptions: options, reason: 'down');

  group('RetryInterceptor', () {
    test('rides out a blip: fails twice, then the caller gets the answer', () {
      fakeAsync((async) {
        var failures = 2;
        final (dio, network) = clientOn(
          async,
          answer: (_) => failures-- > 0 ? 503 : 200,
        );

        Response<dynamic>? response;
        dio.get<dynamic>('/v1/objects/1').then((r) => response = r);

        // 200 ms, then 400 ms: nothing is asked again before its backoff.
        async.elapse(const Duration(milliseconds: 199));
        expect(network.sent, hasLength(1));
        async.elapse(const Duration(milliseconds: 401));

        expect(response!.statusCode, 200);
        expect(response!.data, {'ok': true});
        expect(network.paths, List.filled(3, '/v1/objects/1'));
      });
    });

    test('gives up with the last error after four attempts in all', () {
      fakeAsync((async) {
        final (dio, network) = clientOn(
          async,
          answer: (options) => throw connectionError(options),
        );

        Object? thrown;
        dio
            .get<dynamic>('/v1.1/search')
            .then<void>((_) {}, onError: (Object error) => thrown = error);
        async.elapse(const Duration(seconds: 10));

        expect(network.sent, hasLength(1 + kAppRetryLimit));
        expect(
          thrown,
          isA<DioException>().having(
            (e) => e.type,
            'type',
            DioExceptionType.connectionError,
          ),
        );
      });
    });

    test('an answer is not asked again: a 410 or a 404 is sent once', () {
      // 410 is the live case: the retired v1 search endpoint.
      fakeAsync((async) {
        for (final status in [410, 404]) {
          final (dio, network) = clientOn(async, answer: (_) => status);

          Object? thrown;
          dio
              .get<dynamic>('/v1/search')
              .then<void>((_) {}, onError: (Object error) => thrown = error);
          async.elapse(const Duration(seconds: 10));

          expect(network.sent, hasLength(1), reason: '$status');
          expect(
            (thrown! as DioException).response?.statusCode,
            status,
            reason: '$status',
          );
        }
      });
    });

    test('a search that was superseded during the backoff is not sent '
        'again', () {
      fakeAsync((async) {
        final (dio, network) = clientOn(async, answer: (_) => 503);
        final cancelToken = CancelToken();

        Object? thrown;
        dio
            .get<dynamic>('/v1.1/search', cancelToken: cancelToken)
            .then<void>((_) {}, onError: (Object error) => thrown = error);
        async.elapse(const Duration(milliseconds: 100));
        cancelToken.cancel();
        async.elapse(const Duration(seconds: 10));

        expect(network.sent, hasLength(1));
        expect((thrown! as DioException).type, DioExceptionType.cancel);
      });
    });
  });

  group('PacingInterceptor', () {
    test('a retry takes a turn like any other request: it spends budget '
        'too', () {
      fakeAsync((async) {
        // Two requests per ten seconds, and a request that needs three
        // attempts.
        var failures = 2;
        final (dio, network) = clientOn(
          async,
          limit: 2,
          answer: (_) => failures-- > 0 ? 503 : 200,
        );

        Response<dynamic>? response;
        dio.get<dynamic>('/v1/objects/1').then((r) => response = r);

        // The first attempt and the first retry use the budget up. The
        // second retry is due at 600 ms and has to wait for the window.
        async.elapse(const Duration(seconds: 9));
        expect(network.sent, hasLength(2));
        expect(response, isNull);

        async.elapse(const Duration(seconds: 2));
        expect(network.sent, hasLength(3));
        expect(network.sent.last.$2, const Duration(seconds: 10));
        expect(response!.statusCode, 200);
      });
    });

    test('a request cancelled while it waits its turn is never sent and '
        'costs nothing', () {
      fakeAsync((async) {
        final (dio, network) = clientOn(async, limit: 1, answer: (_) => 200);
        // Dio hands a request on through the event queue, so this is a
        // tick of time, not a flush of microtasks.
        void settle() => async.elapse(const Duration(milliseconds: 1));

        dio.get<dynamic>('/first');
        settle();
        expect(network.paths, ['/first']);

        // The budget is spent, so this one queues, and is then overtaken.
        final cancelToken = CancelToken();
        Object? thrown;
        dio
            .get<dynamic>('/superseded', cancelToken: cancelToken)
            .then<void>((_) {}, onError: (Object error) => thrown = error);
        async.elapse(const Duration(seconds: 1));
        cancelToken.cancel();
        settle();
        expect((thrown! as DioException).type, DioExceptionType.cancel);

        // When the window opens, the turn it would have taken is free.
        async.elapse(const Duration(seconds: 9));
        dio.get<dynamic>('/next');
        settle();

        expect(network.paths, ['/first', '/next']);
      });
    });
  });

  test('the app\'s client is the one with both policies on it', () {
    final container = ProviderContainer.test();

    final interceptors = container.read(apiClientProvider).interceptors;

    expect(interceptors.whereType<PacingInterceptor>(), hasLength(1));
    expect(interceptors.whereType<RetryInterceptor>(), hasLength(1));
  });
}
