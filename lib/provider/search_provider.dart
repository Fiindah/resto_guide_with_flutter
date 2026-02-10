import 'package:flutter/material.dart';
import 'package:resto_app/data/model/resto_list_response.dart';
import '../utils/result_state.dart';
import 'package:resto_app/data/api/resto_api_service.dart';


class SearchProvider extends ChangeNotifier {
  final RestaurantApiService apiService;

  SearchProvider({required this.apiService});

  ResultState<RestaurantListResponse>? _state;
  ResultState<RestaurantListResponse>? get state => _state;

  Future<void> searchRestaurant(String query) async {
    if (query.isEmpty) return;

    _state = LoadingState();
    notifyListeners();

    try {
      final result = await apiService.searchRestaurant(query);
      if (result.restaurants.isEmpty) {
        _state = ErrorState('Restoran tidak ditemukan');
      } else {
        _state = SuccessState(result);
      }
    } catch (e) {
      _state = ErrorState('Gagal melakukan pencarian');
    }

    notifyListeners();
  }
}
