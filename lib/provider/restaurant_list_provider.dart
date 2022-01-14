import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:subtiga_restaurant/data/api/api_service.dart';
import 'package:subtiga_restaurant/data/model/restaurant.dart';

enum ResultState { Loading, NoData, HasData, Error, NoConnection }
class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantsResult _restaurantList;
  String _message = '';
  ResultState _state;

  RestaurantsResult get restaurantList => _restaurantList;
  String get message => _message;
  ResultState get state => _state;

  RestaurantListProvider({this.apiService});

  Future<dynamic> fetchRestaurantList() async {
    try {
      _state = ResultState.Loading;
      final restaurantList = await apiService.getRestaurantResult(Client());
      if (restaurantList == 0) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'No Data Availble';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantList = restaurantList;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error: Sorry we cannot access the restaurant data, check your network connection, if it still doesn\'t work, come back later!';
    }
  }
}
