import 'package:al_imran/constants/app_consts.dart';
import 'package:flutter/material.dart';

class MyCustomButton extends StatelessWidget {
  const MyCustomButton({super.key, required this.buttonName, this.onPressed});

  final String buttonName;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(15),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          backgroundColor: AlImran.baseColor,
          minimumSize: const Size.fromHeight(50),
        ),
        onPressed: onPressed,
        child: Text(buttonName));
  }
}
