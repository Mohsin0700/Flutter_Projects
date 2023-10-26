import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GetUserName extends StatelessWidget {
  const GetUserName({super.key});
  @override
  Widget build(BuildContext context) {
    final User user = FirebaseAuth.instance.currentUser!;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    // return Text(user);
    return Column(
      children: [
        FutureBuilder(
            future: users.doc(user.uid).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text("Something went wrong");
              }

              if (snapshot.hasData && !snapshot.data!.exists) {
                return const Text("Document does not exist");
              }

              if (snapshot.connectionState == ConnectionState.done) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
                return Text(
                  "Hello ${data['username']}  \n your email is ${data['email']}",
                  style: const TextStyle(fontSize: 30),
                );
              }

              return const CircularProgressIndicator();
            }),
      ],
    );
  }
}
