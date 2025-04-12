import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  final List<Map<String, String>> history = [
    {"date": "Apr 3", "topic": "Resume review"},
    {"date": "Apr 5", "topic": "Mock interview"},
    {"date": "Apr 10", "topic": "System design intro"},
  ];

  ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Progress Timeline")),
      body: ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) => ListTile(
          leading: Icon(Icons.check_circle_outline),
          title: Text(history[index]['topic']!),
          subtitle: Text("Completed on ${history[index]['date']}"),
        ),
      ),
    );
  }
}
