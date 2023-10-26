import 'package:al_imran/constants/app_consts.dart';
import 'package:al_imran/widgets/my_custom_listtile.dart';
import 'package:flutter/material.dart';

class Options extends StatelessWidget {
  const Options({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding:
            const EdgeInsets.only(top: 200, bottom: 200, right: 10, left: 10),
        color: AlImran.baseColor,
        width: double.infinity,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MyCustomListTile(
                namedRout: '/sliderImages',
                customTitle: 'Slider Images',
                customIcon: Icon(Icons.image)),
            MyCustomListTile(
                namedRout: '/addItem',
                customTitle: 'Add Items',
                customIcon: Icon(Icons.shopping_bag_outlined)),
            MyCustomListTile(
                namedRout: '/categories',
                customTitle: 'Categories',
                customIcon: Icon(Icons.shopping_basket)),
          ],
        ),
      ),
    );
  }
}
