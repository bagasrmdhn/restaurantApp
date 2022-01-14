import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:subtiga_restaurant/provider/restaurant_search_provider.dart';
import 'package:subtiga_restaurant/ui/widget/item_list.dart';

class SearchPage extends StatefulWidget{
  static const routeName = '/search_page';

  const SearchPage({Key key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchScreenState();

}

class _SearchScreenState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _search = TextEditingController();
    Provider.of<RestaurantSearchProvider>(
      context,
      listen: false,
    ).fetchRestaurantSearchList();
    return SafeArea(
      child: Column(
        children: [
          Consumer<RestaurantSearchProvider>(
            builder: (context, state, _) {
              return Container(
                padding: const EdgeInsets.all(16.0),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.grey,
                    ),
                  ),
                ),
                child: TextField(
                  controller: _search,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    hintText: 'Mau cari restaurant apa?',
                    contentPadding: const EdgeInsets.all(10.0),
                    filled: true,
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey[300],
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: const Icon(Icons.search),
                    suffixIcon: _search.text.isNotEmpty
                        ? GestureDetector(
                      onTap: () {
                        _search.clear();
                        state.fetchRestaurantSearchList(query: '');
                      },
                      child: const Icon(
                        Icons.close,
                      ),
                    )
                        : null,
                  ),
                  onChanged: (query) {
                    state.fetchRestaurantSearchList(query: query);
                  },
                ),
              );
            },
          ),
          Expanded(
            flex: 8,
            child: Consumer<RestaurantSearchProvider>(
              builder: (context, state, _) {
                if (state.state == ResultStateSearch.Loading) {
                  return const Center(
                      child: CircularProgressIndicator()
                  );
                } else if (state.state == ResultStateSearch.Searching) {
                  return const Center(
                    child: CircularProgressIndicator()
                  );
                }else if (state.state == ResultStateSearch.HasData) {
                  return GridView.builder(
                    shrinkWrap: true,
                    itemCount: state.restaurantsSearchList.restaurants.length,
                    padding: const EdgeInsets.all(16.0),
                    itemBuilder: (context, index) {
                      return ItemList(
                        restaurant: state.restaurantsSearchList.restaurants[index],
                      );
                    }, gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, childAspectRatio: 2 / 3),
                  );
                } else if (state.state == ResultStateSearch.NoData) {
                  return const Center(
                    child: Text('No Data'),
                  );
                } else if (state.state == ResultStateSearch.Error) {
                  return const Center(
                    child: Text(''),
                  );
                }else {
                  return const Center(
                    child: Text(''),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

}