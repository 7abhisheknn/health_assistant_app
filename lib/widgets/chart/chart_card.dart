import 'dart:math';

import 'package:flutter/material.dart';
import 'package:health_assistant_app/helper/time_format.dart';
import 'package:health_assistant_app/widgets/chart/chart_bar.dart';

class ChartCard extends StatefulWidget {
  List list;
  ChartCard({Key? key, required this.list}) : super(key: key);

  @override
  _ChartCardState createState() => _ChartCardState();
}

class _ChartCardState extends State<ChartCard> {
  List k = [];
  List v = [];
  bool loading = true;
  double total = 0.0;
  void maxs() {
    Map<String, int> mm = {};
    for (int i = 0; i < widget.list.length; i++) {
      int count = 0;
      for (int j = 0; j < widget.list.length; j++) {
        if (widget.list[i] == widget.list[j]) count++;
      }
      mm[widget.list[i]] = count;
    }

    List keys = mm.keys.toList();
    List values = mm.values.toList();

    int lengthOfArray = keys.length;
    for (int i = 0; i < lengthOfArray - 1; i++) {
      for (int j = 0; j < lengthOfArray - i - 1; j++) {
        if (values[j] > values[j + 1]) {
          String temp = keys[j];
          keys[j] = keys[j + 1];
          keys[j + 1] = temp;
          int temp2 = values[j];
          values[j] = values[j + 1];
          values[j + 1] = temp2;
        }
      }
    }

    for (int i = 0; i < keys.length; i++) {
      print(keys[i]);
      print(values[i]);
    }
    int max = 5;
    for (int i = keys.length - 1; (i > 0) && (max > 0); i--, max--) {
      k.add(keys[i]);
      v.add(values[i]);
    }
    for (int i = 0; i < v.length; i++) {
      total += v[i];
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    maxs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Scaffold(body: Center(child: CircularProgressIndicator()))
        : Card(
            elevation: 6,
            margin: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                for (int i = 0; i < k.length; i++)
                  ChartBar(
                      label: timeFormat(k[i]),
                      spendingAmount: v[i],
                      spendingPctOfTotal: v[i] / total),
              ],
            ),
          );
  }
}
