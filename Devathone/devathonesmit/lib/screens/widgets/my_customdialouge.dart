import 'package:devathonesmit/consts/consts.dart';
import 'package:flutter/material.dart';

class MyCustomDialouge extends StatelessWidget {
  final String alertTitle;
  final Icon alertIcon;

  const MyCustomDialouge(
      {super.key, required this.alertTitle, required this.alertIcon});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        backgroundColor: AppColors.buttonColor,
        icon: alertIcon,
        title: Text(alertTitle));
  }
}
