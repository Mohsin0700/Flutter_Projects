import 'package:al_imran/constants/app_consts.dart';
import 'package:al_imran/screens/admin/homepage/admin_home.dart';
import 'package:al_imran/screens/admin/options/options.dart';
import 'package:al_imran/screens/users/cart/cart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AdminBottomNav extends StatefulWidget {
  const AdminBottomNav({super.key});

  @override
  State<AdminBottomNav> createState() => _AdminBottomNavState();
}

class _AdminBottomNavState extends State<AdminBottomNav> {
  int _selectedIndex = 0;

  static const List<Widget> userScreens = <Widget>[
    AdminHome(),
    UserCart(),
    Options(),
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
                icon: FaIcon(Icons.list_alt_outlined), label: 'Orders'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: 'Options'),
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
