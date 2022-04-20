import 'package:chatyap/firebaseHelper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login.dart';

var loginUser = FirebaseAuth.instance.currentUser;

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Service service = Service();
  final auth = FirebaseAuth.instance;
  getCurrentUser() {
    final user = auth.currentUser;
    if(user != null) {
      loginUser = user;
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

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
          Container(
            height: 308,
            child: AffichMsg()
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.green,
                        width: 0.5,
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
                        "time":DateTime.now(),
                      });
                      msg.clear();
                    }
                  },
                    icon: Icon(Icons.send,
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
      stream: FirebaseFirestore.instance.collection("Messages").orderBy("time").snapshots(),
      builder: (context, snapshot){
        if(!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
            reverse: true,
            itemCount: snapshot.data!.docs.length,
            shrinkWrap: true,
            primary: true,
            physics: ScrollPhysics(),
            itemBuilder: (context,i){
              QueryDocumentSnapshot query = snapshot.data!.docs[i];
              return ListTile(
                title: Column(
                  crossAxisAlignment: loginUser!.email == query['user']
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: loginUser!.email == query['user']
                            ? Colors.green.withOpacity(0.5)
                            : Colors.cyanAccent.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(query['messages']),
                          SizedBox(
                            height: 7,
                          ),
                          Text('De : ' + query['user'],
                          style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            );
        },
    );
  }
}
