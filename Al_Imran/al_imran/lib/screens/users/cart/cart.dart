// import 'dart:convert';

import 'package:al_imran/constants/app_consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';

class UserCart extends StatefulWidget {
  const UserCart({super.key});
  static List prices = [];
  static late List myCartItems;

  @override
  State<UserCart> createState() => _UserCartState();
}

class _UserCartState extends State<UserCart> {
  // ignore: non_constant_identifier_names
  User CurrentUser = FirebaseAuth.instance.currentUser!;
  num total = 0;
  CollectionReference allOrdersRef =
      FirebaseFirestore.instance.collection('all_orders');

  CollectionReference allUsersRef =
      FirebaseFirestore.instance.collection('users');

  placeOrder() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: prefer_typing_uninitialized_variables
    var currentUserData;
    List previousOrders;
    await allUsersRef
        .doc(CurrentUser.uid)
        .collection('cart')
        .add({'cartItem': UserCart.myCartItems}).then(
            (value) => print('Item added successfully'));
    // await allUsersRef.doc(CurrentUser.uid).get().then((value) async {
    //   currentUserData = value.data();
    //   print(currentUserData);
    //   previousOrders = currentUserData['orders'];
    //   print(previousOrders);
    //   // previousOrders.add(UserCart.myCartItems);
    //   // currentUserData['orders'] = previousOrders;
    //   await allUsersRef.doc(CurrentUser.uid).set(currentUserData);
    //   total = 0;
    // });
    UserCart.prices.clear();
    // await prefs.remove('cart');
    setState(() {});
  }

  getTotal() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // String data = prefs.getString('cart')!;
    // List cartItems = jsonDecode(data);
    // UserCart.myCartItems = cartItems;
    UserCart.myCartItems = AlImran.cart;

    UserCart.prices.clear();
    for (var item in UserCart.myCartItems) {
      UserCart.prices.add(item['currentItem']['itemPrice']);
    }
    total = UserCart.prices
        .fold(0, (previousValue, currentVal) => previousValue + currentVal);
    setState(() {});
    return UserCart.myCartItems;
  }

  @override
  void initState() {
    super.initState();
    getTotal();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cart', style: TextStyle(color: Colors.black)),
          centerTitle: true,
          backgroundColor: AlImran.baseColor,
          automaticallyImplyLeading: false,
        ),
        body: AlImran.cart.isEmpty
            ? const Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('Empty Cart')],
              ))
            : Column(
                children: [
                  FutureBuilder(
                      future: getTotal(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (!snapshot.hasData) {
                          return const Icon(Icons.hourglass_empty);
                        }
                        return ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: AlImran.cart.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.only(
                                    top: 15, right: 5, left: 5),
                                child: ListTile(
                                    tileColor: AlImran.secondaryColor,
                                    leading: ClipRRect(
                                        borderRadius: BorderRadius.circular(45),
                                        child: Image(
                                            height: 50,
                                            width: 50,
                                            image: NetworkImage(
                                              AlImran.cart[index]['currentItem']
                                                      ['itemImages'][
                                                  AlImran.cart[index]
                                                      ['picIndex']],
                                            ),
                                            fit: BoxFit.cover)),
                                    title: Text(snapshot.data[index]
                                        ['currentItem']['itemName']),
                                    subtitle: Text(
                                        'PKR ${snapshot.data[index]['currentItem']['itemPrice']}/-'),
                                    shape: Border.all(
                                        width: 2, color: AlImran.baseColor)),
                              );
                            });
                      })
                ],
              ),
        persistentFooterButtons: [
          Text('Total $total/-'),
          AlImran.cart.isEmpty
              ? const Icon(Icons.currency_rupee_rounded)
              : ElevatedButton(
                  onPressed: () {
                    placeOrder();
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AlImran.baseColor)),
                  child: const Text('Place order'),
                )
        ],
      ),
    );
  }
}
