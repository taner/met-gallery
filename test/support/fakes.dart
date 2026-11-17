import 'dart:async';

import 'package:dio/dio.dart';
import 'package:met_gallery/app/data/models/artwork.dart';
import 'package:met_gallery/app/data/models/department.dart';
import 'package:met_gallery/app/data/pagination/paged_artworks.dart';
import 'package:met_gallery/app/data/repositories/collection_remote_repository.dart';
import 'package:met_gallery/app/data/repositories/favourites_local_repository.dart';
import 'package:met_gallery/app/data/repositories/search_history_local_repository.dart';
import 'package:met_gallery/app/data/services/collection_service.dart';

/// An object record as the API sends it, cut down to the fields the app
/// reads. Tests override the one field they are about.
Map<String, dynamic> objectJson(int id, {Map<String, dynamic>? overrides}) => {
  'objectID': id,
  'title': 'Work $id',
  'artistDisplayName': 'Artist $id',
  'objectDate': '1830',
  'medium': 'Woodblock print',
  'department': 'Asian Art',
  'primaryImageSmall': 'https://images.test/web-large/$id.jpg',
  'objectURL': 'https://museum.test/art/$id',
  ...?overrides,
};

Artwork artwork(int id) => ArtworkJsonHandler.fromRecord(objectJson(id))!;

Response<dynamic> _ok(String path, Object? data) => Response<dynamic>(
  requestOptions: RequestOptions(path: path),
  statusCode: 200,
  data: data,
);

DioException httpError(int status, {String path = '/'}) {
  final options = RequestOptions(path: path);
  return DioException.badResponse(
    statusCode: status,
    requestOptions: options,
    response: Response<dynamic>(requestOptions: options, statusCode: status),
  );
}

DioException connectionError({String path = '/'}) =>
    DioException.connectionError(
      requestOptions: RequestOptions(path: path),
      reason: 'no route',
    );

/// The collection API, scripted. [search] answers every search; [objects]
/// answers per id, either with a body or by throwing; [onDepartments]
/// answers the departments listing. Every request is written to [log].
class FakeRemoteRepository implements CollectionRemoteRepository {
  FakeRemoteRepository({
    this.onSearch = _noSearch,
    this.objects = const {},
    this.onDepartments,
  });

  static Object? _noSearch(String query, int offset) =>
      throw StateError('This test did not expect a search');

  /// Returns the search body for (query, offset), or throws.
  Object? Function(String query, int offset) onSearch;

  /// The `departmentId` each search was sent with, in order.
  final List<int?> searchedDepartments = [];

  /// Per id: a body, or a function that returns one or throws. An id with
  /// no entry gets a well-formed record.
  final Map<int, Object?> objects;

  /// Returns the departments body, or throws.
  Object? Function()? onDepartments;

  /// When set, the departments request waits on this before answering.
  Completer<void>? holdDepartments;

  final List<String> log = [];
  int inFlight = 0;
  int peakInFlight = 0;

  /// When set, object requests wait on this before answering.
  Completer<void>? hold;

  @override
  Future<Response<dynamic>> search({
    required String query,
    required int offset,
    required int limit,
    int? departmentId,
    CancelToken? cancelToken,
  }) async {
    log.add('search:$query@$offset');
    searchedDepartments.add(departmentId);
    return _ok('/v1.1/search', onSearch(query, offset));
  }

  @override
  Future<Response<dynamic>> object(int id, {CancelToken? cancelToken}) async {
    log.add('object:$id');
    inFlight++;
    if (inFlight > peakInFlight) peakInFlight = inFlight;
    try {
      await (hold?.future ?? Future<void>.value());
      final scripted = objects.containsKey(id) ? objects[id] : objectJson(id);
      final body = scripted is Function ? scripted() : scripted;
      return _ok('/v1/objects/$id', body);
    } finally {
      inFlight--;
    }
  }

  @override
  Future<Response<dynamic>> departments() async {
    log.add('departments');
    await (holdDepartments?.future ?? Future<void>.value());
    return _ok('/v1/departments', onDepartments!());
  }
}

/// The departments listing as the API sends it.
Map<String, dynamic> departmentsJson(Map<int, String> departments) => {
  'departments': [
    for (final entry in departments.entries)
      {'departmentId': entry.key, 'displayName': entry.value},
  ],
};

/// One call the gallery made to the service, held open until the test
/// decides how it ends.
class PendingPage {
  PendingPage(this.query, this.offset, this.departmentId, this.cancelToken);

  final String query;
  final int offset;
  final int? departmentId;
  final CancelToken? cancelToken;
  final Completer<ArtworkPage> _completer = Completer<ArtworkPage>();

  void complete(List<int> ids, {required int total, int? examined}) {
    _completer.complete(
      ArtworkPage(
        artworks: ids.map(artwork).toList(),
        total: total,
        examined: examined ?? ids.length,
      ),
    );
  }

  /// For a test about what a work carries (other views, subjects).
  void completeWith(List<Artwork> artworks, {required int total}) {
    _completer.complete(
      ArtworkPage(artworks: artworks, total: total, examined: artworks.length),
    );
  }

  void fail(Object error) => _completer.completeError(error);
}

/// The service, reduced to a list of calls the test resolves by hand, so
/// that a test controls the order in which they land.
class FakeCollectionService implements CollectionService {
  final List<PendingPage> calls = [];

  /// How the departments listing answers. Empty unless a test says
  /// otherwise; most are not about the filter.
  Future<List<Department>> Function() onDepartments = () async => const [];

  @override
  Future<List<Department>> departments() => onDepartments();

  @override
  Future<ArtworkPage> loadPage({
    required String query,
    required int offset,
    int? departmentId,
    CancelToken? cancelToken,
  }) {
    final call = PendingPage(query, offset, departmentId, cancelToken);
    calls.add(call);
    return call._completer.future;
  }
}

/// Local storage for the search history, in memory. [saved] is what a
/// visit starts with and what every write replaces; [broken] makes both
/// directions throw, as a browser with storage blocked does.
class FakeSearchHistoryRepository implements SearchHistoryLocalRepository {
  FakeSearchHistoryRepository([this.saved = const []]);

  List<String> saved;
  bool broken = false;
  int writes = 0;

  @override
  Future<List<String>> read() async {
    if (broken) throw StateError('storage is blocked');
    return saved;
  }

  @override
  Future<void> write(List<String> history) async {
    if (broken) throw StateError('storage is blocked');
    writes++;
    saved = List.of(history);
  }
}

/// Local storage for the favourites, in memory, with the same two knobs
/// as [FakeSearchHistoryRepository].
class FakeFavouritesRepository implements FavouritesLocalRepository {
  FakeFavouritesRepository([this.saved = const []]);

  List<Artwork> saved;
  bool broken = false;
  int writes = 0;

  @override
  Future<List<Artwork>> read() async {
    if (broken) throw StateError('storage is blocked');
    return saved;
  }

  @override
  Future<void> write(List<Artwork> favourites) async {
    if (broken) throw StateError('storage is blocked');
    writes++;
    saved = List.of(favourites);
  }
}
