import 'package:devathonesmit/screens/doctor/dashboard/dashboard.dart';
import 'package:devathonesmit/screens/doctor/home/home.dart';
import 'package:devathonesmit/screens/doctor/profile/profile.dart';
import 'package:devathonesmit/screens/login/login.dart';
import 'package:devathonesmit/screens/patient/patient_dashboard.dart';
import 'package:devathonesmit/screens/signup/register.dart';
import 'package:devathonesmit/screens/splash/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: const Splash(),
      initialRoute: '/splash',
      routes: {
        '/splash': (BuildContext context) => const Splash(),
        '/login': (BuildContext context) => Login(),
        '/register': (BuildContext context) => const Register(),
        '/doctor': (BuildContext context) => const DoctorDashboard(),
        '/doctorhome': (BuildContext context) => const DoctorHome(),
        '/doctorprofile': (BuildContext context) => const DoctorProfile(),
        '/patient': (BuildContext context) => const PateintDashboard(),
      },
    );
  }
}
