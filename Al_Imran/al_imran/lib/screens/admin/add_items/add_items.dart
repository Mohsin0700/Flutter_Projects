import 'dart:io';

import 'package:al_imran/constants/app_consts.dart';
import 'package:al_imran/screens/admin/add_items/widgets/add_items_consts.dart';
import 'package:al_imran/screens/admin/add_items/widgets/category_builder.dart';
import 'package:al_imran/screens/admin/add_items/widgets/item_images.dart';
import 'package:al_imran/widgets/my_custom_dialouge.dart';
import 'package:al_imran/widgets/my_custom_progress_indicator.dart';
import 'package:al_imran/widgets/my_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  List<String> itemImages = [];
  List<String> itemImagesName = [];
  String imgUrl = '';
  bool isItemUploading = false;
  TextEditingController itemNameController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();
  Reference firebaseStorageReferenceRoot = FirebaseStorage.instance.ref();

  CollectionReference allItems =
      FirebaseFirestore.instance.collection('all_items');

  Future<void> addItem() async {
    if (AddItemConst.selectedCategory == '0' ||
        itemNameController.text == '' ||
        AddItemConst.images.isEmpty) {
      return showDialog(
          context: context,
          builder: (context) {
            return const MyCustomDialouge(
                alertTitle: 'Fill All The Fields',
                alertIcon: Icon(Icons.swipe_up_alt));
          });
    }
    isItemUploading = true;
    setState(() {});
    String uniqueId = DateTime.now().microsecondsSinceEpoch.toString();

    // String imgId = DateTime.now().microsecondsSinceEpoch.toString();

    for (var image in AddItemConst.images) {
      String imgId = DateTime.now().microsecondsSinceEpoch.toString();
      Reference imageToBeUploaded =
          firebaseStorageReferenceRoot.child('itemPics').child(imgId);
      try {
        await imageToBeUploaded.putFile(File(image.path));
        imgUrl = await imageToBeUploaded.getDownloadURL();
        itemImages.add(imgUrl);
        itemImagesName.add(imgId);
      } catch (e) {
        // ignore: avoid_print
        print(e.toString());
      }
    }

    allItems.doc(uniqueId).set({
      'itemName': itemNameController.text,
      'itemCategory': AddItemConst.selectedCategory,
      'itemImages': itemImages,
      'imagesName': itemImagesName,
      'itemPrice': itemPriceController.text
    }).then((value) {
      itemNameController.clear();
      isItemUploading = false;
      AddItemConst.images.clear();
      itemImagesName.clear();
      setState(() {
        AddItemConst.selectedCategory = '0';
      });
      return showDialog(
          context: context,
          builder: (context) {
            return const MyCustomDialouge(
                alertTitle: 'Items has been added successfully',
                alertIcon: Icon(Icons.done));
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: AlImran.baseColor,
            title: const Text('Add Item'),
            centerTitle: true),
        body: isItemUploading == true
            ? const Center(
                child: MyCustomProgressIndicator(indicatorTitle: 'Uploading'),
              )
            : SingleChildScrollView(
                child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    child: Column(children: [
                      const Text('Select Category',
                          style: TextStyle(fontSize: 16)),
                      const CategoryBuilder(),
                      const SizedBox(height: 10),
                      const Text('Add Item Name',
                          style: TextStyle(fontSize: 16)),
                      MyTextField(
                          hintText: 'Enter Product Name Here',
                          myIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.abc_outlined,
                                color: AlImran.baseColor),
                          ),
                          obsecureText: false,
                          myController: itemNameController),
                      const Text('Add Item Price',
                          style: TextStyle(fontSize: 16)),
                      MyTextField(
                          hintText: 'Enter Product Price Here',
                          myIcon: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.currency_bitcoin,
                                color: AlImran.baseColor),
                          ),
                          obsecureText: false,
                          myController: itemPriceController),
                      const SizedBox(height: 10),
                      const ItemImages()
                    ])),
              ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AlImran.baseColor,
          onPressed: () {
            addItem();
          },
          child: const Icon(Icons.add),
        ));
  }
}
