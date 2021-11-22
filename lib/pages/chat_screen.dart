import 'package:flutter/material.dart';
import 'package:health_assistant_app/widgets/chat/chat.dart';
import 'package:health_assistant_app/widgets/chat/new_message.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String name;
  final String image;
  const ChatScreen(
      {required this.chatId, Key? key, required this.name, required this.image})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: CircleAvatar(
        //   backgroundImage: NetworkImage(widget.image),
        // ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.image),
            ),
            const SizedBox(width: 20),
            Text(widget.name),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(child: Chat(chatId: widget.chatId)),
          NewMessage(chatId: widget.chatId),
        ],
      ),
    );
  }
}
