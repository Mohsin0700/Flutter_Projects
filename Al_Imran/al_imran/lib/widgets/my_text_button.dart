import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final String buttonTitle;
  final String subTitle;
  final String routeName;
  const MyTextButton(
      {super.key,
      required this.buttonTitle,
      required this.subTitle,
      required this.routeName});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => Navigator.pushReplacementNamed(context, routeName),
        child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(buttonTitle),
              Text(subTitle,
                  style: const TextStyle(fontWeight: FontWeight.bold))
            ]));
  }
}
