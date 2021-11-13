import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  final String chatId;
  const NewMessage({required this.chatId, Key? key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  String _enteredMessage = '';

  Future<void> _sendMessage() async {
    FocusScope.of(context).unfocus();
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final userData =
        await FirebaseFirestore.instance.collection('user').doc(uid).get();

    FirebaseFirestore.instance
        .collection('all_chats')
        .doc(widget.chatId)
        .collection('chat')
        .add({
      'text': _enteredMessage,
      'createdAt': Timestamp.now(),
      'userId': uid,
      'username': userData['username'],
      'userImage': userData['image_url']
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _controller,
            onChanged: (value) {
              setState(() {
                _enteredMessage = value;
              });
            },
            decoration: const InputDecoration(label: Text('Send a message...')),
          )),
          IconButton(
              onPressed: _enteredMessage.trim().isEmpty ? null : _sendMessage,
              icon: const Icon(Icons.send))
        ],
      ),
    );
  }
}
