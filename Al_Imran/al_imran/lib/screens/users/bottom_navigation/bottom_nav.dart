import 'package:al_imran/constants/app_consts.dart';
import 'package:al_imran/screens/users/cart/cart.dart';
import 'package:al_imran/screens/users/favourite/favourite.dart';
import 'package:al_imran/screens/users/home/home.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyBottomNav extends StatefulWidget {
  const MyBottomNav({super.key});

  @override
  State<MyBottomNav> createState() => _MyBottomNavState();
}

class _MyBottomNavState extends State<MyBottomNav> {
  int _selectedIndex = 0;

  static const List<Widget> userScreens = <Widget>[
    Homepage(),
    UserFavourite(),
    UserCart()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userScreens[_selectedIndex],
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 5, right: 5),
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(width: 1, color: AlImran.unSelectedColor))),
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.category_outlined,
                ),
                label: 'Category'),
            BottomNavigationBarItem(
                icon: FaIcon(Icons.shopping_basket), label: 'Cart'),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          selectedItemColor: AlImran.baseColor,
          onTap: _onItemTapped,
          iconSize: 25,
          elevation: 0,
          showUnselectedLabels: true,
          selectedFontSize: 12,
          unselectedItemColor: AlImran.unSelectedColor,
        ),
      ),
    );
  }
}
