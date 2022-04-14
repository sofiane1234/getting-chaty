import 'package:chatyap/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'home.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(title: Text('Getting Chaty (Logged ' + (user == null ? 'out)':'in)'),
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),),
      backgroundColor: Colors.cyanAccent,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Addresse Email',
                hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
              ),
              controller: emailController,
              style: TextStyle(fontSize: 19),
            ),
            TextFormField(controller: passwordController,
              decoration: InputDecoration(
                  hintText: 'Mot de passe',
                  hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
              ),
              obscureText: true,
              style: TextStyle(fontSize: 19),
            ),

            Container(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Text('Mot de passe oublié?'),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                ElevatedButton(child: Text('Signin'),
                  onPressed: () async{
                  await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text,
                      password: passwordController.text);
                  setState(() {
                   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
                  });
                  }, ),

                ElevatedButton(child: Text('Logout'),
                  onPressed: () async{
                  await FirebaseAuth.instance.signOut();
                  setState(() {});
                  },
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
