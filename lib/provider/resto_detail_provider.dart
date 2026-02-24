import 'package:flutter/material.dart';
import 'package:resto_app/data/api/resto_api_service.dart';
import 'package:resto_app/data/model/resto_detail_response.dart';
import '../utils/result_state.dart';

class RestaurantDetailProvider extends ChangeNotifier {
  final RestaurantApiService apiService;
  final String restaurantId;

  ResultState<RestaurantDetailResponse> state = LoadingState();
  ResultState<void>? reviewState;

  RestaurantDetailProvider({
    required this.apiService,
    required this.restaurantId,
  }) {
    fetchRestaurantDetail();
  }

  Future<void> fetchRestaurantDetail() async {
    try {
      state = LoadingState();
      notifyListeners();

      final result = await apiService.fetchRestaurantDetail(restaurantId);
      state = SuccessState(result);
    } catch (e) {
      state = ErrorState('Failed to load detail restoran');
    }

    notifyListeners();
  }

  Future<void> submitReview({
    required String name,
    required String review,
  }) async {
    try {
      reviewState = LoadingState();
      notifyListeners();

      await apiService.postReview(id: restaurantId, name: name, review: review);
      await fetchRestaurantDetail();

      reviewState = SuccessState(null);
    } catch (e) {
      reviewState = ErrorState('Gagal mengirim review');
    }

    notifyListeners();
  }

  void resetReviewState() {
    reviewState = null;
    notifyListeners();
  }
}
