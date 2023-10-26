// import 'package:al_imran/constants/app_consts.dart';
import 'package:al_imran/screens/admin/add_items/add_items.dart';
import 'package:al_imran/screens/admin/options/options.dart';
import 'package:al_imran/screens/admin/bottom_nav_admin/admin_bottom_nav.dart';
import 'package:al_imran/screens/admin/categories/categories.dart';
import 'package:al_imran/screens/admin/slider/slider_images.dart';
import 'package:al_imran/screens/users/bottom_navigation/bottom_nav.dart';
import 'package:al_imran/screens/login/login.dart';
import 'package:al_imran/screens/register/register.dart';
import 'package:al_imran/screens/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // darkTheme: ThemeData(brightness: Brightness.light),
        initialRoute: '/splash',
        routes: {
          '/splash': (BuildContext context) => const Splash(),
          '/login': (BuildContext context) => const Login(),
          '/register': (BuildContext context) => const Register(),
          '/bottomNav': (BuildContext context) => const MyBottomNav(),
          '/adminBottomNav': (BuildContext context) => const AdminBottomNav(),
          '/options': (BuildContext context) => const Options(),
          '/sliderImages': (BuildContext context) => const SliderImages(),
          '/categories': (BuildContext context) => const Categories(),
          '/addItem': (BuildContext context) => const AddItem(),
        },
        debugShowCheckedModeBanner: false,
        title: 'Al-Imran Fabrics',
        home: const Splash());
  }
}
