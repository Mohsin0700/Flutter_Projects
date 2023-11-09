import 'dart:async';

import 'package:devathonesmit/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool isLoggedIn = false;
  bool _isAdmin = false;

  fetchLoginSate() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn = prefs.getBool('isLoggedIn') ?? isLoggedIn;
    _isAdmin = prefs.getBool('isAdmin') ?? _isAdmin;
    setState(() {});
  }

  getLoginDetails() async {
    await fetchLoginSate();
  }

  @override
  void initState() {
    getLoginDetails();
    Timer(const Duration(microseconds: 100), () {
      getLoginDetails();

      if (isLoggedIn == true) {
        if (_isAdmin == true) {
          Navigator.pushReplacementNamed(context, '/');
        } else {
          Navigator.pushReplacementNamed(context, '/doctor');
        }
      } else {
        Navigator.pushReplacementNamed(context, '/login');
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: AppColors.textFieldFocusedColor,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png'),
            ],
          ),
        ),
      ),
    );
  }
}
