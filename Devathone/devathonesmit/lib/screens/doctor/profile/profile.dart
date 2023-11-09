import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devathonesmit/consts/consts.dart';
import 'package:devathonesmit/screens/doctor/profile/widgets/profile_image.dart';
import 'package:devathonesmit/screens/widgets/custom_textfield.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class DoctorProfile extends StatefulWidget {
  const DoctorProfile({super.key});

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  List<String> itemImages = [];
  List<String> itemImagesName = [];
  String imgUrl = '';
  bool isItemUploading = false;
  TextEditingController professionController = TextEditingController();
  TextEditingController itemPriceController = TextEditingController();
  Reference firebaseStorageReferenceRoot = FirebaseStorage.instance.ref();

  CollectionReference allItems =
      FirebaseFirestore.instance.collection('all_items');

  // Future<void> DoctorProfile() async {
  //   if (DoctorProfileConst.selectedCategory == '0' ||
  //       itemNameController.text == '' ||
  //       DoctorProfileConst.images.isEmpty) {
  //     return showDialog(
  //         context: context,
  //         builder: (context) {
  //           return const MyCustomDialouge(
  //               alertTitle: 'Fill All The Fields',
  //               alertIcon: Icon(Icons.swipe_up_alt));
  //         });
  //   }
  //   isItemUploading = true;
  //   setState(() {});
  //   String uniqueId = DateTime.now().microsecondsSinceEpoch.toString();

  //   // String imgId = DateTime.now().microsecondsSinceEpoch.toString();

  //   for (var image in DoctorProfileConst.images) {
  //     String imgId = DateTime.now().microsecondsSinceEpoch.toString();
  //     Reference imageToBeUploaded =
  //         firebaseStorageReferenceRoot.child('itemPics').child(imgId);
  //     try {
  //       await imageToBeUploaded.putFile(File(image.path));
  //       imgUrl = await imageToBeUploaded.getDownloadURL();
  //       itemImages.add(imgUrl);
  //       itemImagesName.add(imgId);
  //     } catch (e) {
  //       // ignore: avoid_print
  //       print(e.toString());
  //     }
  //   }

  //   allItems.doc(uniqueId).set({
  //     'itemName': itemNameController.text,
  //     'itemCategory': DoctorProfileConst.selectedCategory,
  //     'itemImages': itemImages,
  //     'imagesName': itemImagesName,
  //     'itemPrice': itemPriceController.text
  //   }).then((value) {
  //     itemNameController.clear();
  //     isItemUploading = false;
  //     DoctorProfileConst.images.clear();
  //     itemImagesName.clear();
  //     setState(() {
  //       DoctorProfileConst.selectedCategory = '0';
  //     });
  //     return showDialog(
  //         context: context,
  //         builder: (context) {
  //           return const MyCustomDialouge(
  //               alertTitle: 'Items has been added successfully',
  //               alertIcon: Icon(Icons.done));
  //         });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: AppColors.buttonColor,
            title: const Text('Profile'),
            centerTitle: true),
        body: isItemUploading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(15),
                    child: Column(children: [
                      const ProfilePicture(),
                      const SizedBox(
                        height: 20,
                      ),
                      MyTextField(
                          hintText: 'Enter Your Profession',
                          myIcon: IconButton(
                              onPressed: () {}, icon: Icon(Icons.abc)),
                          obsecureText: false,
                          myController: professionController,
                          label: 'Profession')
                    ])),
              ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.buttonColor,
          onPressed: () {},
          child: const Icon(Icons.add),
        ));
  }
}
