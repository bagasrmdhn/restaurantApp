import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subtiga_restaurant/provider/restaurant_list_provider.dart';
import 'package:subtiga_restaurant/ui/widget/drawer_widget.dart';
import 'package:subtiga_restaurant/ui/widget/item_list.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Provider.of<RestaurantListProvider>(context, listen: false)
        .fetchRestaurantList();
    return Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: const Text('Restaurant Api'),
        centerTitle: true,
      ),
      body: Consumer<RestaurantListProvider>(builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.state == ResultState.HasData) {
          return GridView.builder(
            shrinkWrap: true,
            itemCount: state.restaurantList.restaurants.length,
            itemBuilder: (context, index) {
              return ItemList(
                restaurant: state.restaurantList.restaurants[index],
              );
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 2 / 3),
          );
        } else if (state.state == ResultState.NoData) {
          return Center(
            child: Text(state.message),
          );
        } else if (state.state == ResultState.Error) {
          return Center(
            child: Text(state.message),
          );
        } else if (state.state == ResultState.NoConnection) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  state.message,
                  style: const TextStyle(fontSize: 20, color: Colors.blueGrey),
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
