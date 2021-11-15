import 'package:flutter/material.dart';

class CardTitle extends StatelessWidget {
  String title;
  CardTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.purple,
        fontWeight: FontWeight.w900,
        fontSize: 20,
      ),
    );
  }
}

class PickedTime extends StatelessWidget {
  String time;
  PickedTime({Key? key, required this.time}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      const Text(
        'Picked Time:    ',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      Text(
        time,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    ]);
  }
}

class TickMark extends StatelessWidget {
  bool t;
  TickMark({Key? key, required this.t}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          t ? Icons.check_box : Icons.check_box_outline_blank,
          color: Colors.green.shade700,
        ),
        Text(
          t ? 'done' : 'not done',
          style: TextStyle(
              color: t ? Colors.green.shade700 : Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}
