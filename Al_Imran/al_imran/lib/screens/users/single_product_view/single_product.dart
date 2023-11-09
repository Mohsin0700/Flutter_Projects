// ignore_for_file: use_build_context_synchronously

// import 'dart:convert';

import 'package:al_imran/constants/app_consts.dart';
import 'package:al_imran/screens/users/single_product_view/widgets/slider.dart';
import 'package:al_imran/widgets/my_custom_button.dart';
import 'package:al_imran/widgets/my_custom_dialouge.dart';
import 'package:flutter/material.dart';

class SingleProductPage extends StatefulWidget {
  const SingleProductPage({super.key, required this.currentItem});
  final Map currentItem;

  @override
  State<SingleProductPage> createState() => _SingleProductPageState();
}

class _SingleProductPageState extends State<SingleProductPage> {
  addToCart() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    AlImran.cart.add({
      'currentItem': widget.currentItem,
      'picIndex': SingleProduct.picIndex
    });
    showDialog(
        context: context,
        builder: (context) => const MyCustomDialouge(
            alertTitle: 'Added to cart successfully',
            alertIcon: Icon(Icons.done)));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text(widget.currentItem['itemName']),
              centerTitle: true,
              backgroundColor: AlImran.baseColor,
            ),
            body: Container(
                padding: const EdgeInsets.all(15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          height: 200,
                          child: SingleProductSlider(
                              imagesUrl: widget.currentItem['itemImages'])),
                      const SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                'Category: ${widget.currentItem['itemCategory']}',
                                style: const TextStyle(fontSize: 20)),
                            Text('PKR: ${widget.currentItem['itemPrice']}/-',
                                style: const TextStyle(fontSize: 20))
                          ]),
                      const Divider(color: Colors.black, thickness: 1),
                      Text('Description:', style: AlImran.regularTextStyle),
                      Text(widget.currentItem['description']),
                      const Spacer(),
                      MyCustomButton(
                          buttonName: 'Add to cart',
                          onPressed: () {
                            addToCart();
                          })
                    ]))));
  }
}

class SingleProduct {
  static int picIndex = 0;
}
