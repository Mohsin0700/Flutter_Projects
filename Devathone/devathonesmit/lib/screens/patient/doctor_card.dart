import 'package:devathonesmit/consts/consts.dart';
import 'package:devathonesmit/screens/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class DoctorCard extends StatefulWidget {
  const DoctorCard({super.key});

  @override
  State<DoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 150,
        width: MediaQuery.of(context).size.width * 0.9,
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  child: Image.network(
                    'https://picsum.photos/250?image=9',
                    fit: BoxFit.contain,
                    height: 200,
                    width: 200,
                  ),
                )
              ],
            ),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Dr Name'),
                  SizedBox(
                    height: 10,
                  ),
                  Text('Doc Titile'),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 120,
                    height: 30,
                    child: MyCustomButton(
                      buttonName: 'Appintment',
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
