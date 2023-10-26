import 'dart:io';

import 'package:al_imran/constants/app_consts.dart';
import 'package:al_imran/widgets/custom_tile.dart';
import 'package:al_imran/widgets/my_custom_dialouge.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SliderImages extends StatefulWidget {
  const SliderImages({super.key});

  @override
  State<SliderImages> createState() => _SliderImagesState();
}

class _SliderImagesState extends State<SliderImages> {
  String imgUrl = '';
  bool isUploading = false;
  CollectionReference sliderImages =
      FirebaseFirestore.instance.collection('sliderImages');

  Future<void> uploadImg() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    isUploading = true;
    setState(() {});
    if (file == null) return;
    String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference newFolder = referenceRoot.child('sliderImages');

    // Reference imgToUpload = newFolder.child(file.name);

    Reference referenceImgtoUploadFile = newFolder.child(uniqueFileName);
    try {
      await referenceImgtoUploadFile.putFile(File(file.path));
      imgUrl = await referenceImgtoUploadFile.getDownloadURL();
      sliderImages.doc(uniqueFileName).set({
        'url': imgUrl,
      });
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) {
            return const MyCustomDialouge(
                alertIcon: Icon(Icons.done, size: 50, color: Colors.green),
                alertTitle: 'Image has been uploaded successfully');
          });

      isUploading = false;
      setState(() {});
    } catch (e) {
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (context) {
            return const MyCustomDialouge(
                alertTitle: 'Network Failed',
                alertIcon: Icon(Icons.cancel, size: 50, color: Colors.red));
          });
    }
  }

  deleteImg(imgName) async {
    final imgToDelete =
        FirebaseStorage.instance.ref().child("sliderImages/$imgName");
    await imgToDelete.delete();
    await FirebaseFirestore.instance
        .collection('sliderImages')
        .doc(imgName)
        .delete()
        .then((value) => showDialog(
            context: context,
            builder: (context) {
              return const MyCustomDialouge(
                  alertTitle: 'Image has been deleted successfully',
                  alertIcon: Icon(Icons.delete_forever));
            }));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                backgroundColor: AlImran.baseColor,
                title: const Text('Slider Images')),
            body: Container(
                padding: const EdgeInsets.all(5),
                child: Column(children: [
                  InkWell(
                      onTap: uploadImg,
                      child: Container(
                          decoration: BoxDecoration(
                              color: AlImran.secondaryColor,
                              borderRadius: BorderRadius.circular(45)),
                          padding: const EdgeInsets.all(25),
                          width: double.infinity,
                          height: 200,
                          child: isUploading
                              ? Visibility(
                                  visible: isUploading,
                                  child: const CircularProgressIndicator())
                              : const Icon(Icons.add_a_photo, size: 100))),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('sliderImages')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Expanded(
                              child: ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    return CustomTile(
                                      imgId: snapshot.data!.docs[index].id,
                                      imgUrl: snapshot.data!.docs[index]['url'],
                                      delIcon: IconButton(
                                        onPressed: () {
                                          deleteImg(
                                              snapshot.data!.docs[index].id);
                                        },
                                        icon: const Icon(Icons.delete),
                                        color: Colors.red,
                                      ),
                                    );
                                  }));
                        }
                        return const CircularProgressIndicator();
                      })
                ]))));
  }
}
