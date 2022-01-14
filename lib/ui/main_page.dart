import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:subtiga_restaurant/ui/home_page.dart';
import 'package:subtiga_restaurant/ui/search_page.dart';
import 'package:subtiga_restaurant/ui/favorite_page.dart';
import 'package:subtiga_restaurant/ui/widget/platform_widget.dart';

class MainPage extends StatefulWidget {
  static const routeName = '/main_screen';


  const MainPage({key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _bottomNavIndex = 0;
  // int _currentIndex = 0;


  // final tabs = [
  //   HomePage(),
  //   SearchPage(),
  //   FavoritePage(),
  // ];

  final List<Widget> _listWidget = [
    const HomePage(),
    const SearchPage(),
    const FavoritePage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: '',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.search),
      label: '',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite_outline_rounded),
      label: '',
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.blue,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
    );
  }
}
