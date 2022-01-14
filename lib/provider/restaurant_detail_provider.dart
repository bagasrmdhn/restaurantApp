import 'package:flutter/material.dart';
import 'package:subtiga_restaurant/data/api/api_service.dart';
import 'package:subtiga_restaurant/data/model/detail_restaurant.dart';

enum ResultStateDetail { Loading, NoData, HasData, Error, NoConnection }
class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantDetailResult _restaurantDetail;
  String _message = '';
  ResultStateDetail _state;

  RestaurantDetailResult get restaurantDetail => _restaurantDetail;
  String get message => _message;
  ResultStateDetail get state => _state;

  RestaurantDetailProvider({this.apiService});

  Future<dynamic> fetchRestaurantDetail(String id) async {
    try {
      _state = ResultStateDetail.Loading;
      final restaurantDetail = await apiService.getRestaurantDetailResult(id: id);
      if (restaurantDetail == 0) {
        _state = ResultStateDetail.NoData;
        notifyListeners();
        return _message = 'No Data Availble';
      } else {
        _state = ResultStateDetail.HasData;
        notifyListeners();
        return _restaurantDetail = restaurantDetail;
      }
    } catch (e) {
      _state = ResultStateDetail.Error;
      notifyListeners();
      return _message = 'Error: Sorry we cannot access the restaurant data, check your network connection, if it still doesn\'t work, come back later!';
    }
  }
}
