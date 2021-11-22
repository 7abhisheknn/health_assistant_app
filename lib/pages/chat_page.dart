import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_assistant_app/widgets/chart/chart_card.dart';

// ignore: must_be_immutable
class ChatPage extends StatefulWidget {
  String id;
  ChatPage({Key? key, required this.id}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final uid = FirebaseAuth.instance.currentUser!.uid;
  Map<String, dynamic>? user;
  bool loading = true;
  void getData() async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(uid)
        .get()
        .then((value) {
      user = value.data();
    });
    print(user!['wakeupHistory']);
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : ListView(
            children: [
              ChartCard(title: 'WakeUp', list: user!['wakeupHistory']),
              ChartCard(title: 'Sleep', list: user!['sleepHistory']),
              ChartCard(title: 'Exercise', list: user!['exerciseHistory']),
            ],
          );
  }
}
