import 'package:flutter/material.dart';

class ListAdder extends StatefulWidget {
  Function setLists;
  ListAdder({Key? key, required this.setLists}) : super(key: key);

  @override
  _ListAdderState createState() => _ListAdderState();
}

class _ListAdderState extends State<ListAdder> {
  List<String> degree = [];
  List<String> specialist = [];
  Future<void> _listAdder(Text title, int choose) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: title,
            content: SingleChildScrollView(
              child: ListBody(
                children: const <Widget>[
                  Text('This is a demo alert dialog.'),
                  Text('Would you like to approve of this message?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('Approve'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
            onPressed: () {
              _listAdder(const Text('Add your Degrees'), 0);
            },
            child: const Text('Degrees')),
        TextButton(
            onPressed: () {
              _listAdder(const Text('Add your specialists'), 0);
            },
            child: const Text('Specialists')),
      ],
    );
  }
}
