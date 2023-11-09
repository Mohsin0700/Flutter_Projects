import 'package:al_imran/constants/app_consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MyCarousel extends StatefulWidget {
  const MyCarousel({super.key});

  @override
  State<MyCarousel> createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  bool isLoading = false;
  CollectionReference sliderImages =
      FirebaseFirestore.instance.collection('sliderImages');

  int imagesLength = 0;

  @override
  Widget build(BuildContext context) {
    List<String> sliderImagesUrl = [];
    final pageController = PageController(viewportFraction: 1.1);
    return FutureBuilder(
        future: sliderImages.get(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            imagesLength = snapshot.data!.docs.length;

            for (var img in snapshot.data!.docs) {
              sliderImagesUrl.add(img['url']);
            }
          }
          return PageView.builder(
              itemCount: sliderImagesUrl.length,
              itemBuilder: (context, index) {
                return FractionallySizedBox(
                  widthFactor: 1 / pageController.viewportFraction,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: AlImran.baseColor,
                      ),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: sliderImagesUrl[index],
                          placeholder: (context, url) =>
                              const Center(child: CircularProgressIndicator()),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        )),
                  ),
                );
              });
        });
  }
}
