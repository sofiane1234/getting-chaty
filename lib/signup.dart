import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final pseudoController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(title: Text('Getting Chaty (Logged ' + (user == null ? 'out)':'in)'),
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),),
      backgroundColor: Colors.cyanAccent,
      body:  Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Addresse Email',
                hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,)
              ),
              controller: emailController,
              style: TextStyle(fontSize: 19),
            ),

            TextFormField(
              decoration: InputDecoration(
                hintText: 'Pseudo',
                hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,)
              ),
              controller: pseudoController,
              style: TextStyle(fontSize: 19),
            ),

            TextFormField(
              decoration: InputDecoration(
                hintText: 'Mot de passe',
                hintStyle: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              controller: passwordController,
              obscureText: true,
              style: TextStyle(fontSize: 19),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(child: Text('SignUn'),
                  onPressed: () async{
                    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text,
                        password: passwordController.text);
                    setState(() {});
                  }, ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
