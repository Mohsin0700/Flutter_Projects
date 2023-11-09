import 'package:devathonesmit/consts/consts.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField(
      {super.key,
      this.topLeft,
      this.topRight,
      this.bottomLeft,
      this.bottomRight,
      required this.hintText,
      required this.myIcon,
      required this.obsecureText,
      required this.myController,
      required this.label});

  final double? topLeft;
  final double? topRight;
  final double? bottomLeft;
  final double? bottomRight;
  final String hintText;
  final IconButton myIcon;
  final bool obsecureText;
  final String label;
  final TextEditingController myController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: myController,
      obscureText: obsecureText,
      decoration: InputDecoration(
        focusColor: AppColors.textFieldFocusedColor,
        label: Text(label),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.textFieldBorderColor)),
        suffixIcon: myIcon,
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        border: OutlineInputBorder(
            borderSide: const BorderSide(width: 1),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(topLeft ?? 0),
              topRight: Radius.circular(topRight ?? 0),
              bottomLeft: Radius.circular(bottomLeft ?? 0),
              bottomRight: Radius.circular(bottomRight ?? 0),
            )),
      ),
    );
  }
}
