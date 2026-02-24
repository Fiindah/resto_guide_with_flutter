import 'package:flutter/material.dart';
import '../data/db/favorite_database.dart';
import '../utils/result_state.dart';

class FavoriteProvider extends ChangeNotifier {
  final FavoriteDatabase _database = FavoriteDatabase.instance;

  ResultState<List<Map<String, dynamic>>> state =
      LoadingState<List<Map<String, dynamic>>>();

  bool _isFavorite = false;
  bool get isFavorite => _isFavorite;

  Future<void> loadFavorites() async {
    state = LoadingState<List<Map<String, dynamic>>>();
    notifyListeners();

    try {
      final result = await _database.getFavorites();
      state = SuccessState<List<Map<String, dynamic>>>(result);
    } catch (e) {
      state = ErrorState<List<Map<String, dynamic>>>(
        'Failed to load favorites',
      );
    }

    notifyListeners();
  }

  Future<void> addFavorite({
    required String id,
    required String name,
    required String city,
    required String pictureId,
    required double rating,
    required String description,
  }) async {
    await _database.insertFavorite({
      'id': id,
      'name': name,
      'city': city,
      'pictureId': pictureId,
      'rating': rating,
      'description': description,
    });

    _isFavorite = true;

    await loadFavorites();
  }

  Future<void> removeFavorite(String id) async {
    await _database.removeFavorite(id);

    _isFavorite = false;

    await loadFavorites();
  }

  Future<void> checkFavorite(String id) async {
    _isFavorite = await _database.isFavorite(id);
    notifyListeners();
  }
}
