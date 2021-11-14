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
