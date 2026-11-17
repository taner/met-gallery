import 'dart:collection';

import 'package:dio/dio.dart';

/// Makes every request, retries included, wait its turn in a [RequestPacer]
/// before it is sent.
class PacingInterceptor extends Interceptor {
  PacingInterceptor(this._pacer);

  final RequestPacer _pacer;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final cancelToken = options.cancelToken;
    await _pacer.turn(isAbandoned: () => cancelToken?.isCancelled ?? false);

    // Cancelled while it waited: do not send it.
    final cancelled = cancelToken?.cancelError;
    if (cancelled != null) return handler.reject(cancelled);

    handler.next(options);
  }
}

/// Allows at most [limit] requests to start in any rolling [window]; the
/// next one waits for the oldest to age out.
///
/// The museum's firewall refuses requests past its rate limit with a 403
/// that has no CORS headers, which the browser reports as a network failure.
/// The default limit is set below that rate limit.
class RequestPacer {
  RequestPacer({
    this.limit = 60,
    this.window = const Duration(seconds: 60),
    DateTime Function()? now,
  }) : _now = now ?? DateTime.now;

  final int limit;
  final Duration window;
  final DateTime Function() _now;

  final Queue<DateTime> _starts = Queue<DateTime>();

  /// Completes when the caller may send one request. If [isAbandoned]
  /// returns true when the wait is checked, it completes without using up
  /// a place.
  Future<void> turn({bool Function()? isAbandoned}) async {
    while (true) {
      if (isAbandoned?.call() ?? false) return;

      final now = _now();
      while (_starts.isNotEmpty && now.difference(_starts.first) >= window) {
        _starts.removeFirst();
      }
      if (_starts.length < limit) {
        _starts.add(now);
        return;
      }

      await Future<void>.delayed(window - now.difference(_starts.first));
    }
  }
}
