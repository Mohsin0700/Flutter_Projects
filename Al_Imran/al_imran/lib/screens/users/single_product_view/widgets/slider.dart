import 'package:al_imran/constants/app_consts.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SingleProductSlider extends StatelessWidget {
  const SingleProductSlider({super.key, required this.imagesUrl});

  final List imagesUrl;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(height: 400.0),
      items: imagesUrl.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              decoration: BoxDecoration(
                  color: Colors.amber,
                  border: Border.all(width: 2, color: AlImran.baseColor)),
              child: Image(
                image: NetworkImage(
                  i,
                ),
                fit: BoxFit.cover,
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
