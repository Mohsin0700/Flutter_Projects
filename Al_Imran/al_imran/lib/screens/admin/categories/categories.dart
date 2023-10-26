import 'dart:io';

import 'package:al_imran/constants/app_consts.dart';
import 'package:al_imran/widgets/custom_tile.dart';
import 'package:al_imran/widgets/my_custom_dialouge.dart';
import 'package:al_imran/widgets/my_custom_progress_indicator.dart';
import 'package:al_imran/widgets/my_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  bool isUploading = false;
  String imgUrl = '';
  CollectionReference categoriesRoot =
      FirebaseFirestore.instance.collection('categories');

  Reference referenceRoot = FirebaseStorage.instance.ref();

  TextEditingController categoryNameController = TextEditingController();
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _image;

  Future<void> pickImage() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void deleteImage() {
    _image = null;
    setState(() {});
  }

  delCategory(imgName) async {
    final imgToDelete =
        FirebaseStorage.instance.ref().child("categories/$imgName");
    await imgToDelete.delete();
    await FirebaseFirestore.instance
        .collection('categories')
        .doc(imgName)
        .delete()
        .then((value) => showDialog(
            context: context,
            builder: (context) {
              return const MyCustomDialouge(
                  alertTitle: 'Category has been deleted',
                  alertIcon: Icon(Icons.delete));
            }));
  }

  addCategory() async {
    if (_image != null) {
      isUploading = true;
      setState(() {});
      if (_image == null) return;
      String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();
      Reference referenceImageToUpload =
          referenceRoot.child('categories').child(uniqueFileName);
      try {
        await referenceImageToUpload.putFile(File(_image!.path));
        imgUrl = await referenceImageToUpload.getDownloadURL();
        categoriesRoot
            .doc(uniqueFileName)
            .set({'name': categoryNameController.text, 'url': imgUrl});

        _image = null;
        categoryNameController.clear();
        isUploading = false;
        setState(() {});
        // ignore: use_build_context_synchronously
        showDialog(
            context: context,
            builder: (context) {
              return const MyCustomDialouge(
                alertTitle: 'Category added successfully',
                alertIcon: Icon(Icons.done, size: 50, color: Colors.green),
              );
            });
      } catch (e) {
        String error = e.toString();
        MyCustomDialouge(
          alertIcon: const Icon(Icons.cancel_outlined),
          alertTitle: error,
        );
      }
    } else {
      showDialog(
          context: context,
          builder: ((context) => const MyCustomDialouge(
                alertIcon: Icon(Icons.warning_amber),
                alertTitle: 'Please select an image',
              )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: AlImran.baseColor,
              centerTitle: true,
              title: const Text('Add Category'),
            ),
            body: isUploading
                ? const MyCustomProgressIndicator(
                    indicatorTitle: 'createing category')
                : Container(
                    padding: const EdgeInsets.all(5),
                    child: Column(children: [
                      InkWell(
                          onTap: pickImage,
                          child: Container(
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                  color: AlImran.secondaryColor,
                                  borderRadius: BorderRadius.circular(45)),
                              width: double.infinity,
                              height: 200,
                              child: _image == null
                                  ? const SizedBox(
                                      width: double.infinity,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.add_a_photo_outlined,
                                                size: 100),
                                            Text('Add Category Photo here!')
                                          ]))
                                  : Stack(children: [
                                      SizedBox(
                                          width: double.infinity,
                                          child: Image.file(File(_image!.path),
                                              fit: BoxFit.cover)),
                                      Positioned(
                                          right: 10,
                                          child: IconButton(
                                              onPressed: deleteImage,
                                              icon: const Icon(
                                                  Icons.delete_forever,
                                                  color: Colors.red,
                                                  size: 50)))
                                    ]))),
                      MyTextField(
                          topLeft: 45,
                          bottomLeft: 45,
                          bottomRight: 45,
                          topRight: 45,
                          hintText: 'Category Name',
                          myIcon: IconButton(
                              onPressed: addCategory,
                              icon: const Icon(Icons.add_circle),
                              iconSize: 50,
                              color: AlImran.baseColor),
                          obsecureText: false,
                          myController: categoryNameController),
                      const SizedBox(
                        height: 10,
                      ),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('categories')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Expanded(
                              child: ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  return CustomTile(
                                    imgId: snapshot.data!.docs[index]['name'],
                                    imgUrl: snapshot.data!.docs[index]['url'],
                                    delIcon: IconButton(
                                      onPressed: () {
                                        delCategory(
                                            snapshot.data!.docs[index].id);
                                      },
                                      icon: const Icon(Icons.delete),
                                      color: Colors.red,
                                    ),
                                  );
                                },
                              ),
                            );
                          }
                          return const CircularProgressIndicator();
                        },
                      ),
                    ]))));
  }
}
