import 'package:flutter/material.dart';

class ListAdder extends StatefulWidget {
  Function setDegree;
  Function setSpecialist;
  ListAdder({Key? key, required this.setDegree, required this.setSpecialist})
      : super(key: key);

  @override
  _ListAdderState createState() => _ListAdderState();
}

class _ListAdderState extends State<ListAdder> {
  final _controller = TextEditingController();
  String _enteredText = '';
  List<List<String>> list = [[], []];
  Future<void> _listAdder(
      BuildContext context, Text title, int i, Function f) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: title,
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: list[i]
                            .map((string) => ListTile(
                                  title: Text(string),
                                  trailing: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        list[i].remove(string);
                                      });
                                    },
                                    icon: const Icon(Icons.delete),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _controller,
                            onChanged: (value) {
                              setState(() {
                                _enteredText = value;
                              });
                            },
                            decoration: const InputDecoration(
                                label: Text('Add a felid')),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              list[i].add(_enteredText);
                            });
                            _controller.clear();
                          },
                          icon: const Icon(Icons.send),
                        ),
                      ],
                    )
                  ]);
            }),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                onPressed: () {
                  f(list[i]);
                  Navigator.of(context).pop();
                },
                child: const Text("Save"),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
            onPressed: () {
              _listAdder(
                  context, const Text('Add your Degrees'), 0, widget.setDegree);
            },
            child: const Text('Degrees')),
        TextButton(
            onPressed: () {
              _listAdder(context, const Text('Add your specialists'), 1,
                  widget.setSpecialist);
            },
            child: const Text('Specialists')),
      ],
    );
  }
}
