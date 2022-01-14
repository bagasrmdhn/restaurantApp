import 'dart:convert';

import 'package:subtiga_restaurant/data/api/url.dart';
import 'package:subtiga_restaurant/data/model/detail_restaurant.dart';
import 'package:subtiga_restaurant/data/model/restaurant.dart';
import 'package:http/http.dart' as http;
class ApiService {

  Future<RestaurantsResult> searchRestaurant({String query}) async {
    final response = await http.get(
      Uri.parse(
       ApiUrl.search+query,
      ),
    );

    if (response.statusCode == 200) {
      return RestaurantsResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load search result!');
    }
  }

  Future<RestaurantsResult> getRestaurantResult(http.Client client) async {
    final response = await client.get(Uri.parse(
        ApiUrl.list,
      ),
    );
    if (response.statusCode == 200) {
      return RestaurantsResult.fromJson(json.decode(response.body));
    } else {
      throw Exception("Gagal menampilkan data restaurant");
    }
  }

  Future<RestaurantDetailResult> getRestaurantDetailResult({String id})  async {
    final response = await http.get(Uri.parse(
      ApiUrl.detail+id,
    ),
    );
    if (response.statusCode == 200) {
      return RestaurantDetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception("Gagal menampilkan data restaurant");
    }
  }


}
