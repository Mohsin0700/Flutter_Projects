import 'package:al_imran/constants/app_consts.dart';
import 'package:al_imran/widgets/my_custom_dialouge.dart';
import 'package:al_imran/widgets/my_custom_header.dart';
import 'package:al_imran/widgets/my_custom_progress_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    bool isSigningOut = false;
    bool isLoggedIn = false;

    Future<void> deleteItem(itemToDelete) async {
      for (var item in itemToDelete['imagesName']) {
        final imgToDelete =
            FirebaseStorage.instance.ref().child("itemPics/$item");
        await imgToDelete.delete();
      }
      await FirebaseFirestore.instance
          .collection('all_items')
          .doc(itemToDelete.id)
          .delete()
          .then((value) => showDialog(
              context: context,
              builder: (context) {
                return const MyCustomDialouge(
                    alertTitle: 'Item has been deleted successfully',
                    alertIcon: Icon(Icons.delete_forever, color: Colors.red));
              }));
    }

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
                ? const MyCustomProgressIndicator(indicatorTitle: 'Signing Out')
                : Column(children: [
                    MyCustomHeader(
                        pageTitle: 'All Items', onPressed: signUserOut),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('all_items')
                            .snapshots(),
                        builder: ((context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData) {
                            return Expanded(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                          margin: const EdgeInsets.only(top: 5),
                                          child: ListTile(
                                              leading: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(45),
                                                  child: Image(
                                                      image: NetworkImage(snapshot
                                                              .data.docs[index]
                                                          ['itemImages'][0]),
                                                      height: 50,
                                                      width: 50)),
                                              tileColor: AlImran.secondaryColor,
                                              title: Text(
                                                  snapshot.data!.docs[index]
                                                      ['itemName'],
                                                  style:
                                                      AlImran.regularTextStyle),
                                              subtitle: Text(
                                                  '${snapshot.data!.docs[index]['itemCategory']}'),
                                              trailing: Wrap(children: [
                                                Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 25, right: 5),
                                                  child: Text(
                                                      'PKR ${snapshot.data!.docs[index]['itemPrice']}/-'),
                                                ),
                                                Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 10),
                                                    child: IconButton(
                                                        onPressed: () {
                                                          deleteItem(snapshot
                                                              .data!
                                                              .docs[index]);
                                                        },
                                                        color: Colors.red,
                                                        icon: const Icon(
                                                            Icons.delete)))
                                              ])));
                                    }));
                          }
                          return const Icon(Icons.hourglass_empty);
                        }))
                  ])));
  }
}
