import 'package:flutter/material.dart';
import 'package:resto_app/data/api/resto_api_service.dart';
import 'package:resto_app/data/model/resto_list_response.dart';
import '../utils/result_state.dart';

class RestaurantListProvider extends ChangeNotifier {
  final RestaurantApiService apiService;

  ResultState<RestaurantListResponse> state = LoadingState();

  RestaurantListProvider({required this.apiService}) {
    fetchRestaurantList();
  }

  Future<void> fetchRestaurantList() async {
    try {
      state = LoadingState();
      notifyListeners();

      final result = await apiService.fetchRestaurantList();
      state = SuccessState(result);
    } catch (e) {
      state = ErrorState('Failed to load data restoran');
    }

    notifyListeners();
  }
}
