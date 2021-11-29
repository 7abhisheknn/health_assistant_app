import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_assistant_app/pages/chart_page.dart';
import 'package:health_assistant_app/pages/doctor_chart_page.dart';
import 'package:health_assistant_app/widgets/chat/chat.dart';
import 'package:health_assistant_app/widgets/chat/new_message.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String name;
  final String image;
  final String? doc_id;
  const ChatScreen(
      {required this.chatId,
      Key? key,
      required this.name,
      required this.image,
      required this.doc_id})
      : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          Row(
            children: [
              if (widget.doc_id != null)
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DoctorChart(
                                doc_id: widget.doc_id!,
                                name: widget.name,
                                image: widget.name,
                              )),
                    );
                  },
                  child: const Icon(Icons.auto_graph),
                ),
              Expanded(child: NewMessage(chatId: widget.chatId)),
            ],
          ),
        ],
      ),
    );
  }
}
