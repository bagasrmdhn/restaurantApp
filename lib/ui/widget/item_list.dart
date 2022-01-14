import 'package:flutter/material.dart';
import 'package:subtiga_restaurant/data/api/url.dart';
import 'package:subtiga_restaurant/data/model/restaurant.dart';

import '../detail_page.dart';

class ItemList extends StatelessWidget {
  final Restaurants restaurant;

  const ItemList({Key key, this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, DetailPage.routeName,
            arguments: restaurant.id);
      },
      child: Card(
          child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: SizedBox(
          height: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    ApiUrl.smallImage + restaurant.pictureId,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: Text(
                  restaurant.name.toString(),
                  style: const TextStyle(
                      fontSize: 16.0, fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(
                height: 1,
              ),
              Expanded(
                child: Text(
                  restaurant.city.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.orange,
                        ),
                        Text(
                          restaurant.rating.toString(),
                          style: const TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
