import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:resto_app/main.dart' as app;

import 'robot/resto_robot.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Integrate: List -> Detail -> Favorite', (
    WidgetTester tester,
  ) async {
    final robot = RestoRobot(tester);

    await robot.loadApp(app.main);

    await robot.ensureHomeLoaded();

    await robot.tapFirstRestaurant();

    await robot.ensureDetailLoaded();

    await robot.tapFavorite();

    await robot.goBack();

    await robot.openFavoritePage();

    await robot.ensureFavoriteLoaded();
  });
}
