import 'package:al_imran/constants/app_consts.dart';
import 'package:al_imran/screens/users/single_product_view/widgets/slider.dart';
import 'package:al_imran/widgets/my_custom_button.dart';
import 'package:flutter/material.dart';

class SingleProductPage extends StatelessWidget {
  const SingleProductPage({super.key, required this.currentItem});
  final Map currentItem;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(currentItem['itemName']),
          centerTitle: true,
          backgroundColor: AlImran.baseColor,
        ),
        body: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                height: 200,
                child: SingleProductSlider(
                  imagesUrl: currentItem['itemImages'],
                ),
              ),
              Row(
                children: [
                  Text(
                    'Category: ${currentItem['itemCategory']}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ],
              ),
              const Spacer(),
              MyCustomButton(
                buttonName: 'Add to cart',
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
