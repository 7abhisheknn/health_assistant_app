import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_assistant_app/widgets/chart/chart_card.dart';

// ignore: must_be_immutable
class ChartPage extends StatefulWidget {
  String id;
  ChartPage({Key? key, required this.id}) : super(key: key);

  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  Map<String, dynamic>? user;
  bool loading = true;
  bool isDoctor = true;
  void getData() async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(widget.id)
        .get()
        .then((value) {
      user = value.data();
    });
    print(user!['wakeupHistory']);
    setState(() {
      loading = false;
      if (user!['is_doctor'] == false) {
        isDoctor = false;
      }
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
        : isDoctor
            ? const Center(
                child: Text('only for patients'),
              )
            : ListView(
                children: [
                  ChartCard(title: 'WakeUp', list: user!['wakeupHistory']),
                  ChartCard(title: 'Sleep', list: user!['sleepHistory']),
                  ChartCard(title: 'Exercise', list: user!['exerciseHistory']),
                  ChartCard(title: 'Morning Medicine', list: user!['mmh']),
                  ChartCard(title: 'Afternoon Medicine', list: user!['amh']),
                  ChartCard(title: 'Evening Medicine', list: user!['emh']),
                  ChartCard(title: 'Night Medicine', list: user!['nmh']),
                ],
              );
  }
}
