import 'package:devathonesmit/consts/consts.dart';
import 'package:devathonesmit/screens/widgets/custom_button.dart';
import 'package:devathonesmit/screens/widgets/custom_textfield.dart';
import 'package:devathonesmit/screens/widgets/my_customdialouge.dart';
import 'package:devathonesmit/screens/widgets/my_textbutton.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String? _character;
  bool _isVisible = false;
  bool _isSigningIn = false;
  TextEditingController userNameController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPassController = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser() {
    String userUid;
    User user = FirebaseAuth.instance.currentUser!;
    userUid = user.uid;
    return users.doc(userUid).set({
      'username': userNameController.text,
      'email': userEmailController.text,
      'password': userPassController.text,
      'userId': userUid,
      'roll': _character,
      'orders': [],
    });
  }

  void updatePassView() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  register() async {
    try {
      _isSigningIn = true;
      // ignore: unused_local_variable
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: userEmailController.text,
              password: userPassController.text);
      // ignore: use_build_context_synchronously
      await showDialog(
          context: context,
          builder: (context) => const MyCustomDialouge(
              alertIcon: Icon(Icons.done),
              alertTitle: 'Account created successfully'));
      addUser();
      _isSigningIn = false;
      // ignore: use_build_context_synchronously
      if (_character == 'Doctor') {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, '/doctor');
      } else if (_character == 'Patient') {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, '/patient');
      }
    } on FirebaseAuthException catch (e) {
      _isSigningIn = false;
      if (e.code == 'weak-password') {
// ignore: use_build_context_synchronously
        showDialog(
            context: context,
            builder: (context) => const MyCustomDialouge(
                alertIcon: Icon(Icons.close),
                alertTitle: 'Please use strong password'));
      } else if (e.code == 'email-already-in-use') {
        // ignore: use_build_context_synchronously
        showDialog(
            context: context,
            builder: (context) => const MyCustomDialouge(
                alertTitle: 'Email already exists',
                alertIcon: Icon(Icons.close)));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
                padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Image(
                            image: AssetImage('assets/images/logo.png')),
                        Column(children: [
                          Text(
                            'Registration',
                            style: AppTexts.h1,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          MyTextField(
                              label: 'Enter Your Name',
                              myController: userNameController,
                              obsecureText: false,
                              myIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.abc_outlined)),
                              hintText: 'Enter Your Name',
                              topLeft: 25,
                              topRight: 25),
                          const SizedBox(height: 5),
                          const SizedBox(
                            height: 10,
                          ),
                          MyTextField(
                            label: 'Enter Your Email',
                            myController: userEmailController,
                            obsecureText: false,
                            myIcon: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.email_outlined)),
                            hintText: 'Enter Email',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(height: 5),
                          // Password TextField Custom Widget
                          MyTextField(
                              label: 'Enter Password',
                              myController: userPassController,
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
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ListTile(
                                  title: const Text('Patient'),
                                  leading: Radio(
                                      value: 'Patient',
                                      groupValue: _character,
                                      onChanged: (value) {
                                        setState(() {
                                          _character = value;
                                          print(value);
                                        });
                                      }),
                                ),
                              ),
                              Expanded(
                                child: ListTile(
                                  title: const Text('Doctor'),
                                  leading: Radio(
                                      value: 'Doctor',
                                      groupValue: _character,
                                      onChanged: (value) {
                                        setState(() {
                                          _character = value;
                                          print(value);
                                        });
                                      }),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            child: const MyTextButton(
                                buttonTitle: 'Already have an account? ',
                                subTitle: 'Click here',
                                routeName: '/login'),
                          ),
                          const SizedBox(height: 120),
                          // Custom Register Button
                          MyCustomButton(
                              onPressed: () {
                                register();
                              },
                              buttonName: 'Register')
                        ]),
                        Visibility(
                            visible: _isSigningIn,
                            child: CircularProgressIndicator(
                                color: AppColors.textFieldFocusedColor))
                      ]),
                ))));
  }
}
