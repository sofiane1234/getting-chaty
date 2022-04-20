import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class Service {
  final auth = FirebaseAuth.instance;

  void createAccount(context, email, password) async{
    try{
      await auth.createUserWithEmailAndPassword(email: email, password: password).then((value) => {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()))
      });
    } catch(e) {
      error(context, e);
    }
  }

  void signInAccount(context, email, password) async{
    try{
      await auth.signInWithEmailAndPassword(email: email, password: password).then((value) => {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Home()))
      });
    } catch(e) {
      error(context, e);
    }
  }

  void error(context, e) {
    showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text('Oops !'),
        content: Text(e.toString()),
      );
    });
  }
}

