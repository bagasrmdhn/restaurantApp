import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subtiga_restaurant/data/model/restaurant.dart';
import 'package:subtiga_restaurant/provider/database_provider.dart';

class FavoriteButton extends StatelessWidget {
  final Restaurants favorite;

  const FavoriteButton({Key key, this.favorite}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isFavorited(favorite.id),
          builder: (context, snapshot) {
            var isFavorite = snapshot.data ?? false;
            return isFavorite
                ? InkWell(
              onTap: () {
                provider.removeRestaurant(favorite.id);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(1),
                child: const Icon(
                  Icons.favorite_rounded,
                  color: Colors.red,
                ),
              ),
            )
                : InkWell(
              onTap: () {
                provider.addRestaurant(favorite);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(100),
                ),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(1),
                child: const Icon(
                  Icons.favorite_outline_rounded,
                  color: Colors.grey,
                ),
              ),
            );
          },
        );
      },
    );
  }
}