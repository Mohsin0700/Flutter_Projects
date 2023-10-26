import 'package:al_imran/constants/app_consts.dart';
import 'package:flutter/material.dart';

class MyCustomProgressIndicator extends StatelessWidget {
  final String indicatorTitle;
  const MyCustomProgressIndicator({super.key, required this.indicatorTitle});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      padding: const EdgeInsets.only(left: 10),
      height: 50,
      width: 210,
      color: AlImran.secondaryColor,
      child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircularProgressIndicator(color: AlImran.baseColor),
            const SizedBox(width: 15),
            Text(indicatorTitle)
          ]),
    ));
  }
}
