import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class RestoRobot {
  final WidgetTester tester;

  const RestoRobot(this.tester);

  final homePageKey = const ValueKey("home_page");
  final firstItemKey = const ValueKey("restaurant_item_0");
  final detailPageKey = const ValueKey("detail_page");
  final favoriteButtonKey = const ValueKey("favorite_button");
  final bottomNavFavoriteKey = const ValueKey("bottom_nav_favorite");
  final favoritePageKey = const ValueKey("favorite_page");

  Future<void> loadApp(void Function() mainFunction) async {
    mainFunction();
    await tester.pumpAndSettle(const Duration(seconds: 3));
  }

  Future<void> ensureHomeLoaded() async {
    expect(find.byKey(homePageKey), findsOneWidget);
  }

  Future<void> tapFirstRestaurant() async {
    await tester.tap(find.byKey(firstItemKey));
    await tester.pumpAndSettle();
  }

  Future<void> ensureDetailLoaded() async {
    expect(find.byKey(detailPageKey), findsOneWidget);
  }

  Future<void> tapFavorite() async {
    await tester.tap(find.byKey(favoriteButtonKey));
    await tester.pumpAndSettle();
  }

  Future<void> goBack() async {
    await tester.pageBack();
    await tester.pumpAndSettle();
  }

  Future<void> openFavoritePage() async {
    await tester.tap(find.byKey(bottomNavFavoriteKey));
    await tester.pumpAndSettle();
  }

  Future<void> ensureFavoriteLoaded() async {
    expect(find.byKey(favoritePageKey), findsOneWidget);
  }
}
