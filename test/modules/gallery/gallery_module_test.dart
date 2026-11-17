import 'dart:ui' show PointerDeviceKind;

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:met_gallery/app/app_theme.dart';
import 'package:met_gallery/app/data/models/artwork.dart';
import 'package:met_gallery/app/data/models/department.dart';
import 'package:met_gallery/app/data/pagination/paged_artworks.dart';
import 'package:met_gallery/app/data/repositories/favourites_local_repository.dart';
import 'package:met_gallery/app/data/repositories/search_history_local_repository.dart';
import 'package:met_gallery/app/data/services/collection_service.dart';
import 'package:met_gallery/app/modules/gallery/gallery_helper.dart';
import 'package:met_gallery/app/modules/gallery/gallery_page.dart';
import 'package:met_gallery/app/modules/gallery/gallery_providers.dart';
import 'package:met_gallery/app/modules/gallery/widgets/artwork_detail.dart';
import 'package:met_gallery/app/modules/gallery/widgets/gallery_module.dart';
import 'package:met_gallery/app/modules/gallery/widgets/gallery_search.dart';
import 'package:met_gallery/app/modules/gallery/widgets/artwork_tile.dart';
import 'package:met_gallery/app/strings.dart';
import 'package:met_gallery/app/widgets/artwork_image.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../support/fakes.dart';

/// Pumps the module alone in a window of [size], with the service scripted
/// and the first load already requested. No image bytes arrive under
/// flutter_test, so tiles show their image fallback.
Future<FakeCollectionService> pumpModule(
  WidgetTester tester, {
  Size size = const Size(1000, 800),
  Future<List<Department>> Function()? onDepartments,
  FakeSearchHistoryRepository? historyStore,
  FakeFavouritesRepository? favouritesStore,
}) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);

  final service = FakeCollectionService();
  if (onDepartments != null) service.onDepartments = onDepartments;
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        collectionServiceProvider.overrideWithValue(service),
        initialQueryProvider.overrideWithValue(kDefaultQuery),
        searchHistoryLocalRepositoryProvider.overrideWithValue(
          historyStore ?? FakeSearchHistoryRepository(),
        ),
        favouritesLocalRepositoryProvider.overrideWithValue(
          favouritesStore ?? FakeFavouritesRepository(),
        ),
      ],
      child: MaterialApp(
        theme: appTheme,
        home: const Scaffold(body: GalleryModule()),
      ),
    ),
  );
  await tester.pump();
  return service;
}

final List<int> twelve = [for (var id = 1; id <= 12; id++) id];

Finder mat(int id) => find.byKey(Key('artwork_mat_$id'));

/// The part of a tile that takes the click that opens it. Tests tap this,
/// not [mat], whose centre has nothing of its own to hit under
/// flutter_test.
Finder opener(int id) =>
    find.ancestor(of: mat(id), matching: find.byType(InkWell)).first;

final Finder searchField = find.byKey(const Key('gallery_search_field'));

