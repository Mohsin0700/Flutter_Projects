import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devathonesmit/consts/consts.dart';
import 'package:devathonesmit/screens/patient/doctor_card.dart';
import 'package:devathonesmit/screens/widgets/my_customheader.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PatientHome extends StatefulWidget {
  const PatientHome({super.key});

  @override
  State<PatientHome> createState() => _PatientHomeState();
}

TextEditingController _searchController = TextEditingController();

class _PatientHomeState extends State<PatientHome> {
  bool isSigningOut = false;
  bool isLoggedIn = false;
  List docterList = [];

  signUserOut() async {
    isSigningOut = true;
    setState(() {});
    await FirebaseAuth.instance.signOut();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
    await prefs.setBool('isAdmin', false);
    setState(() {});
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        MyCustomHeader(
          pageTitle: 'Patient Home',
          onPressed: () {
            signUserOut();
          },
        ),
        Container(
          height: 120,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Color(0xffb592fa),
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(60)),
          ),
          child: Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.search)),
                  hintText: 'Search Doctor By name?',
                  labelText: 'Search Doctor By name *',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Text(
            'Categories',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                height: 80,
                width: 90,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/generalIconPng.png',
                      height: 40,
                      width: 40,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      'No Name',
                      style: TextStyle(color: AppColors.buttonColor),
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                height: 80,
                width: 100,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/generalIconPng.png',
                      height: 40,
                      width: 40,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text('Cardiology',
                        style: TextStyle(color: AppColors.buttonColor))
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: AppColors.buttonColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/generalIconPng.png',
                      height: 40,
                      width: 40,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text('Medicine',
                        style: TextStyle(color: AppColors.buttonColor))
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  color: AppColors.secondaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/images/generalIconPng.png',
                      height: 40,
                      width: 40,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text('General',
                        style: TextStyle(color: AppColors.buttonColor))
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const DoctorCard(),
        StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                for (var i in snapshot.data!.docs) {
                  if (i['roll'] == 'Doctor') docterList.add(i);
                }
              }
              return ListView.builder(itemBuilder: (context, index) {
                return const ListTile();
              });
            })
      ])),
    );
  }
}
