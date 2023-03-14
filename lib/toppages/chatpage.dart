import "package:flutter/material.dart";
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/userclass/shareclass.dart';

class ChatPage extends StatefulWidget {
  final UserClass myUser;
  const ChatPage({required this.myUser,super.key});
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Chats").where("members",arrayContains: widget.myUser.ID).snapshots(),
        builder: (context, snapshot) {
          debugPrint("Kod burada");
          var data=snapshot.data!.docs;
          String data2=data[0].toString();
            return ListView(
            children: [
              ListTile(title: Text("aaa"+data2.toString())),
            ]
     
            );
        },
      )
    );
  }
}