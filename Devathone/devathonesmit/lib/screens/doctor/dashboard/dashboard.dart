import 'package:devathonesmit/consts/consts.dart';
import 'package:devathonesmit/screens/doctor/home/home.dart';
import 'package:devathonesmit/screens/doctor/profile/profile.dart';
import 'package:flutter/material.dart';

class DoctorDashboard extends StatefulWidget {
  const DoctorDashboard({super.key});

  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  int selectedIndex = 0;
  List<Widget> widgetOptions = <Widget>[
    const DoctorHome(),
    const DoctorProfile(),
    const Text(
      'Index 3: Schooling',
    ),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: widgetOptions.elementAt(selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Options',
            ),
          ],
          currentIndex: selectedIndex,
          selectedItemColor: AppColors.buttonColor,
          onTap: onItemTapped,
        ),
      ),
    );
  }
}
