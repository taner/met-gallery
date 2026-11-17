import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../http/api_client.dart';

part 'collection_remote_repository.g.dart';

/// HTTP only: paths and parameters. `CollectionService` reads the bodies
/// and decides what a failure means.
class CollectionRemoteRepository {
  final Dio _dio;

  CollectionRemoteRepository(this._dio);

  /// One page of the ids matching [query], on `v1.1`, which pages with
  /// `offset` and `limit`. The other endpoints are still on `v1`.
  ///
  /// `hasImages=true` does not promise an image that may be shown (see
  /// `ArtworkJsonHandler.fromRecord`). An empty [query] is sent as no `q`,
  /// and the API ignores a [departmentId] it does not know.
  Future<Response<dynamic>> search({
    required String query,
    required int offset,
    required int limit,
    int? departmentId,
    CancelToken? cancelToken,
  }) {
    return _dio.get<dynamic>(
      '/v1.1/search',
      queryParameters: {
        'hasImages': true,
        'q': ?(query.isEmpty ? null : query),
        'departmentId': ?departmentId,
        'offset': offset,
        'limit': limit,
      },
      cancelToken: cancelToken,
    );
  }

  /// The full record of one object.
  Future<Response<dynamic>> object(int id, {CancelToken? cancelToken}) {
    return _dio.get<dynamic>('/v1/objects/$id', cancelToken: cancelToken);
  }

  /// Every curatorial department.
  Future<Response<dynamic>> departments() {
    return _dio.get<dynamic>('/v1/departments');
  }
}

@Riverpod(keepAlive: true)
CollectionRemoteRepository collectionRemoteRepository(Ref ref) {
  return CollectionRemoteRepository(ref.watch(apiClientProvider));
}
