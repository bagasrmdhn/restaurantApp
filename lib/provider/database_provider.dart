import 'package:flutter/material.dart';
import 'package:subtiga_restaurant/data/lokal/database_helper.dart';
import 'package:subtiga_restaurant/data/model/restaurant.dart';
import 'package:subtiga_restaurant/provider/restaurant_list_provider.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurants> _result = [];
  List<Restaurants> get result => _result;

  DatabaseProvider({this.databaseHelper}) {
    getRestaurant();
  }

  void getRestaurant() async {
    _result = await databaseHelper.getRestaurants();

    if (_result.isNotEmpty) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = 'Empty Data';
    }
    notifyListeners();
  }

  void addRestaurant(Restaurants restaurant) async {
    try {
      await databaseHelper.insertRestaurants(restaurant);
      getRestaurant();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: Sorry we cannot access the restaurant data, check your network connection, if it still doesn\'t work, come back later!';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favoriteRestaurant = await databaseHelper.getRestauranyById(id);
    return favoriteRestaurant.isNotEmpty;
  }

  void removeRestaurant(String id) async {
    try {
      await databaseHelper.deleteRestaurantsById(id);
      getRestaurant();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Error: Sorry we cannot access the restaurant data, check your network connection, if it still doesn\'t work, come back later!';
      notifyListeners();
    }
  }
}