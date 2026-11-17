import 'package:fake_async/fake_async.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:met_gallery/app/data/http/pacing_interceptor.dart';

void main() {
  /// A pacer on fake time: three requests per ten seconds.
  RequestPacer pacerOn(FakeAsync async) {
    final epoch = DateTime(2026, 11, 16);
    return RequestPacer(
      limit: 3,
      window: const Duration(seconds: 10),
      now: () => epoch.add(async.elapsed),
    );
  }

  group('RequestPacer (stay inside the budget the museum enforces)', () {
    test('requests inside the budget are not delayed at all', () {
      fakeAsync((async) {
        final pacer = pacerOn(async);
        var started = 0;

        for (var i = 0; i < 3; i++) {
          pacer.turn().then((_) => started++);
        }
        async.flushMicrotasks();

        expect(started, 3);
      });
    });

    test('the request over budget waits for the oldest to age out', () {
      fakeAsync((async) {
        final pacer = pacerOn(async);
        var started = 0;

        // Two at t=0, one at t=4: the window is full.
        pacer.turn().then((_) => started++);
        pacer.turn().then((_) => started++);
        async.elapse(const Duration(seconds: 4));
        pacer.turn().then((_) => started++);
        async.flushMicrotasks();
        expect(started, 3);

        pacer.turn().then((_) => started++);
        pacer.turn().then((_) => started++);
        pacer.turn().then((_) => started++);

        // Just before the first two leave the window: still held.
        async.elapse(const Duration(milliseconds: 5999));
        expect(started, 3);

        // t=10: two places open, and only two of the three waiters go.
        async.elapse(const Duration(milliseconds: 1));
        expect(started, 5);

        // t=14: the request from t=4 ages out and the last one goes.
        async.elapse(const Duration(seconds: 4));
        expect(started, 6);
      });
    });

    test('an abandoned request gives up its place and spends nothing', () {
      fakeAsync((async) {
        final pacer = pacerOn(async);
        for (var i = 0; i < 3; i++) {
          pacer.turn();
        }
        async.flushMicrotasks();

        // Queued behind a full window, then its search is superseded.
        var abandoned = false;
        var returned = false;
        pacer.turn(isAbandoned: () => abandoned).then((_) => returned = true);
        abandoned = true;
        async.elapse(const Duration(seconds: 10));
        expect(returned, isTrue);

        // Had it taken a place, only two of these would start now.
        var started = 0;
        for (var i = 0; i < 3; i++) {
          pacer.turn().then((_) => started++);
        }
        async.flushMicrotasks();
        expect(started, 3);
      });
    });
  });
}
