import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:health_assistant_app/pages/chat_screen.dart';
import 'package:health_assistant_app/widgets/chat/chat.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Stream<QuerySnapshot> _myChats = FirebaseFirestore.instance
      .collection('patient')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('my_chats')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _myChats,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ChatScreen(
                          chatId: data['chat_id'],
                          name: data['name'],
                          image: data['image'])),
                );
              },
              leading: CircleAvatar(
                backgroundImage: NetworkImage(data['image']),
              ),
              title: Text(data['name']),
            );
          }).toList(),
        );
      },
    );
  }
}
