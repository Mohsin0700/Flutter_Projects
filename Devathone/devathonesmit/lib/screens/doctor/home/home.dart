import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:devathonesmit/consts/consts.dart';
import 'package:devathonesmit/screens/widgets/my_customheader.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class DoctorHome extends StatefulWidget {
  const DoctorHome({super.key});

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  bool isSigningOut = false;

  signUserOut() async {
    isSigningOut = true;
    bool isLoggedIn = false;

    setState(() {});
    await FirebaseAuth.instance.signOut();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
    await prefs.setBool('isAdmin', false);
    setState(() {});
    // ignore: use_build_context_synchronously
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    bool isSigningOut = false;
    bool isLoggedIn = false;

    // Future<void> deleteItem(itemToDelete) async {
    //   for (var item in itemToDelete['imagesName']) {
    //     final imgToDelete =
    //         FirebaseStorage.instance.ref().child("itemPics/$item");
    //     await imgToDelete.delete();
    //   }
    //   await FirebaseFirestore.instance
    //       .collection('all_items')
    //       .doc(itemToDelete.id)
    //       .delete()
    //       .then((value) => showDialog(
    //           context: context,
    //           builder: (context) {
    //             return const MyCustomDialouge(
    //                 alertTitle: 'Item has been deleted successfully',
    //                 alertIcon: Icon(Icons.delete_forever, color: Colors.red));
    //           }));
    // }

    signUserOut() async {
      isSigningOut = true;
      setState(() {});
      await FirebaseAuth.instance.signOut();
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', isLoggedIn);
      await prefs.setBool('isAdmin', false);
      setState(() {});
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/login');
    }

    return SafeArea(
        child: Scaffold(
            body: isSigningOut
                ? const CircularProgressIndicator()
                : Column(children: [
                    MyCustomHeader(
                      pageTitle: 'Doctor Homepage',
                      onPressed: () {
                        signUserOut();
                      },
                    ),
                    const Text('This is doctor homepage'),
                    // StreamBuilder(
                    //     stream: FirebaseFirestore.instance
                    //         .collection('users')
                    //         .snapshots(),
                    //     builder: ((context, AsyncSnapshot snapshot) {
                    //       if (snapshot.hasData) {
                    //         return Expanded(
                    //             child: ListView.builder(
                    //                 shrinkWrap: true,
                    //                 physics:
                    //                     const NeverScrollableScrollPhysics(),
                    //                 // itemCount: snapshot.data!.docs.length,
                    //                 itemCount: 10,
                    //                 itemBuilder: (context, index) {
                    //                   return Container(
                    //                       margin: const EdgeInsets.only(top: 5),
                    //                       child: ListTile(
                    //                           leading: ClipRRect(
                    //                               borderRadius:
                    //                                   BorderRadius.circular(45),
                    //                               child: const Image(
                    //                                   image: AssetImage(
                    //                                       'assets/images/logo.png')
                    //                                   // NetworkImage(
                    //                                   //     snapshot.data.docs[
                    //                                   //                 index]
                    //                                   //             ['itemImages']
                    //                                   //         [0]),
                    //                                   ,
                    //                                   height: 50,
                    //                                   width: 50)),
                    //                           tileColor: AppColors.buttonColor,
                    //                           title: Text(
                    //                             snapshot.data!.docs[index]
                    //                                 ['itemName'],
                    //                           ),
                    //                           subtitle: Text(
                    //                               '${snapshot.data!.docs[index]['itemCategory']}'),
                    //                           trailing: Wrap(children: [
                    //                             Container(
                    //                                 margin:
                    //                                     const EdgeInsets.only(
                    //                                         top: 10),
                    //                                 child: IconButton(
                    //                                     onPressed: () {
                    //                                       // deleteItem(snapshot
                    //                                       // .data!
                    //                                       // .docs[index]);
                    //                                     },
                    //                                     color: Colors.red,
                    //                                     icon: const Icon(
                    //                                         Icons.delete)))
                    //                           ])));
                    //                 }));
                    //       }
                    //       return const Icon(Icons.hourglass_empty);
                    //     }))
                  ])));
  }
}
