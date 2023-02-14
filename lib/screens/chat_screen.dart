import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WeChat"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('/Chats/7U0cC2FdmncEnE4mPncy/messages/')
            .snapshots(),
        builder: (ctx, snapShotStream) {
          if (snapShotStream.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemBuilder: (ctx, index) => Container(
              child: Text(snapShotStream.data!.docs[index]['text']),
            ),
            itemCount: snapShotStream.data!.docs.length,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        FirebaseFirestore.instance
            .collection('/Chats/7U0cC2FdmncEnE4mPncy/messages/')
            .add({'text': "Another one Added"});
      }),
    );
  }
}
