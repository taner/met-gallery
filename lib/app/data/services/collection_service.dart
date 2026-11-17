import 'dart:math' as math;

import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/artwork.dart';
import '../models/department.dart';
import '../models/search_ids.dart';
import '../pagination/paged_artworks.dart';
import '../repositories/collection_remote_repository.dart';

part 'collection_service.g.dart';

/// Ids asked about per load. Twelve fills whole rows at two, three and
/// four columns, and makes a page thirteen requests.
const int kArtworkPageSize = 12;

/// Object requests in flight at once. Pacing and retries are the HTTP
/// client's job (`api_client.dart`).
const int kObjectPoolSize = 4;

/// The most settled answers kept in memory.
const int kObjectCacheLimit = 600;

/// Turns the API's search and object endpoints into pages of artworks, and
/// keeps the list of departments.
///
/// A search returns ids, so a page is one request plus one per id:
///
///  * An id that 404s or has no usable image is *settled*: it is
///    remembered as nothing to show, and the page carries on.
///  * If an object request fails in a way that might clear, the page ends
///    just before that id and the next load starts there.
///  * If not even the first id could be settled, the page throws.
class CollectionService {
  CollectionService(this._remote);

  final CollectionRemoteRepository _remote;

  /// Settled answers by object id. Null means the id has nothing to show.
  final Map<int, Artwork?> _settled = <int, Artwork?>{};

  /// The departments, once loaded.
  List<Department>? _departments;

  /// The departments request in flight, shared by concurrent callers.
  Future<List<Department>>? _departmentsLoad;

  Future<ArtworkPage> loadPage({
    required String query,
    required int offset,
    int? departmentId,
    CancelToken? cancelToken,
  }) async {
    final response = await _remote.search(
      query: query,
      offset: offset,
      limit: kArtworkPageSize,
      departmentId: departmentId,
      cancelToken: cancelToken,
    );
    final found = SearchIdsJsonHandler.fromJson(response.data);

    if (found.ids.isEmpty) {
      // No ids at this offset means the end, whatever `total` claims.
      // Reporting the offset as the total stops further loads.
      return ArtworkPage(artworks: const [], total: offset, examined: 0);
    }

    final ids = found.ids;
    // One slot per id. `settled` tells an id with nothing to show apart
    // from one that was never answered.
    final artworks = List<Artwork?>.filled(ids.length, null);
    final settled = List<bool>.filled(ids.length, false);
    Object? failure;
    var next = 0;

    Future<void> worker() async {
      // Once one request has failed, no new ones start.
      while (failure == null && next < ids.length) {
        final index = next++;
        try {
          artworks[index] = await _artwork(ids[index], cancelToken);
          settled[index] = true;
        } catch (error) {
          if (_isCancellation(error)) rethrow;
          failure ??= error;
        }
      }
    }

    await Future.wait([for (var i = 0; i < kObjectPoolSize; i++) worker()]);

    final firstUnsettled = settled.indexOf(false);
    final examined = firstUnsettled == -1 ? ids.length : firstUnsettled;
    if (examined == 0) throw failure!;

    return ArtworkPage(
      artworks: artworks.take(examined).nonNulls.toList(),
      // Never less than what this page proves exists.
      total: math.max(found.total, offset + ids.length),
      examined: examined,
    );
  }

  /// The museum's departments, in the API's order, as an unmodifiable
  /// list. Loaded once and kept. A failure is not kept, so the next call
  /// asks again.
  Future<List<Department>> departments() async {
    final known = _departments;
    if (known != null) return known;

    final load = _departmentsLoad ??= _fetchDepartments();
    try {
      return _departments = await load;
    } finally {
      // Clear the request, so that after a failure the next call starts
      // a new one.
      if (identical(_departmentsLoad, load)) _departmentsLoad = null;
    }
  }

  Future<List<Department>> _fetchDepartments() async {
    final response = await _remote.departments();

    // A body with no departments in it must fail, not be remembered as
    // "no departments".
    final body = response.data;
    final departments = body is Map
        ? DepartmentListing.fromJson(body.cast<String, dynamic>()).departments
        : const <Department>[];
    if (departments.isEmpty) {
      throw const FormatException('Departments response lists no departments');
    }
    return departments;
  }

  Future<Artwork?> _artwork(int id, CancelToken? cancelToken) async {
    if (_settled.containsKey(id)) return _settled[id];

    try {
      final response = await _remote.object(id, cancelToken: cancelToken);
      return _settle(id, ArtworkJsonHandler.fromRecord(response.data));
    } on DioException catch (error) {
      // A 404 is the museum's answer about this object, not a fault.
      if (error.response?.statusCode == 404) return _settle(id, null);
      rethrow;
    }
  }

  Artwork? _settle(int id, Artwork? artwork) {
    if (_settled.length >= kObjectCacheLimit) {
      _settled.remove(_settled.keys.first);
    }
    return _settled[id] = artwork;
  }
}

bool _isCancellation(Object error) =>
    error is DioException && error.type == DioExceptionType.cancel;

/// Turns a thrown error into a [PageFailure]. The only place an exception
/// is interpreted.
PageFailure pageFailureOf(Object error) {
  if (error is! DioException) return PageFailure.unexpected;

  return switch (error.type) {
    DioExceptionType.connectionError => PageFailure.unreachable,
    DioExceptionType.connectionTimeout ||
    DioExceptionType.sendTimeout ||
    DioExceptionType.receiveTimeout => PageFailure.unavailable,
    DioExceptionType.badResponse => _failureOfStatus(
      error.response?.statusCode,
    ),
    _ => PageFailure.unexpected,
  };
}

PageFailure _failureOfStatus(int? status) {
  if (status == null) return PageFailure.unexpected;
  // A 403 is the museum's firewall refusing, so it counts as unavailable.
  if (status >= 500 || status == 429 || status == 403) {
    return PageFailure.unavailable;
  }
  return PageFailure.unexpected;
}

@Riverpod(keepAlive: true)
CollectionService collectionService(Ref ref) {
  return CollectionService(ref.watch(collectionRemoteRepositoryProvider));
}
