import 'package:al_imran/constants/app_consts.dart';
import 'package:flutter/material.dart';

class MyCustomHeader extends StatelessWidget {
  final void Function()? onPressed;
  final String pageTitle;
  const MyCustomHeader({super.key, this.onPressed, required this.pageTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AlImran.baseColor,
        height: 50,
        child: Stack(children: [
          SizedBox(
            width: double.infinity,
            child: Center(
                child: Text(pageTitle, style: const TextStyle(fontSize: 20))),
          ),
          Positioned(
              left: 0,
              child: RotatedBox(
                quarterTurns: 2,
                child: IconButton(
                    onPressed: onPressed,
                    icon: const Icon(
                      Icons.logout,
                    )),
              ))
        ]));
  }
}
