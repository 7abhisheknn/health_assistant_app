import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_assistant_app/widgets/chat/chat_bubble.dart';

class Chat extends StatefulWidget {
  final String chatId;
  const Chat({required this.chatId, Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('all_chats')
            .doc(widget.chatId)
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, chatSnapshot) {
          if (chatSnapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            reverse: true,
            itemCount: chatSnapshot.data!.docs.length,
            itemBuilder: (ctx, i) => Container(
              padding: const EdgeInsets.all(8),
              // child: Text(chatSnapshot.data!.docs[i]['text']),
              child: ChatBubble(
                message: chatSnapshot.data!.docs[i]['text'],
                isMe: chatSnapshot.data!.docs[i]['id'] ==
                    FirebaseAuth.instance.currentUser!.uid,
                key: ValueKey(chatSnapshot.data!.docs[i].id),
                username: chatSnapshot.data!.docs[i]['name'],
                userImage: chatSnapshot.data!.docs[i]['image'],
              ),
            ),
          );
        },
      ),
    );
  }
}
