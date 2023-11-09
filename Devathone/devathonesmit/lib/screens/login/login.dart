import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devathonesmit/consts/consts.dart';
import 'package:devathonesmit/screens/widgets/custom_button.dart';
import 'package:devathonesmit/screens/widgets/custom_textfield.dart';
import 'package:devathonesmit/screens/widgets/my_customdialouge.dart';
import 'package:devathonesmit/screens/widgets/my_textbutton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  Login({super.key});

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
          print(' hi ${documentSnapshot.data.toString()}');

          if (documentSnapshot.get('roll') == 'Doctor') {
            _isAdmin = true;
            prefs.setBool('isAdmin', _isAdmin);
            Navigator.pushNamedAndRemoveUntil(context, '/doctor', (_) => false);
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, '/patient', (_) => false);
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
        body: Container(
          margin: const EdgeInsets.only(bottom: 5, left: 15, right: 15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset('assets/images/logo.png'),
                const SizedBox(
                  height: 90,
                ),
                Column(
                  children: [
                    Text('Login', style: AppTexts.h1),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextField(
                      label: 'username',
                      hintText: 'Enter Your Email',
                      myIcon: IconButton(
                          icon: const Icon(Icons.male), onPressed: () {}),
                      obsecureText: false,
                      myController: emailController,
                      topLeft: 15,
                      topRight: 15,
                      bottomLeft: 15,
                      bottomRight: 15,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyTextField(
                      label: 'Password',
                      hintText: 'Enter Your Username',
                      myIcon: IconButton(
                          onPressed: () {
                            updatePassView();
                          },
                          icon: Icon(_isVisible
                              ? Icons.visibility
                              : Icons.visibility_off)),
                      obsecureText: false,
                      myController: passwordController,
                      topLeft: 15,
                      topRight: 15,
                      bottomLeft: 15,
                      bottomRight: 15,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const MyTextButton(
                        buttonTitle: "Don't have an account?",
                        subTitle: 'Register here!',
                        routeName: '/register')
                  ],
                ),
              ],
            ),
          ),
        ),
        persistentFooterButtons: [
          MyCustomButton(
              buttonName: 'Login',
              onPressed: () {
                login();
              }),
        ],
      ),
    );
  }
}
