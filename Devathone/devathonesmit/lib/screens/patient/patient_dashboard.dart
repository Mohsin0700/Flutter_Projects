import 'package:devathonesmit/consts/consts.dart';
import 'package:devathonesmit/screens/patient/patient_bookanappointment.dart';
import 'package:devathonesmit/screens/patient/patient_bookings.dart';
import 'package:devathonesmit/screens/patient/patient_home.dart';
import 'package:flutter/material.dart';

class PateintDashboard extends StatefulWidget {
  const PateintDashboard({super.key});

  @override
  State<PateintDashboard> createState() => _PateintDashboardState();
}

class _PateintDashboardState extends State<PateintDashboard> {
  int selectedIndex = 0;
  List<Widget> widgetOptions = <Widget>[
    const PatientHome(),
    const PatientBooking(),
    const PatientBookanAppointment()
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: 'Home',
              backgroundColor: AppColors.buttonColor),
          BottomNavigationBarItem(
              icon: const Icon(Icons.book_online),
              label: 'Bookings',
              backgroundColor: AppColors.buttonColor),
          BottomNavigationBarItem(
              icon: const Icon(Icons.app_registration_rounded),
              label: 'Book an Appointment',
              backgroundColor: AppColors.buttonColor),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: AppColors.buttonColor,
        onTap: onItemTapped,
      ),
    );
  }
}
