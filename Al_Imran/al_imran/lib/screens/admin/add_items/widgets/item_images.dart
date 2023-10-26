import 'dart:io';

import 'package:al_imran/constants/app_consts.dart';
import 'package:al_imran/screens/admin/add_items/widgets/add_items_consts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ItemImages extends StatefulWidget {
  const ItemImages({super.key});

  @override
  State<ItemImages> createState() => _ItemImagesState();
}

class _ItemImagesState extends State<ItemImages> {
  final ImagePicker _imagePicker = ImagePicker();
  // ignore: unused_field
  XFile? _image;

  Future<void> pickImage() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      AddItemConst.images.add(image);
    }
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: pickImage,
          child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                  color: AlImran.secondaryColor,
                  borderRadius: BorderRadius.circular(45)),
              width: double.infinity,
              height: 150,
              child: const SizedBox(
                  width: double.infinity,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_a_photo_outlined,
                          size: 100,
                        ),
                        Text('Add Item Photo here!')
                      ]))),
        ),
        GridView.builder(
            itemCount: AddItemConst.images.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 15, crossAxisSpacing: 15, crossAxisCount: 2),
            itemBuilder: (BuildContext context, index) {
              return Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(45)),
                width: 100,
                height: 100,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(45),
                  child: Image.file(
                    File(AddItemConst.images[index].path),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            })
      ],
    );
  }
}
