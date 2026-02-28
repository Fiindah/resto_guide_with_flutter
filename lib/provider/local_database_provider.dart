import 'package:flutter/material.dart';
import 'package:resto_app/data/local/local_data_service.dart';
import 'package:resto_app/data/model/resto_list_response.dart';

class LocalDatabaseProvider extends ChangeNotifier {
  final LocalDatabaseService _service;

  LocalDatabaseProvider(this._service);

  String _message = "";
  String get message => _message;

  List<Restaurant>? _restaurantList;
  List<Restaurant>? get restaurantList => _restaurantList;

  Restaurant? _restaurant;
  Restaurant? get restaurant => _restaurant;

  Future<void> saveRestaurant(Restaurant value) async {
    try {
      final result = await _service.insertItem(value);
      _message = result == 0
          ? "Failed to favorite data"
          : "Data favorite successfully";

      _restaurantList = await _service.getAllItems(); // 🔥 update state
    } catch (e) {
      _message = "Failed to favorite data";
    }
    notifyListeners();
  }

  Future<void> loadAllRestaurant() async {
    try {
      _restaurantList = await _service.getAllItems();
      _restaurant = null;
      _message = "All data loaded";
    } catch (e) {
      _message = "Failed to load data";
    }
    notifyListeners();
  }

  Future<void> loadRestaurantById(String id) async {
    try {
      _restaurant = await _service.getItemById(id);
      _message = "Data loaded";
    } catch (e) {
      _message = "Failed to load data";
    }
    notifyListeners();
  }

  Future<void> removeRestaurantById(String id) async {
    try {
      await _service.removeItem(id);
      _message = "Data removed";

      _restaurantList = await _service.getAllItems(); // 🔥 update state
    } catch (e) {
      _message = "Failed to remove data";
    }
    notifyListeners();
  }

  bool checkItemFavorite(String id) {
    if (_restaurantList == null) return false;
    return _restaurantList!.any((element) => element.id == id);
  }
}
