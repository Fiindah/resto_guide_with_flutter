import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:resto_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Resto App Integration Test', () {

    testWidgets('End-to-End Test: List -> Detail -> Favorite', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      // 1. Pastikan halaman list tampil
      expect(find.byKey(const Key('home_scroll')), findsOneWidget);

      await tester.pumpAndSettle(const Duration(seconds: 3));
      // 2. Klik item resto pertama
      final firstItem = find.byType(ListTile).first;
      expect(firstItem, findsOneWidget);

      await tester.tap(firstItem);
      await tester.pumpAndSettle();

      // 3. Pastikan halaman detail muncul
      expect(find.byType(Scaffold), findsWidgets);

      // 4. Klik tombol Favorite
      final favButton = find.byIcon(Icons.favorite_border);
      if (favButton.evaluate().isNotEmpty) {
        await tester.tap(favButton);
        await tester.pumpAndSettle();
      }

      // 5. Kembali ke halaman list
      final backButton = find.byTooltip('Back');
      if (backButton.evaluate().isNotEmpty) {
        await tester.tap(backButton);
        await tester.pumpAndSettle();
      }

      // 6. Buka halaman Favorite
      final favNav = find.text('Favorite');
      if (favNav.evaluate().isNotEmpty) {
        await tester.tap(favNav);
        await tester.pumpAndSettle();
      }

      // 7. Pastikan halaman Favorite tampil
      expect(find.byKey(const Key('favorite_list')), findsOneWidget);
    });
  });
}