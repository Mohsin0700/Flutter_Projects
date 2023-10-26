import 'package:al_imran/constants/app_consts.dart';
import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final String imgUrl;
  final String imgId;
  final IconButton delIcon;
  const CustomTile(
      {super.key,
      required this.imgUrl,
      required this.delIcon,
      required this.imgId});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AlImran.secondaryColor,
          borderRadius: BorderRadius.circular(45),
          border: Border.all(width: 1, color: AlImran.baseColor)),
      margin: const EdgeInsets.only(top: 3),
      child: ListTile(
          leading: SizedBox(
            height: 50,
            width: 50,
            child: Image(
              image: NetworkImage(imgUrl),
              width: 75,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(imgId),
          trailing: delIcon),
    );
  }
}
