import 'package:flutter/material.dart';
import 'package:health_assistant_app/widgets/chart/chart_bar.dart';

class ChatPage extends StatefulWidget {
  String id;
  ChatPage({Key? key, required this.id}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ChartBar(
        label: 'HI',
        spendingAmount: 150,
        spendingPctOfTotal: 0.9,
      ),
    );
  }
}
