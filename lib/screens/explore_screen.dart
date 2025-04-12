import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  final List<Map<String, String>> mentors = [
    {"name": "Sarah M.", "stack": "Frontend, Career Switcher"},
    {"name": "Rahul K.", "stack": "Backend, Mock Interviews"},
    {"name": "Aisha Z.", "stack": "AI, Emotional Support"},
  ];

  ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: mentors.length,
      itemBuilder: (context, index) {
        final mentor = mentors[index];
        return Card(
          margin: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(child: Text(mentor['name']![0])),
            title: Text(mentor['name']!),
            subtitle: Text(mentor['stack']!),
            trailing: Icon(Icons.person_add),
            onTap: () {
              // Show mentor profile or request session
            },
          ),
        );
      },
    );
  }
}
