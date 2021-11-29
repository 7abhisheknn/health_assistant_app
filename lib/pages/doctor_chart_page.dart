import 'package:flutter/material.dart';
import 'package:health_assistant_app/pages/chart_page.dart';

class DoctorChart extends StatefulWidget {
  String doc_id;
  final String name;
  final String image;
  DoctorChart({
    Key? key,
    required this.doc_id,
    required this.name,
    required this.image,
  }) : super(key: key);

  @override
  _DoctorChartState createState() => _DoctorChartState();
}

class _DoctorChartState extends State<DoctorChart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(widget.image),
            ),
            const SizedBox(width: 20),
            Text('Chart of ${widget.name}'),
          ],
        ),
      ),
      body: ChartPage(id: widget.doc_id),
    );
  }
}
