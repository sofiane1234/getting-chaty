import 'package:chatyap/firebaseHelper.dart';
import 'package:chatyap/signup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Service service = Service();

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(title: Text('Getting Chaty Connexion',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),),
      backgroundColor: Colors.greenAccent,
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Addresse Email',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)
                  ),
                hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
              ),
              controller: emailController,
              style: TextStyle(fontSize: 19),
            ),
            Padding(padding: EdgeInsets.symmetric(vertical: 5)),
            TextFormField(controller: passwordController,
              decoration: InputDecoration(
                  hintText: 'Mot de passe',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),
                  hintStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,)
              ),
              obscureText: true,
              style: TextStyle(fontSize: 19),
            ),

            Container(
              alignment: Alignment.centerRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                child: TextButton(onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => SignUp())));
                }, child: Text('Inscription ici !'),),
              ),
              padding: EdgeInsets.symmetric(vertical: 10),
            ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () {
                if(emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
                  service.signInAccount(context, emailController.text, passwordController.text);
                } else {
                  service.error(context, "Veuillez remplir tous les champs !");
                }
              },
                  child: Text('Se Connecter')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
