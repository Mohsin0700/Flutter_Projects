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
      height: 10.0,
      width: 10,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 238, 236, 236),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(width: 1, color: AlImran.baseColor)),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(images[0]),
                    height: 90,
                    width: 90)),
          ),
          const Text('Item Name', style: TextStyle(fontSize: 18)),
          Text('PKR $price/-', style: const TextStyle(fontSize: 14))
        ],
      ),
    );
  }
}
