import 'dart:io';

import 'package:devathonesmit/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key});

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  final ImagePicker _imagePicker = ImagePicker();
  // ignore: unused_field
  XFile? _image;

  Future<void> pickImage() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      AppImages.profileImage = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
            onTap: pickImage,
            child: AppImages.profileImage == null
                ? Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: BoxDecoration(
                        color: const Color(0xffD9D9D9),
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
                              Text('Add Profile Photo here!')
                            ])))
                : Stack(children: [
                    Container(
                      height: 150,
                      width: double.infinity,
                      child: Image.file(
                        File(AppImages.profileImage!.path),
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Positioned(
                      right: 0,
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    )
                  ])),
      ],
    );
  }
}
