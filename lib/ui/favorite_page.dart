import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subtiga_restaurant/data/lokal/database_helper.dart';
import 'package:subtiga_restaurant/provider/restaurant_favorite_provider.dart';
import 'package:subtiga_restaurant/provider/restaurant_list_provider.dart';


import 'widget/item_list.dart';

class FavoritePage extends StatefulWidget {
  static const String routeName = '/favorite_page';

  const FavoritePage({Key key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantsFavoriteProvider>(
      create: (_) => RestaurantsFavoriteProvider(
        databaseHelper: DatabaseHelper(),
      ),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              title: const Text(
                'Favorite Page',
                style: TextStyle(color: Colors.white),
              ),
            ),
            body: _buildList(),
          );
        }
      ),
    );
  }

  Widget _buildList() {
    return Consumer<RestaurantsFavoriteProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.HasData) {
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: provider.favorite.length,
            itemBuilder: (context, index) {
              return ItemList(
                restaurant: provider.favorite[index],
              );
            }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 2 / 3),
          );
        } else {
          return Center(
            child: Text(provider.message),
          );
        }
      },
    );
  }
}
