import 'package:al_imran/widgets/my_custom_button.dart';
import 'package:al_imran/widgets/my_custom_dialouge.dart';
import 'package:al_imran/widgets/my_custom_progress_indicator.dart';
import 'package:al_imran/widgets/my_text_button.dart';
import 'package:al_imran/widgets/my_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isLoggedIn = false;
  bool _isVisible = false;
  bool _isLoggingIn = false;
  bool _isAdmin = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void updatePassView() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  login() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn = true;
    await prefs.setBool('isLoggedIn', isLoggedIn);
    _isLoggingIn = true;
    setState(() {});

    // bool? currentUserRole;
    try {
      // ignore: unused_local_variable
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      CollectionReference users =
          FirebaseFirestore.instance.collection('users');
      User user = FirebaseAuth.instance.currentUser!;
      users.doc(user.uid).get().then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          if (documentSnapshot.get('isAdmin') == true) {
            _isAdmin = true;
            prefs.setBool('isAdmin', _isAdmin);
            Navigator.pushNamedAndRemoveUntil(
                context, '/adminBottomNav', (_) => false);
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, '/bottomNav', (_) => false);
          }
        } else {
          const MyCustomDialouge(
            alertTitle: 'User does not exists',
            alertIcon: Icon(Icons.cancel),
          );
        }
      });
    } catch (e) {
      _isLoggingIn = false;
      setState(() {});
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) => const MyCustomDialouge(
              alertIcon: Icon(Icons.close),
              alertTitle: 'Incorrect username or password'));
    }
    emailController.clear();
    passwordController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: _isLoggingIn
                ? const MyCustomProgressIndicator(indicatorTitle: 'Signing-In')
                : Container(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Image(
                              image: AssetImage('assets/images/imr.png')),
                          Column(children: [
                            MyTextField(
                                myController: emailController,
                                obsecureText: false,
                                myIcon: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.email_outlined)),
                                hintText: 'Enter Email',
                                topLeft: 25,
                                topRight: 25),
                            const SizedBox(height: 5),
                            MyTextField(
                                myController: passwordController,
                                obsecureText: _isVisible ? false : true,
                                myIcon: IconButton(
                                    onPressed: () {
                                      updatePassView();
                                    },
                                    icon: Icon(_isVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off)),
                                hintText: 'Enter Password',
                                bottomRight: 25,
                                bottomLeft: 25),
                            const SizedBox(height: 20),
                            MyCustomButton(
                                onPressed: () => login(), buttonName: 'Login')
                          ]),
                          const MyTextButton(
                              buttonTitle: "Don't have an account? ",
                              subTitle: "Signup here",
                              routeName: "/register")
                        ]))));
  }
}
