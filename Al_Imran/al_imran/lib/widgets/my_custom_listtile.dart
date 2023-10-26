import 'package:flutter/material.dart';

class MyCustomListTile extends StatelessWidget {
  final String customTitle;
  final Icon customIcon;
  final String namedRout;
  const MyCustomListTile(
      {super.key,
      required this.customTitle,
      required this.customIcon,
      required this.namedRout});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white70,
        child: ListTile(
            onTap: () => Navigator.pushNamed(context, namedRout),
            leading: customIcon,
            title: Text(customTitle),
            trailing: const Icon(Icons.keyboard_double_arrow_right_sharp)));
  }
}