void main() {
  group('first load', () {
    testWidgets('shows the gallery\'s shape in skeleton tiles, not a spinner', (
      tester,
    ) async {
      await pumpModule(tester);

      // Whole rows of four, in the cells the page on its way will take.
      // (The grid builds lazily, so only the rows near the viewport exist.)
      final skeletons = tester.widgetList(find.byType(ArtworkTileSkeleton));
      expect(skeletons.length, greaterThanOrEqualTo(8));
      expect(skeletons.length % 4, 0);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('Looking for “Hokusai”…'), findsOneWidget);
    });

    testWidgets('with reduced motion the skeleton is drawn flat, not '
        'shimmering', (tester) async {
      tester.platformDispatcher.accessibilityFeaturesTestValue =
          const FakeAccessibilityFeatures(disableAnimations: true);
      addTearDown(
        tester.platformDispatcher.clearAccessibilityFeaturesTestValue,
      );

      await pumpModule(tester);

      // Not `find.byType`: the widget the package builds is a private
      // subclass of Skeletonizer.
      final effects = tester
          .widgetList<Skeletonizer>(
            find.byWidgetPredicate((widget) => widget is Skeletonizer),
          )
          .map((skeleton) => skeleton.effect);
      expect(effects, isNotEmpty);
      expect(effects, everyElement(isA<SolidColorEffect>()));
    });

    testWidgets('a failure offers a retry and never shows the exception', (
      tester,
    ) async {
      final service = await pumpModule(tester);

      service.calls.single.fail(connectionError());
      await tester.pump();

      expect(
        find.text(Strings.failure(PageFailure.unreachable)),
        findsOneWidget,
      );
      expect(find.textContaining('DioException'), findsNothing);

      await tester.tap(find.text(Strings.retry));
      await tester.pump();

      expect(service.calls, hasLength(2));
      expect(find.byType(ArtworkTileSkeleton), findsWidgets);
    });
  });

  group('gallery geometry (mats line up with the module\'s own inset)', () {
    testWidgets('four square mats a row, 16 in from each edge, 16 apart', (
      tester,
    ) async {
      final service = await pumpModule(tester);
      service.calls.single.complete(twelve, total: 492);
      await tester.pump();

      final module = tester.getRect(find.byType(GalleryModule));
      final first = tester.getRect(mat(1));
      final second = tester.getRect(mat(2));
      final endOfRow = tester.getRect(mat(4));
      final nextRow = tester.getRect(mat(5));

      // (1000 − 2×16 − 3×16) / 4
      expect(first.width, 230.0);
      // Square whatever the work's own proportions: that is the mat's job.
      expect(first.height, first.width);
      expect(first.left - module.left, 16.0);
      expect(module.right - endOfRow.right, 16.0);
      expect(second.left - first.right, 16.0);

      // Row pitch is the tile extent plus one gap: mat, caption room for
      // two title lines and a byline, then the same 16 as between columns.
      expect(nextRow.left, first.left);
      expect(nextRow.top - first.top, 230.0 + 8.0 + 40.0 + 16.0 + 8.0 + 16.0);
    });

    testWidgets('a phone-width module shows two a row, 12 apart', (
      tester,
    ) async {
      // Tall, because at 2× the header alone outgrows a phone screen and
      // the first row would not be built at all.
      final service = await pumpModule(tester, size: const Size(390, 1600));
      service.calls.single.complete(twelve, total: 492);
      await tester.pump();

      final first = tester.getRect(mat(1));
      final second = tester.getRect(mat(2));
      final nextRow = tester.getRect(mat(3));

      expect(first.left, 16.0);
      expect(second.left - first.right, 12.0);
      expect(390.0 - second.right, 16.0);
      expect(nextRow.left, first.left);
    });

    testWidgets('captions fit at twice the text size', (tester) async {
      tester.platformDispatcher.textScaleFactorTestValue = 2.0;
      addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

      // Tall, because at 2× the header alone outgrows a phone screen and
      // the first row would not be built at all.
      final service = await pumpModule(tester, size: const Size(390, 2400));
      service.calls.single.complete(twelve, total: 492);
      await tester.pump();

      // An overflowing tile reports a layout exception; none means the
      // extent grew with the text (artworkTileExtent) instead of clipping it.
      expect(tester.takeException(), isNull);
      expect(find.text('Work 1'), findsOneWidget);
      // The heart stays inside its tile at this size too.
      final tile = tester.getRect(find.byType(ArtworkTile).first);
      final heart = tester.getRect(find.byKey(const Key('favourite_1')));
      expect(tile.expandToInclude(heart), tile);
    });
  });

  testWidgets('on a wide page the content is centred and capped, but the '
      'scroll view (and so its scrollbar) spans the page', (tester) async {
    tester.view.physicalSize = const Size(1600, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    final service = FakeCollectionService();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          collectionServiceProvider.overrideWithValue(service),
          initialQueryProvider.overrideWithValue(kDefaultQuery),
          searchHistoryLocalRepositoryProvider.overrideWithValue(
            FakeSearchHistoryRepository(),
          ),
          favouritesLocalRepositoryProvider.overrideWithValue(
            FakeFavouritesRepository(),
          ),
        ],
        child: MaterialApp(theme: appTheme, home: const GalleryPage()),
      ),
    );
    await tester.pump();
    service.calls.single.complete(twelve, total: 12);
    await tester.pump();

    // The scrollable is the page, edge to edge.
    final scrollView = tester.getRect(find.byType(CustomScrollView));
    expect(scrollView.left, 0.0);
    expect(scrollView.right, 1600.0);

    // The gallery inside it is 1120 wide and centred: 240 of margin, then
    // the 16 inset, on both sides.
    expect(tester.getRect(mat(1)).left, 256.0);
    expect(tester.getRect(mat(4)).right, 1600.0 - 256.0);
  });

  group('searching', () {
    testWidgets('typing a word is one search, not one per keystroke', (
      tester,
    ) async {
      final service = await pumpModule(tester);
      service.calls.single.complete(twelve, total: 12);
      await tester.pump();

      for (final typed in ['v', 've', 'ver', 'verm', 'verme', 'vermeer']) {
        await tester.enterText(searchField, typed);
        await tester.pump(const Duration(milliseconds: 100));
      }
      expect(service.calls, hasLength(1));

      await tester.pump(kSearchDebounce);

      expect(service.calls, hasLength(2));
      expect(service.calls.last.query, 'vermeer');
    });

    testWidgets('no matches says so and offers the way back', (tester) async {
      final service = await pumpModule(tester);
      service.calls.single.complete(twelve, total: 12);
      await tester.pump();

      await tester.enterText(searchField, 'zzqxjv');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();
      service.calls.last.complete([], total: 0);
      await tester.pump();

      expect(find.text('Nothing matches “zzqxjv”'), findsOneWidget);

      await tester.tap(find.text('Back to Hokusai'));
      await tester.pump();

      expect(service.calls.last.query, kDefaultQuery);
      // The field is cleared with it; stale text would search again.
      expect(find.text('zzqxjv'), findsNothing);
    });
  });

  group('more of the gallery', () {
    testWidgets('scrolling near the end fetches the next page; when that '
        'fails the tiles stay and the retry is in place', (tester) async {
      // A short window, so that the last row starts well below it. The next
      // page is asked for only when the grid builds its last tile.
      final service = await pumpModule(tester, size: const Size(1000, 400));
      service.calls.single.complete(twelve, total: 492);
      await tester.pump();
      await tester.pump();
      expect(service.calls, hasLength(1));

      await tester.drag(find.byType(CustomScrollView), const Offset(0, -500));
      await tester.pump();
      // The package asks after the frame that built the last tile.
      await tester.pump();

      expect(service.calls, hasLength(2));
      expect(service.calls.last.offset, 12);

      service.calls.last.fail(connectionError());
      await tester.pump();

      // A failure is not retried by scrolling about, only by the button.
      // Scrolling to the end is also what brings the footer into view.
      await tester.drag(find.byType(CustomScrollView), const Offset(0, -2000));
      await tester.pump();
      // A grid's length is an estimate until its end has been laid out, so
      // a drag this long overshoots; give the scroll a moment to settle.
      await tester.pump(const Duration(seconds: 1));
      expect(service.calls, hasLength(2));

      expect(find.textContaining(Strings.moreFailed), findsOneWidget);
      expect(find.byType(ArtworkTile), findsWidgets);

      await tester.tap(find.text(Strings.retry));
      await tester.pump();

      expect(service.calls, hasLength(3));
      expect(service.calls.last.offset, 12);
    });

    testWidgets('after a page that added nothing, only the button continues', (
      tester,
    ) async {
      // A short first page, so the end of the gallery is already in view.
      final service = await pumpModule(tester);
      service.calls.single.complete([1, 2], total: 728, examined: 12);
      await tester.pump();
      await tester.pump();

      // In view and healthy: the gallery carries on by itself, once…
      expect(service.calls, hasLength(2));
      service.calls.last.complete([], total: 728, examined: 12);
      await tester.pump();
      await tester.pump();

      // …but an empty page ends that. It will not walk 700 ids alone.
      expect(service.calls, hasLength(2));

      await tester.tap(find.text(Strings.showMore));
      await tester.pump();

      expect(service.calls, hasLength(3));
      expect(service.calls.last.offset, 24);
    });
  });

  group('detail', () {
    testWidgets('the picture flies from its tile into the detail: both ends '
        'are heroes with the same tag, on routes a hero can cross', (
      tester,
    ) async {
      final service = await pumpModule(tester);
      service.calls.single.complete(twelve, total: 12);
      await tester.pump();

      Finder heroOf(int id) => find.byWidgetPredicate(
        (widget) => widget is Hero && widget.tag == artworkHeroTag(artwork(id)),
      );
      expect(heroOf(1), findsOneWidget);

      await tester.tap(opener(1));
      await tester.pump();

      // Mid-flight the picture is in the overlay, which only happens
      // between page routes.
      await tester.pump(kDetailTransition ~/ 2);
      final route = ModalRoute.of(
        tester.element(find.text(Strings.viewOnMuseumSite)),
      );
      expect(route, isA<PageRoute<void>>());
      expect(
        find.descendant(of: find.byType(Overlay), matching: heroOf(1)),
        findsWidgets,
      );

      await tester.pump(kDetailTransition);
      // Landed: the tile's hero and the detail's.
      expect(heroOf(1), findsNWidgets(2));

      // Still a dialog to whoever is using it: a click outside closes it.
      await tester.tapAt(const Offset(5, 5));
      await tester.pump();
      await tester.pump(kDetailTransition * 2);
      expect(find.text(Strings.viewOnMuseumSite), findsNothing);
      expect(heroOf(1), findsOneWidget);
    });

    testWidgets('the gallery never has a hole in it: the tile keeps its '
        'picture while the detail opens, stays open and closes', (
      tester,
    ) async {
      final service = await pumpModule(tester);
      service.calls.single.complete(twelve, total: 12);
      await tester.pump();

      // The tile's picture, as something on screen (not offstage).
      Finder pictureInGrid() =>
          find.descendant(of: mat(1), matching: find.byType(ArtworkImage));
      expect(pictureInGrid(), findsOneWidget);

      await tester.tap(opener(1));
      await tester.pump();
      await tester.pump(kDetailTransition ~/ 2);
      expect(pictureInGrid(), findsOneWidget);

      await tester.pump(kDetailTransition);
      expect(pictureInGrid(), findsOneWidget);

      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pump();
      await tester.pump(kDetailTransition ~/ 2);
      expect(pictureInGrid(), findsOneWidget);

      await tester.pump(kDetailTransition * 2);
      expect(pictureInGrid(), findsOneWidget);
    });

    testWidgets('closing the detail while it is still opening turns the '
        'picture round without an error', (tester) async {
      final service = await pumpModule(tester);
      service.calls.single.complete(twelve, total: 12);
      await tester.pump();

      await tester.tap(opener(1));
      await tester.pump();
      await tester.pump(kDetailTransition ~/ 3);
      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pump();
      await tester.pump(kDetailTransition ~/ 3);
      await tester.pump(kDetailTransition * 2);

      expect(tester.takeException(), isNull);
      expect(find.text(Strings.viewOnMuseumSite), findsNothing);

      // And it opens again afterwards.
      await tester.tap(opener(1));
      await tester.pump();
      await tester.pump(kDetailTransition * 2);
      expect(find.text(Strings.viewOnMuseumSite), findsOneWidget);
      expect(tester.takeException(), isNull);
    });

    testWidgets('with reduced motion the detail opens in place, with no '
        'flight', (tester) async {
      tester.platformDispatcher.accessibilityFeaturesTestValue =
          const FakeAccessibilityFeatures(disableAnimations: true);
      addTearDown(
        tester.platformDispatcher.clearAccessibilityFeaturesTestValue,
      );
      final service = await pumpModule(tester);
      service.calls.single.complete(twelve, total: 12);
      await tester.pump();

      await tester.tap(opener(1));
      await tester.pump();
      await tester.pump();

      final route = ModalRoute.of(
        tester.element(find.text(Strings.viewOnMuseumSite)),
      )!;
      expect(route.animation!.isCompleted, isTrue);
    });

    testWidgets('a tile opens the label; Escape closes it', (tester) async {
      final service = await pumpModule(tester);
      service.calls.single.complete(twelve, total: 492);
      await tester.pump();

      await tester.tap(opener(1));
      await tester.pump();
      await tester.pump(kDetailTransition);

      expect(find.text(Strings.viewOnMuseumSite), findsOneWidget);
      expect(find.text('Woodblock print'), findsOneWidget);

      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pump();
      await tester.pump(kDetailTransition * 2);

      expect(find.text(Strings.viewOnMuseumSite), findsNothing);
    });
  });

  group('starting points', () {
    bool chosen(WidgetTester tester, String point) => tester
        .widget<ChoiceChip>(find.widgetWithText(ChoiceChip, point))
        .selected;

    String fieldText(WidgetTester tester) =>
        tester.widget<TextField>(searchField).controller!.text;

    testWidgets('the app opens with its default starting point chosen, and '
        'letting it go takes it out of the search', (tester) async {
      final service = await pumpModule(tester);
      service.calls.single.complete(twelve, total: 12);
      await tester.pump();

      expect(chosen(tester, kDefaultQuery), isTrue);
      expect(fieldText(tester), kDefaultQuery);

      await tester.tap(find.widgetWithText(ChoiceChip, kDefaultQuery));
      await tester.pump();

      expect(chosen(tester, kDefaultQuery), isFalse);
      expect(fieldText(tester), isEmpty);
      // A search for nothing in particular, not for Hokusai again.
      expect(service.calls.last.query, isEmpty);
      expect(find.text('Looking through the collection…'), findsOneWidget);

      service.calls.last.complete(twelve, total: 371494);
      await tester.pump();
      expect(find.text('Showing 12 of about 371,494 works'), findsOneWidget);
    });

    testWidgets('one click chooses a starting point, a second lets it go', (
      tester,
    ) async {
      final service = await pumpModule(tester);
      service.calls.single.complete(twelve, total: 12);
      await tester.pump();

      await tester.tap(find.widgetWithText(ChoiceChip, 'Vermeer'));
      await tester.pump();

      expect(chosen(tester, 'Vermeer'), isTrue);
      expect(chosen(tester, kDefaultQuery), isFalse);
      expect(fieldText(tester), 'Vermeer');
      expect(service.calls.last.query, 'Vermeer');
      service.calls.last.complete([20, 21], total: 2);
      await tester.pump();

      await tester.tap(find.widgetWithText(ChoiceChip, 'Vermeer'));
      await tester.pump();

      expect(chosen(tester, 'Vermeer'), isFalse);
      expect(fieldText(tester), isEmpty);
      expect(service.calls.last.query, isEmpty);

      // The debounce that follows the field change finds nothing new to do.
      await tester.pump(kSearchDebounce);
      expect(service.calls, hasLength(3));
    });

    testWidgets('typing a starting point by hand chooses its chip too', (
      tester,
    ) async {
      final service = await pumpModule(tester);
      service.calls.single.complete(twelve, total: 12);
      await tester.pump();

      await tester.enterText(searchField, '  egyptian   CAT ');
      await tester.pump(kSearchDebounce);

      expect(chosen(tester, 'Egyptian cat'), isTrue);
    });
  });

  group('detail: other views and subjects', () {
    Artwork rich(int id) => artwork(id).copyWith(
      moreImageUrls: const [
        'https://images.test/web-large/back.jpg',
        'https://images.test/web-large/detail.jpg',
      ],
      tags: const ['Birds', 'Mountains'],
    );

    /// The picture the detail is showing: the one in its hero, which is
    /// the last of the two heroes for the work once the detail is open.
    String showing(WidgetTester tester) => tester
        .widget<ArtworkImage>(
          find
              .descendant(
                of: find.byType(ArtworkDetail),
                matching: find.byWidgetPredicate(
                  (widget) => widget is ArtworkImage && !widget.compact,
                ),
              )
              .first,
        )
        .url;

    Future<FakeCollectionService> openDetail(
      WidgetTester tester,
      Artwork work, {
      FakeSearchHistoryRepository? historyStore,
    }) async {
      final service = await pumpModule(tester, historyStore: historyStore);
      service.calls.single.completeWith([work], total: 1);
      await tester.pump();
      await tester.tap(opener(work.id));
      await tester.pump();
      await tester.pump(kDetailTransition * 2);
      return service;
    }

    testWidgets('the thumbnails scroll when dragged with the mouse', (
      tester,
    ) async {
      final work = artwork(1).copyWith(
        moreImageUrls: [
          for (var i = 0; i < 11; i++) 'https://images.test/web-large/$i.jpg',
        ],
      );
      await openDetail(tester, work);

      final thumbnails = find.descendant(
        of: find.byType(ArtworkDetail),
        matching: find.byWidgetPredicate(
          (widget) =>
              widget is Scrollable &&
              widget.axisDirection == AxisDirection.right,
        ),
      );
      double scrolled() =>
          tester.state<ScrollableState>(thumbnails).position.pixels;
      expect(scrolled(), 0.0);

      await tester.drag(
        find.byKey(const Key('artwork_view_2')),
        const Offset(-120.0, 0.0),
        kind: PointerDeviceKind.mouse,
      );
      await tester.pump();

      expect(scrolled(), greaterThan(0.0));
    });

    testWidgets('a work with several pictures offers them as thumbnails, '
        'and choosing one shows it', (tester) async {
      final work = rich(1);
      await openDetail(tester, work);

      // The tile's picture and its two other views.
      expect(find.byKey(const Key('artwork_view_0')), findsOneWidget);
      expect(find.byKey(const Key('artwork_view_2')), findsOneWidget);
      expect(find.byKey(const Key('artwork_view_3')), findsNothing);
      expect(showing(tester), work.imageUrl);

      await tester.tap(find.byKey(const Key('artwork_view_2')));
      await tester.pump();

      expect(showing(tester), 'https://images.test/web-large/detail.jpg');
      // The gallery behind is untouched: the tile still has its own picture.
      expect(
        tester
            .widget<ArtworkImage>(
              find.descendant(of: mat(1), matching: find.byType(ArtworkImage)),
            )
            .url,
        work.imageUrl,
      );
    });

    testWidgets('a work with one picture has no row of thumbnails', (
      tester,
    ) async {
      await openDetail(tester, artwork(1));

      expect(find.byKey(const Key('artwork_view_0')), findsNothing);
    });

    testWidgets('choosing a subject closes the detail and searches for it, '
        'once the detail has gone; it is not typed, so not remembered', (
      tester,
    ) async {
      final store = FakeSearchHistoryRepository();
      final service = await openDetail(tester, rich(1), historyStore: store);
      expect(find.widgetWithText(ActionChip, 'Mountains'), findsOneWidget);
      final before = service.calls.length;

      await tester.tap(find.widgetWithText(ActionChip, 'Birds'));
      await tester.pump();
      // Still closing: the gallery is not replaced under the picture while
      // it flies back to its tile.
      await tester.pump(kDetailTransition ~/ 2);
      expect(service.calls, hasLength(before));

      await tester.pump(kDetailTransition * 2);
      expect(find.byType(ArtworkDetail), findsNothing);
      expect(service.calls, hasLength(before + 1));
      expect(service.calls.last.query, 'Birds');
      expect(tester.widget<TextField>(searchField).controller!.text, 'Birds');

      await tester.pump(kSearchDebounce);
      expect(store.saved, isEmpty);
    });
  });

  group('favourites', () {
    final toggle = find.byKey(const Key('favourites_toggle'));
    Finder heart(int id) => find.byKey(Key('favourite_$id'));

    testWidgets('the heart under a work adds it to the collection, which '
        'is saved; the collection is a grid of its own', (tester) async {
      final store = FakeFavouritesRepository();
      final service = await pumpModule(tester, favouritesStore: store);
      service.calls.single.complete(twelve, total: 12);
      await tester.pump();
      expect(find.text(Strings.favourites), findsOneWidget);

      // Two works in the first row, which is the one on screen.
      await tester.tap(heart(2));
      await tester.pump();
      await tester.tap(heart(3));
      await tester.pump();

      expect(store.saved.map((a) => a.id), [3, 2]);
      expect(find.text('Favourites · 2'), findsOneWidget);
      expect(find.byTooltip(Strings.removeFromFavourites), findsNWidgets(2));
      // Marking a work is not opening it.
      expect(find.byType(ArtworkDetail), findsNothing);

      await tester.tap(toggle);
      await tester.pump();

      // Only the two, newest first, and nothing of the search.
      expect(find.byType(ArtworkTile), findsNWidgets(2));
      expect(
        tester.getRect(mat(3)).left,
        lessThan(tester.getRect(mat(2)).left),
      );
      expect(searchField, findsNothing);
      expect(find.text(Strings.favouritesStatus(2)), findsOneWidget);
      // Looking at the collection asks the museum for nothing.
      expect(service.calls, hasLength(1));
    });

    testWidgets('a work is removed from the collection where it is shown, '
        'and the last one leaves a way back', (tester) async {
      final store = FakeFavouritesRepository([artwork(7), artwork(8)]);
      final service = await pumpModule(tester, favouritesStore: store);
      service.calls.single.complete(twelve, total: 12);
      await tester.pump();
      expect(find.text('Favourites · 2'), findsOneWidget);

      await tester.tap(toggle);
      await tester.pump();
      await tester.tap(heart(7));
      await tester.pump();

      expect(mat(7), findsNothing);
      expect(mat(8), findsOneWidget);
      expect(store.saved.map((a) => a.id), [8]);

      await tester.tap(heart(8));
      await tester.pump();

      expect(find.text(Strings.noFavouritesTitle), findsOneWidget);
      expect(store.saved, isEmpty);

      await tester.tap(find.text(Strings.backToResults));
      await tester.pump();

      expect(mat(1), findsOneWidget);
      expect(searchField, findsOneWidget);
    });

    testWidgets('the detail has the same choice, written out, and the two '
        'agree', (tester) async {
      final store = FakeFavouritesRepository();
      final service = await pumpModule(tester, favouritesStore: store);
      service.calls.single.complete(twelve, total: 12);
      await tester.pump();

      await tester.tap(opener(3));
      await tester.pump();
      await tester.pump(kDetailTransition * 2);
      await tester.tap(find.text(Strings.addToFavourites));
      await tester.pump();

      expect(store.saved.map((a) => a.id), [3]);
      expect(find.text(Strings.removeFromFavourites), findsOneWidget);

      await tester.sendKeyEvent(LogicalKeyboardKey.escape);
      await tester.pump();
      await tester.pump(kDetailTransition * 2);

      // The heart under the tile knows.
      expect(tester.widget<IconButton>(heart(3)).isSelected, isTrue);
      expect(tester.widget<IconButton>(heart(4)).isSelected, isFalse);
    });

    testWidgets(
      'choosing a subject from a favourite goes back to the search results '
      'to search for it',
      (tester) async {
        final favourite = artwork(7).copyWith(tags: const ['Birds']);
        final service = await pumpModule(
          tester,
          favouritesStore: FakeFavouritesRepository([favourite]),
        );
        service.calls.single.complete(twelve, total: 12);
        await tester.pump();

        await tester.tap(toggle);
        await tester.pump();
        await tester.tap(opener(7));
        await tester.pump();
        await tester.pump(kDetailTransition * 2);
        await tester.tap(find.widgetWithText(ActionChip, 'Birds'));
        await tester.pump();
        await tester.pump(kDetailTransition * 2);
        await tester.pump();

        expect(service.calls.last.query, 'Birds');
        expect(searchField, findsOneWidget);
        expect(tester.widget<FilterChip>(toggle).selected, isFalse);
      },
    );
  });

  group('search history', () {
    Finder entry(String query) => find.byKey(Key('search_history_$query'));

    Future<void> focusEmptyField(WidgetTester tester) async {
      await tester.tap(find.byTooltip(Strings.clearSearch));
      await tester.pump();
      await tester.tap(searchField);
      await tester.pump();
    }

    testWidgets('what was typed is offered again under the field, and '
        'choosing it searches at once', (tester) async {
      final store = FakeSearchHistoryRepository();
      final service = await pumpModule(tester, historyStore: store);
      service.calls.single.complete(twelve, total: 12);
      await tester.pump();

      await tester.enterText(searchField, 'vermeer');
      await tester.pump();
      await tester.pump(kSearchDebounce);
      expect(service.calls.last.query, 'vermeer');
      expect(store.saved, ['vermeer']);
      service.calls.last.complete([20], total: 1);
      await tester.pump();

      await focusEmptyField(tester);
      expect(entry('vermeer'), findsOneWidget);
      final before = service.calls.length;

      await tester.tap(entry('vermeer'));
      await tester.pump();

      // No waiting out the debounce for a deliberate choice.
      expect(service.calls, hasLength(before + 1));
      expect(service.calls.last.query, 'vermeer');
      expect(tester.widget<TextField>(searchField).controller!.text, 'vermeer');
    });

    testWidgets('an entry can be removed from the list, and stays removed', (
      tester,
    ) async {
      final store = FakeSearchHistoryRepository(['vermeer', 'armor']);
      final service = await pumpModule(tester, historyStore: store);
      service.calls.single.complete(twelve, total: 12);
      await tester.pump();

      await focusEmptyField(tester);
      expect(entry('vermeer'), findsOneWidget);
      expect(entry('armor'), findsOneWidget);
      final searches = service.calls.length;

      await tester.tap(find.byTooltip(Strings.forgetSearch('vermeer')));
      await tester.pump();

      expect(entry('vermeer'), findsNothing);
      expect(entry('armor'), findsOneWidget);
      expect(store.saved, ['armor']);
      // Removing an entry is not choosing it.
      expect(service.calls, hasLength(searches));
    });

    testWidgets('Enter searches for what is in the field, not for the '
        'first entry that happens to match it', (tester) async {
      final store = FakeSearchHistoryRepository(['vermeer']);
      final service = await pumpModule(tester, historyStore: store);
      service.calls.single.complete(twelve, total: 12);
      await tester.pump();

      await tester.tap(searchField);
      await tester.enterText(searchField, 'ver');
      await tester.pump();
      expect(entry('vermeer'), findsOneWidget);

      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();

      expect(service.calls.last.query, 'ver');
      // And the list is out of the way of the results.
      expect(entry('vermeer'), findsNothing);
    });

    testWidgets('going to an entry with the arrow keys makes Enter choose '
        'that entry', (tester) async {
      final store = FakeSearchHistoryRepository(['vermeer', 'armor']);
      final service = await pumpModule(tester, historyStore: store);
      service.calls.single.complete(twelve, total: 12);
      await tester.pump();

      await tester.tap(searchField);
      await tester.enterText(searchField, 'ar');
      await tester.pump();
      expect(entry('armor'), findsOneWidget);

      await tester.sendKeyEvent(LogicalKeyboardKey.arrowDown);
      await tester.pump();
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();

      expect(service.calls.last.query, 'armor');
      expect(tester.widget<TextField>(searchField).controller!.text, 'armor');
    });

    testWidgets('"Back to Hokusai" after a typed search is not itself '
        'remembered as typed', (tester) async {
      final store = FakeSearchHistoryRepository();
      final service = await pumpModule(tester, historyStore: store);
      service.calls.single.complete(twelve, total: 12);
      await tester.pump();

      await tester.enterText(searchField, 'zzqxjv');
      await tester.pump();
      await tester.pump(kSearchDebounce);
      service.calls.last.complete([], total: 0);
      await tester.pump();
      expect(store.saved, ['zzqxjv']);

      await tester.tap(find.text(Strings.backTo(kDefaultQuery)));
      await tester.pump();
      await tester.pump(kSearchDebounce);

      expect(store.saved, ['zzqxjv']);
    });

    testWidgets('a starting point is not something the reader typed', (
      tester,
    ) async {
      final store = FakeSearchHistoryRepository();
      final service = await pumpModule(tester, historyStore: store);
      service.calls.single.complete(twelve, total: 12);
      await tester.pump();

      await tester.tap(find.widgetWithText(ChoiceChip, 'Vermeer'));
      await tester.pump(kSearchDebounce);
      // Nor is the search the app opened on.
      await tester.pump(kSearchDebounce);

      expect(store.saved, isEmpty);
      expect(store.writes, 0);
    });
  });

  group('department filter', () {
    const departments = [
      Department(departmentId: 6, displayName: 'Asian Art'),
      Department(departmentId: 10, displayName: 'Egyptian Art'),
    ];

    Future<void> choose(WidgetTester tester, String department) async {
      await tester.tap(find.byType(DropdownMenu<int>));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      await tester.tap(find.widgetWithText(MenuItemButton, department).last);
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
    }

    testWidgets('picking a department searches within it and says so; an '
        'empty result offers the way back to all departments', (tester) async {
      final service = await pumpModule(
        tester,
        onDepartments: () async => departments,
      );
      service.calls.single.complete(twelve, total: 12);
      await tester.pump();

      await choose(tester, 'Egyptian Art');

      expect(service.calls.last.query, kDefaultQuery);
      expect(service.calls.last.departmentId, 10);
      expect(
        find.text('Looking for “Hokusai” in Egyptian Art…'),
        findsOneWidget,
      );

      service.calls.last.complete([], total: 0);
      await tester.pump();

      expect(
        find.text('Nothing matches “Hokusai” in Egyptian Art'),
        findsOneWidget,
      );
      // Not "Back to Hokusai": that is the search that just came up empty.
      expect(find.text(Strings.backTo(kDefaultQuery)), findsNothing);

      await tester.tap(find.text(Strings.searchAllDepartments));
      await tester.pump();

      expect(service.calls.last.query, kDefaultQuery);
      expect(service.calls.last.departmentId, isNull);
      // The menu follows the gallery back.
      expect(
        tester
            .widget<DropdownMenu<int>>(find.byType(DropdownMenu<int>))
            .initialSelection,
        0,
      );
    });

    testWidgets('if the departments cannot be loaded the gallery is unaffected '
        'and the filter offers to try again', (tester) async {
      var attempt = 0;
      final service = await pumpModule(
        tester,
        onDepartments: () async =>
            ++attempt == 1 ? throw connectionError() : departments,
      );
      service.calls.single.complete(twelve, total: 12);
      await tester.pump();

      expect(mat(1), findsOneWidget);
      expect(find.byType(DropdownMenu<int>), findsNothing);

      await tester.tap(find.text(Strings.retryDepartments));
      await tester.pump();
      await tester.pump();

      expect(find.text(Strings.retryDepartments), findsNothing);
      await choose(tester, 'Asian Art');
      expect(service.calls.last.departmentId, 6);
    });
  });
}
