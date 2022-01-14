import 'package:flutter/material.dart';
import 'package:subtiga_restaurant/data/api/api_service.dart';
import 'package:subtiga_restaurant/data/model/restaurant.dart';

enum ResultStateSearch { Loading, Searching, NoData, HasData, Error }
class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantsResult _restaurantsSearchList;
  String _message = '';
  ResultStateSearch _state;

  RestaurantsResult get restaurantsSearchList => _restaurantsSearchList;
  String get message => _message;
  ResultStateSearch get state => _state;

  RestaurantSearchProvider({this.apiService});

  Future<dynamic> fetchRestaurantSearchList({String query=''}) async {
    try {
      _state = ResultStateSearch.Loading;
      final restaurantsSearchList = await apiService.searchRestaurant(query: query);
      if (restaurantsSearchList == 0) {
        _state = ResultStateSearch.NoData;
        notifyListeners();
        return _message = 'No Data Availble';
      } else {
        _state = ResultStateSearch.HasData;
        notifyListeners();
        return _restaurantsSearchList = restaurantsSearchList;
      }
    } catch (e) {
      _state = ResultStateSearch.Error;
      notifyListeners();
      return _message = 'Error: Sorry we cannot access the restaurant data, check your network connection, if it still doesn\'t work, come back later!';
    }
  }
}
