import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:met_gallery/app/data/repositories/collection_remote_repository.dart';

/// Answers every request with an empty object and keeps the address it was
/// sent to.
class _RecordingNetwork implements HttpClientAdapter {
  final List<Uri> sent = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    sent.add(options.uri);
    return ResponseBody.fromString(
      '{}',
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  test('a search sends only the filters that are set: no q for an empty '
      'query, no departmentId without a department', () async {
    final network = _RecordingNetwork();
    final repository = CollectionRemoteRepository(
      Dio(BaseOptions(baseUrl: 'https://museum.test'))
        ..httpClientAdapter = network,
    );

    await repository.search(query: 'hokusai', offset: 0, limit: 12);
    await repository.search(query: '', offset: 12, limit: 12, departmentId: 6);

    expect(network.sent[0].path, '/v1.1/search');
    expect(network.sent[0].queryParameters, {
      'hasImages': 'true',
      'q': 'hokusai',
      'offset': '0',
      'limit': '12',
    });
    expect(network.sent[1].queryParameters, {
      'hasImages': 'true',
      'departmentId': '6',
      'offset': '12',
      'limit': '12',
    });
  });
}
