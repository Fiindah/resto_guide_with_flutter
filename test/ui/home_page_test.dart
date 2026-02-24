import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:resto_app/provider/resto_list_provider.dart';
import 'package:resto_app/provider/theme_provider.dart';
import 'package:resto_app/data/model/resto_list_response.dart';
import 'package:resto_app/utils/result_state.dart';
import 'package:resto_app/ui/pages/home_page.dart';

class FakeRestaurantListProvider extends ChangeNotifier
    implements RestaurantListProvider {
  @override
  ResultState<RestaurantListResponse> state = LoadingState();

  @override
  Future<void> fetchRestaurantList() async {}

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Widget createTestWidget(FakeRestaurantListProvider provider) {
  return MultiProvider(
    providers: [
      ChangeNotifierProvider<RestaurantListProvider>.value(value: provider),
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ],
    child: const MaterialApp(home: HomePage()),
  );
}

void main() {
  late FakeRestaurantListProvider provider;

  setUp(() {
    provider = FakeRestaurantListProvider();
  });

  testWidgets('Menampilkan loading indicator saat LoadingState', (
    WidgetTester tester,
  ) async {
    provider.state = LoadingState();

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(createTestWidget(provider));
    });

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Menampilkan list restoran saat SuccessState', (
    WidgetTester tester,
  ) async {
    provider.state = SuccessState(
      RestaurantListResponse(
        restaurants: [
          Restaurant(
            id: 'r1',
            name: 'Resto Test',
            description: 'Deskripsi resto',
            city: 'Bandung',
            pictureId: '1',
            rating: 4.5,
          ),
        ],
      ),
    );

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(createTestWidget(provider));
      await tester.pump();
    });

    expect(find.text('Resto Test'), findsOneWidget);
  });

  testWidgets('Menampilkan pesan error saat ErrorState', (
    WidgetTester tester,
  ) async {
    provider.state = ErrorState('Failed to load data restoran');

    await mockNetworkImagesFor(() async {
      await tester.pumpWidget(createTestWidget(provider));
      await tester.pump();
    });

    expect(find.textContaining('Failed'), findsOneWidget);
  });
}
