// To parse this JSON data, do
//
//     final restaurantsSearch = restaurantsSearchFromJson(jsonString);

import 'dart:convert';

RestaurantsSearch restaurantsSearchFromJson(String str) => RestaurantsSearch.fromJson(json.decode(str));

String restaurantsSearchToJson(RestaurantsSearch data) => json.encode(data.toJson());

class RestaurantsSearch {
  RestaurantsSearch({
    this.error,
    this.founded,
    this.restaurants,
  });

  final bool error;
  final int founded;
  final List<Restaurant> restaurants;

  factory RestaurantsSearch.fromJson(Map<String, dynamic> json) => RestaurantsSearch(
    error: json["error"],
    founded: json["founded"],
    restaurants: List<Restaurant>.from(json["restaurants"].map((x) => Restaurant.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "error": error,
    "founded": founded,
    "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };
}

class Restaurant {
  Restaurant({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.rating,
  });

  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    pictureId: json["pictureId"],
    city: json["city"],
    rating: json["rating"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "pictureId": pictureId,
    "city": city,
    "rating": rating,
  };
}
