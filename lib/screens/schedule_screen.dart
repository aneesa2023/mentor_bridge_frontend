import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  final List<Map<String, String>> sessions = [
    {
      "date": "Apr 15",
      "time": "5:00 PM",
      "topic": "Resume Review",
      "type": "Upcoming"
    },
    {
      "date": "Apr 10",
      "time": "3:00 PM",
      "topic": "Mock Interview",
      "type": "Past"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Text("Your Sessions", style: Theme.of(context).textTheme.titleLarge),
        SizedBox(height: 12),
        ...sessions.map((session) => Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: Icon(Icons.event),
                title: Text("${session["date"]} - ${session["time"]}"),
                subtitle: Text(session["topic"]!),
                trailing: Chip(
                  label: Text(session["type"]!,
                      style: TextStyle(color: Colors.white)),
                  backgroundColor: session["type"] == "Upcoming"
                      ? Colors.green
                      : Colors.grey,
                ),
              ),
            )),
      ],
    );
  }
}
