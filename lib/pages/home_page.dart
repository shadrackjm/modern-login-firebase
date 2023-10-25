// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser;
  void SignUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: SignUserOut, icon: Icon(Icons.logout))
          ],
        ),
        body: Center(
          child: Text(
            "Logged In As: " + user!.email!,
            style: TextStyle(fontSize: 20),
          ),
        ));
  }
}
