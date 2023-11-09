import 'package:al_imran/constants/app_consts.dart';
import 'package:al_imran/screens/users/home/widgets/my_carousel.dart';
import 'package:al_imran/screens/users/single_product_view/single_product.dart';
import 'package:al_imran/widgets/item_card.dart';
import 'package:al_imran/widgets/my_custom_progress_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool isSigningOut = false;
  bool isLoggedIn = false;

  CollectionReference allItems =
      FirebaseFirestore.instance.collection('all_items');

  signUserOut() async {
    isSigningOut = true;
    setState(() {});
    await FirebaseAuth.instance.signOut();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
    setState(() {});
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, '/login');
  }

  String imgUrl = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: RotatedBox(
          quarterTurns: 2,
          child: IconButton(
              onPressed: () {
                signUserOut();
              },
              icon: const Icon(Icons.logout, color: Colors.black)),
        ),
        automaticallyImplyLeading: false,
        title: const Text('Home', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: AlImran.baseColor,
      ),
      body: isSigningOut
          ? const MyCustomProgressIndicator(indicatorTitle: 'Signing Out')
          : SingleChildScrollView(
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  height: 200,
                  child: const MyCarousel(),
                ),
                Container(
                    // color: Colors.red,
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    child: FutureBuilder(
                      future: allItems.get(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data!.docs.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisSpacing: 15,
                                      crossAxisSpacing: 15,
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SingleProductPage(currentItem: {
                                                'itemName': snapshot.data!
                                                    .docs[index]['itemName'],
                                                'itemPrice': snapshot.data!
                                                    .docs[index]['itemPrice'],
                                                'itemImages': snapshot.data!
                                                    .docs[index]['itemImages'],
                                                'itemCategory':
                                                    snapshot.data!.docs[index]
                                                        ['itemCategory'],
                                                'description': snapshot.data!
                                                    .docs[index]['description']
                                              }))),
                                  child: ItemCard(
                                    name: snapshot.data!.docs[index]
                                        ['itemName'],
                                    price: snapshot
                                        .data!.docs[index]['itemPrice']
                                        .toString(),
                                    images: snapshot.data!.docs[index]
                                        ['itemImages'],
                                  ),
                                );
                              });
                        }
                        return const CircularProgressIndicator();
                      },
                    ))
              ]),
            ),
    ));
  }
}
