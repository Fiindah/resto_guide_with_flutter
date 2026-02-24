import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:resto_app/provider/resto_list_provider.dart';
import 'package:resto_app/data/api/resto_api_service.dart';
import 'package:resto_app/data/model/resto_list_response.dart';
import 'package:resto_app/utils/result_state.dart';

class MockApiService extends Mock implements RestaurantApiService {}

void main() {
  late MockApiService mockApiService;
  late RestaurantListProvider provider;

  setUp(() {
    mockApiService = MockApiService();
    provider = RestaurantListProvider(apiService: mockApiService);
  });
  test('State awal harus LoadingState', () {
    expect(provider.state, isA<LoadingState>());
  });
  test('Harus mengembalikan SuccessState saat API sukses', () async {
    final fakeResponse = RestaurantListResponse(
      restaurants: [],
    );

    when(() => mockApiService.fetchRestaurantList())
        .thenAnswer((_) async => fakeResponse);

    await provider.fetchRestaurantList();

    expect(provider.state, isA<SuccessState<RestaurantListResponse>>());
  });
  test('Harus mengembalikan ErrorState saat API gagal', () async {
    when(() => mockApiService.fetchRestaurantList())
        .thenThrow(Exception('error'));

    await provider.fetchRestaurantList();

    expect(provider.state, isA<ErrorState>());
  });
}