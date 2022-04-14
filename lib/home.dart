import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

import 'login.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Geting Chaty"),
        actions: [
          IconButton(onPressed: () async => {
            await FirebaseAuth.instance.signOut(),
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()))},
              icon: Icon(CupertinoIcons.back,
              color: Colors.deepPurpleAccent,)),

        ],
      ),
      body: Center(
        child: Text('HomePage'),
      ),
    );
  }
}
