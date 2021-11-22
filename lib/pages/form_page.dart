import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_assistant_app/helper/time_format.dart';
import 'package:health_assistant_app/widgets/form/form_widgets.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
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
        : Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Card(
                      margin: const EdgeInsets.all(15.0),
                      elevation: 15,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CardTitle(title: 'Wakeup'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                PickedTime(
                                    time: timeFormat(user!['wakeupTime'])),
                                ElevatedButton(
                                    onPressed: () async {
                                      TimeOfDay? time = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now());
                                      String s = time.toString();
                                      if (s == "null") return;
                                      await FirebaseFirestore.instance
                                          .collection('user')
                                          .doc(uid)
                                          .update({
                                        'wakeupTime': s,
                                      });
                                      setState(() {
                                        user!['wakeupTime'] = s;
                                      });
                                    },
                                    child: const Text('Pick')),
                              ],
                            ),
                            InkWell(
                              onTap: () async {
                                await FirebaseFirestore.instance
                                    .collection('user')
                                    .doc(uid)
                                    .update({
                                  'wakeupStatus': !user!['wakeupStatus'],
                                });
                                setState(() {
                                  user!['wakeupStatus'] =
                                      !user!['wakeupStatus'];
                                });
                              },
                              child: TickMark(t: user!['wakeupStatus']),
                            ),
                          ],
                        ),
                      )),
                  Card(
                      margin: const EdgeInsets.all(15.0),
                      elevation: 15,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CardTitle(title: 'Sleep'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                PickedTime(
                                    time: timeFormat(user!['sleepTime'])),
                                ElevatedButton(
                                    onPressed: () async {
                                      TimeOfDay? time = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now());
                                      String s = time.toString();
                                      if (s == "null") return;
                                      await FirebaseFirestore.instance
                                          .collection('user')
                                          .doc(uid)
                                          .update({
                                        'sleepTime': s,
                                      });
                                      setState(() {
                                        user!['sleepTime'] = s;
                                      });
                                    },
                                    child: const Text('Pick')),
                              ],
                            ),
                            InkWell(
                              onTap: () async {
                                await FirebaseFirestore.instance
                                    .collection('user')
                                    .doc(uid)
                                    .update({
                                  'sleepStatus': !user!['sleepStatus'],
                                });
                                setState(() {
                                  user!['sleepStatus'] = !user!['sleepStatus'];
                                });
                              },
                              child: TickMark(t: user!['sleepStatus']),
                            ),
                          ],
                        ),
                      )),
                  Card(
                      margin: const EdgeInsets.all(15.0),
                      elevation: 15,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CardTitle(title: 'Exercise'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                PickedTime(
                                    time: timeFormat(user!['exerciseTime'])),
                                ElevatedButton(
                                    onPressed: () async {
                                      TimeOfDay? time = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now());
                                      String s = time.toString();
                                      if (s == "null") return;
                                      await FirebaseFirestore.instance
                                          .collection('user')
                                          .doc(uid)
                                          .update({
                                        'exerciseTime': s,
                                      });
                                      setState(() {
                                        user!['exerciseTime'] = s;
                                      });
                                    },
                                    child: const Text('Pick')),
                              ],
                            ),
                            InkWell(
                              onTap: () async {
                                await FirebaseFirestore.instance
                                    .collection('user')
                                    .doc(uid)
                                    .update({
                                  'exerciseStatus': !user!['exerciseStatus'],
                                });
                                setState(() {
                                  user!['exerciseStatus'] =
                                      !user!['exerciseStatus'];
                                });
                              },
                              child: TickMark(t: user!['exerciseStatus']),
                            ),
                          ],
                        ),
                      )),
                  Card(
                      margin: const EdgeInsets.all(15.0),
                      elevation: 15,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CardTitle(title: 'Morning Medicine'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                PickedTime(time: timeFormat(user!['mmt'])),
                                ElevatedButton(
                                    onPressed: () async {
                                      TimeOfDay? time = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now());
                                      String s = time.toString();
                                      if (s == "null") return;
                                      await FirebaseFirestore.instance
                                          .collection('user')
                                          .doc(uid)
                                          .update({
                                        'mmt': s,
                                      });
                                      setState(() {
                                        user!['mmt'] = s;
                                      });
                                    },
                                    child: const Text('Pick')),
                              ],
                            ),
                            InkWell(
                              onTap: () async {
                                await FirebaseFirestore.instance
                                    .collection('user')
                                    .doc(uid)
                                    .update({
                                  'mms': !user!['mms'],
                                });
                                setState(() {
                                  user!['mms'] = !user!['mms'];
                                });
                              },
                              child: TickMark(t: user!['mms']),
                            ),
                          ],
                        ),
                      )),
                  Card(
                      margin: const EdgeInsets.all(15.0),
                      elevation: 15,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CardTitle(title: 'Afternoon Medicine'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                PickedTime(time: timeFormat(user!['amt'])),
                                ElevatedButton(
                                    onPressed: () async {
                                      TimeOfDay? time = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now());
                                      String s = time.toString();
                                      if (s == "null") return;
                                      await FirebaseFirestore.instance
                                          .collection('user')
                                          .doc(uid)
                                          .update({
                                        'amt': s,
                                      });
                                      setState(() {
                                        user!['amt'] = s;
                                      });
                                    },
                                    child: const Text('Pick')),
                              ],
                            ),
                            InkWell(
                              onTap: () async {
                                await FirebaseFirestore.instance
                                    .collection('user')
                                    .doc(uid)
                                    .update({
                                  'ams': !user!['ams'],
                                });
                                setState(() {
                                  user!['ams'] = !user!['ams'];
                                });
                              },
                              child: TickMark(t: user!['ams']),
                            ),
                          ],
                        ),
                      )),
                  Card(
                      margin: const EdgeInsets.all(15.0),
                      elevation: 15,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CardTitle(title: 'Evening Medicine'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                PickedTime(time: timeFormat(user!['emt'])),
                                ElevatedButton(
                                    onPressed: () async {
                                      TimeOfDay? time = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now());
                                      String s = time.toString();
                                      if (s == "null") return;
                                      await FirebaseFirestore.instance
                                          .collection('user')
                                          .doc(uid)
                                          .update({
                                        'emt': s,
                                      });
                                      setState(() {
                                        user!['emt'] = s;
                                      });
                                    },
                                    child: const Text('Pick')),
                              ],
                            ),
                            InkWell(
                              onTap: () async {
                                await FirebaseFirestore.instance
                                    .collection('user')
                                    .doc(uid)
                                    .update({
                                  'ems': !user!['ems'],
                                });
                                setState(() {
                                  user!['ems'] = !user!['ems'];
                                });
                              },
                              child: TickMark(t: user!['ems']),
                            ),
                          ],
                        ),
                      )),
                  Card(
                      margin: const EdgeInsets.all(15.0),
                      elevation: 15,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CardTitle(title: 'Night Medicine'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                PickedTime(time: timeFormat(user!['nmt'])),
                                ElevatedButton(
                                    onPressed: () async {
                                      TimeOfDay? time = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now());
                                      String s = time.toString();
                                      if (s == "null") return;
                                      await FirebaseFirestore.instance
                                          .collection('user')
                                          .doc(uid)
                                          .update({
                                        'nmt': s,
                                      });
                                      setState(() {
                                        user!['nmt'] = s;
                                      });
                                    },
                                    child: const Text('Pick')),
                              ],
                            ),
                            InkWell(
                              onTap: () async {
                                await FirebaseFirestore.instance
                                    .collection('user')
                                    .doc(uid)
                                    .update({
                                  'nms': !user!['nms'],
                                });
                                setState(() {
                                  user!['nms'] = !user!['nms'];
                                });
                              },
                              child: TickMark(t: user!['nms']),
                            ),
                          ],
                        ),
                      )),
                  Container(
                    margin: const EdgeInsets.all(20.0),
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        List l = user!['wakeupHistory'];
                        l.add(user!['wakeupTime']);
                        user!['wakeupHistory'] = l;

                        l = user!['sleepHistory'];
                        l.add(user!['sleepTime']);
                        user!['sleepHistory'] = l;

                        l = user!['exerciseHistory'];
                        l.add(user!['exerciseTime']);
                        user!['exerciseHistory'] = l;

                        l = user!['mmh'];
                        l.add(user!['mmt']);
                        user!['mmh'] = l;

                        l = user!['amh'];
                        l.add(user!['amt']);
                        user!['amh'] = l;

                        l = user!['emh'];
                        l.add(user!['emt']);
                        user!['emh'] = l;

                        l = user!['nmh'];
                        l.add(user!['nmt']);
                        user!['nmh'] = l;
                        await FirebaseFirestore.instance
                            .collection('user')
                            .doc(uid)
                            .update({
                          'wakeupHistory': user!['wakeupHistory'],
                          'sleepHistory': user!['sleepHistory'],
                          'exerciseHistory': user!['exerciseHistory'],
                          'mmh': user!['mmh'],
                          'amh': user!['amh'],
                          'emh': user!['emh'],
                          'nmh': user!['nmh'],
                        });
                      },
                      icon: const Icon(
                        Icons.done_all_rounded,
                        size: 50,
                      ),
                      label: const Text(
                        'Submit',
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
