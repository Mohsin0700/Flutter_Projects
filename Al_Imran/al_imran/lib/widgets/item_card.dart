import 'package:al_imran/constants/app_consts.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final String name;
  final String price;
  final List images;
  const ItemCard(
      {super.key,
      required this.name,
      required this.price,
      required this.images});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 100,
      width: 100,
      decoration: BoxDecoration(
          color: AlImran.secondaryColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(width: 1, color: AlImran.baseColor)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image(
              image: NetworkImage(images[0]),
              height: 90,
              width: 90,
            ),
          ),
          const Text(
            'Item Name',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Text(
            'PKR $price/-',
            style: const TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
