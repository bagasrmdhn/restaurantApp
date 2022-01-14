import 'package:flutter/material.dart';
import 'package:subtiga_restaurant/data/lokal/database_helper.dart';
import 'package:subtiga_restaurant/data/model/restaurant.dart';
import 'package:subtiga_restaurant/provider/restaurant_list_provider.dart';

class RestaurantsFavoriteProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  RestaurantsFavoriteProvider({this.databaseHelper}) {
    _getFavorite();
  }

  ResultState _state;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurants> _favorite = [];
  List<Restaurants> get favorite => _favorite;

  Restaurants _restaurant;
  Restaurants get restaurant => _restaurant;

  void _getFavorite() async {
    _favorite = await databaseHelper.getRestaurants();
    if (_favorite.isNotEmpty) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = 'Data Kosong';
    }
    notifyListeners();
  }

  void addFavorite(Restaurants restaurant) async {
    try {
      await databaseHelper.insertRestaurants(restaurant);
      _getFavorite();
    } catch (e) {
      _state = ResultState.Error;
      _message =
      'Sorry we cannot access the restaurant data, check your network connection, if it still doesn\'t work, come back later!';
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favorited = await databaseHelper.getRestauranyById(id);
    return favorited.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.deleteRestaurantsById(id);
      _getFavorite();
    } catch (e) {
      _state = ResultState.Error;
      _message =
      'Sorry we cannot access the restaurant data, check your network connection, if it still doesn\'t work, come back later!';
      notifyListeners();
    }
  }
}
