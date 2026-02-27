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
          ? "Failed to save data"
          : "Data saved successfully";
    } catch (e) {
      _message = "Failed to save data";
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
    } catch (e) {
      _message = "Failed to remove data";
    }
    notifyListeners();
  }

  bool checkItemFavorite(String id) {
    final isSameRestaurant = _restaurant?.id == id;
    return isSameRestaurant;
  }
}