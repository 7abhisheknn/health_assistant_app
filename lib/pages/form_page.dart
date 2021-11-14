import 'package:flutter/material.dart';
import 'package:health_assistant_app/widgets/form/card_title.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  String? wakeupTime;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
            margin: const EdgeInsets.all(15.0),
            elevation: 15,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CardTitle(title: 'Wakeup'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('Picked Time'),
                      ElevatedButton(
                          onPressed: () async {
                            TimeOfDay? time = await showTimePicker(
                                context: context, initialTime: TimeOfDay.now());
                            String s = time.toString();
                            print(s == "null");
                            if (s == "null") return;
                            wakeupTime = s;
                            print(wakeupTime);
                          },
                          child: const Text('Pick')),
                    ],
                  ),
                ],
              ),
            )),
      ],
    );
  }
}
