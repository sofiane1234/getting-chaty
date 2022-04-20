import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login.dart';
var loginUser = FirebaseAuth.instance.currentUser;

class Home extends StatefulWidget {
  final auth = FirebaseAuth.instance;
  getCurrentUser() {
    final user = auth.currentUser;
    if(user != null) {
      loginUser = user;
    }
  }
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final storeMsg = FirebaseFirestore.instance;

  TextEditingController msg = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(loginUser!.email.toString()),
        elevation: 0,
        actions: [
          IconButton(onPressed: () async => {
            await FirebaseAuth.instance.signOut(),
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Login()))},
              icon: Icon(Icons.logout,
              color: Colors.cyanAccent,)
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,

        children: [
          Text("Discussions", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
          AffichMsg(),
          Row(children: [
            Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.green,
                        width: 2.5,
                      ),
                    ),
                  ),
              child: TextField(
                controller: msg,
                decoration: InputDecoration(
                  hintText: "Ecrire un message...",
                  hintStyle: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ),
            IconButton(onPressed: (){
              if (msg.text.isNotEmpty) {
                storeMsg.collection("Messages").doc().set({
                  "messages":msg.text.trim(),
                  "user":loginUser!.email.toString(),
                });
                msg.clear();
              }
            }, icon: Icon(Icons.send,
              color: Colors.redAccent,),)
          ],
          ),

        ],
      ),
    );
  }
}
class AffichMsg extends StatefulWidget {
  const AffichMsg({Key? key}) : super(key: key);

  @override
  State<AffichMsg> createState() => _AffichMsgState();
}

class _AffichMsgState extends State<AffichMsg> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("Messages").snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            primary: true,
            itemBuilder: (context,i){
              QueryDocumentSnapshot query = snapshot.data!.docs[i];
              return ListTile(
                title: Text(query['messages']),
              );
            });
        },
    );
  }
}
