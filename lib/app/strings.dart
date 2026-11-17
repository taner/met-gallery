import 'data/models/artwork.dart';
import 'data/pagination/paged_artworks.dart';

/// Every word the app shows, in one file, so that it can be read and
/// reviewed as copy.
abstract final class Strings {
  static const String appTitle = 'Met Gallery';
  static const String moduleTitle = 'Met Gallery';
  static const String moduleSubtitle =
      'Search The Met’s open-access collection and browse what you find.';

  static const String searchHint = 'Search the collection';
  static const String clearSearch = 'Clear search';
  static String forgetSearch(String query) => 'Remove “$query” from history';

  static const String allDepartments = 'All departments';
  static const String searchAllDepartments = 'Search all departments';
  static const String retryDepartments = 'Retry departments';
  static const String departmentsFailed =
      'Couldn’t load the list of departments.';

  static const String untitled = 'Untitled';
  static const String imageUnavailable = 'Image unavailable';
  static const String close = 'Close';
  static const String viewOnMuseumSite = 'View on metmuseum.org';
  static const String favourites = 'Favourites';
  static const String addToFavourites = 'Add to favourites';
  static const String removeFromFavourites = 'Remove from favourites';
  static const String backToResults = 'Back to results';
  static const String noFavouritesTitle = 'No favourites yet';
  static const String noFavouritesBody =
      'Click the heart under a work to keep it here.';

  /// The line under the title while the favourites are showing.
  static String favouritesStatus(int total) => total == 1
      ? 'Your one favourite, kept in this browser'
      : 'Your ${count(total)} favourites, kept in this browser';

  static String searchFor(String subject) => 'Search for “$subject”';
  static const String retry = 'Try again';
  static const String showMore = 'Show more';
  static const String lookFurther = 'Look further';
  static const String attribution =
      'Images and records: The Metropolitan Museum of Art, Open Access.';

  /// Shown once a load has run long, usually because of our own pacing
  /// (see `RequestPacer`).
  static const String slowLoad =
      'Still fetching. The museum limits how quickly we may ask, so a busy '
      'minute is followed by a slow one.';

  static String backTo(String query) => 'Back to $query';

  static String titleOf(Artwork artwork) =>
      artwork.title.isEmpty ? untitled : artwork.title;

  /// Which search this is, as the tail of a sentence: ` for “Hokusai”`,
  /// ` for “Hokusai” in Asian Art`, ` in Asian Art`, or nothing.
  static String scopeOf(PagedArtworks artworks) => [
    if (artworks.query.isNotEmpty) ' for “${artworks.query}”',
    _inDepartment(artworks),
  ].join();

  static String _inDepartment(PagedArtworks artworks) {
    final department = artworks.department;
    return department == null ? '' : ' in ${department.displayName}';
  }

  /// The line under the search field.
  static String status(PagedArtworks artworks) {
    final scope = scopeOf(artworks);

    if (artworks.items.isEmpty) {
      if (!artworks.isLoading) return '';
      if (artworks.query.isNotEmpty) return 'Looking$scope…';
      final department = artworks.department;
      return department == null
          ? 'Looking through the collection…'
          : 'Looking through ${department.displayName}…';
    }

    final shown = artworks.items.length;
    if (artworks.hasMore) {
      // "About", because unexamined matches are only assumed to have an
      // image. Without a query the number needs a noun.
      final works = artworks.query.isEmpty ? ' works' : '';
      return 'Showing ${count(shown)} of about '
          '${count(artworks.approximateTotal)}$works$scope';
    }
    return shown == 1
        ? 'The one work we can show$scope'
        : 'All ${count(shown)} works we can show$scope';
  }

  static String noMatchesTitle(PagedArtworks artworks) => artworks.query.isEmpty
      ? 'Nothing to show${_inDepartment(artworks)}'
      : 'Nothing matches “${artworks.query}”${_inDepartment(artworks)}';

  /// What to try next: another word, another department, or both.
  static String noMatchesBody(PagedArtworks artworks) {
    if (artworks.department == null) {
      return 'Check the spelling, try a broader word, or pick a starting '
          'point.';
    }
    return artworks.query.isEmpty
        ? 'This department has no works with an image.'
        : 'Try a broader word, or search every department.';
  }

  static const String nothingShownTitle = 'Nothing to show yet';
  static String nothingShownBody(PagedArtworks artworks) {
    final one = artworks.examined == 1;
    final matches = artworks.query.isEmpty
        ? (one ? 'work' : 'works')
        : (one ? 'match' : 'matches');
    final examined = artworks.hasMore
        ? 'None of the first ${count(artworks.examined)} $matches'
        : 'None of the ${count(artworks.examined)} $matches';
    return '$examined${scopeOf(artworks)} has an open-access image.';
  }

  static String failure(PageFailure failure) => switch (failure) {
    // The browser cannot tell us which of the two it was.
    PageFailure.unreachable =>
      'Couldn’t reach the museum. You may be offline, or it may be turning '
          'requests away for a moment.',
    PageFailure.unavailable =>
      'The museum’s collection service isn’t answering properly right now.',
    PageFailure.unexpected =>
      'The museum sent an answer this app couldn’t read.',
  };

  static const String moreFailed = 'Couldn’t load more.';

  /// 12345 → "12,345".
  static String count(int value) {
    final digits = value.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < digits.length; i++) {
      if (i > 0 && (digits.length - i) % 3 == 0) buffer.write(',');
      buffer.write(digits[i]);
    }
    return buffer.toString();
  }
}
