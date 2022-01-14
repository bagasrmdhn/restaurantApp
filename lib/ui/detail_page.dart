import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subtiga_restaurant/data/api/url.dart';
import 'package:subtiga_restaurant/data/model/restaurant.dart';
import 'package:subtiga_restaurant/provider/restaurant_detail_provider.dart';
import 'package:subtiga_restaurant/ui/widget/favorite_button.dart';

class DetailPage extends StatelessWidget{
  static const routeName = '/detail_page';

  final String id;
  const DetailPage({Key key,  this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<RestaurantDetailProvider>(context, listen: false,).fetchRestaurantDetail(id);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<RestaurantDetailProvider>(builder: (context, state, _) {
          if (state.state == ResultStateDetail.Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.state == ResultStateDetail.HasData) {
            final result = state.restaurantDetail.restaurant;
            final responseFavorite = Restaurants(
              id: result.id,
              name: result.name,
              pictureId: result.pictureId,
              city:result.city,
              rating: result.rating.toDouble(),
            );
            return SafeArea(
              bottom: false,
              child: Stack(
                children: [
                  ListView(
                    children: [
                      Image.network(
                        ApiUrl.mediumImage + result.pictureId,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              result.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Column(
                                children: <Widget>[
                                  const Icon(Icons.place),
                                  const SizedBox(height: 8,),
                                  Text(result.city,)
                                ]
                            ),
                            Column(
                              children: <Widget>[
                                const Icon(Icons.star_outlined),
                                const SizedBox(height: 8,),
                                Text(result.rating.toString()),
                              ],
                            ),
                          ]
                      ),
                      Container(
                        padding: const EdgeInsets.all(2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            const SizedBox(height: 20),
                            const Text("Description :",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0
                              ),
                            ),
                            Text(
                              result.description.toString(),
                              style: const TextStyle(
                                fontSize: 17.0,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text("Foods",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0
                              ),
                            ),
                            const SizedBox(height: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: result.menus.foods
                                  .map((food) => Text(
                                food.name,
                                style: const TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ))
                                  .toList(),
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            const SizedBox(height: 20),
                            const Text("Drinks",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0
                              ),
                            ),
                            const SizedBox(height: 5),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: result.menus.drinks
                                  .map((drink) => Text(
                                drink.name,
                                style: const TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.normal,
                                ),
                              ))
                                  .toList(),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 30,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              }),
                        ),
                        FavoriteButton(favorite: responseFavorite)
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state.state == ResultStateDetail.NoData) {
            return Center(
              child: Text(state.message),
            );
          } else if (state.state == ResultStateDetail.Error) {
            return Center(
              child: Text(state.message),
            );
          } else if (state.state == ResultStateDetail.NoConnection) {
            return SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    style:
                    const TextStyle(fontSize: 20, color: Colors.blueGrey),
                  ),
                  const SizedBox(height: 25),
                ],
              ),
            );
          } else {
            return const Center(
              child: Text(''),
            );
          }
        }),
    );
  }
}
