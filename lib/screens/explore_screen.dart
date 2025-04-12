import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  final List<Map<String, String>> mentors = [
    {
      "name": "Sarah M.",
      "role": "Frontend Engineer • 4+ yrs",
      "bio": "Excited to help career switchers and frontend devs!",
      "stack": "React, JS, HTML",
      "image": "https://via.placeholder.com/150"
    },
    {
      "name": "Rahul K.",
      "role": "Backend Mentor • 6 yrs",
      "bio": "Here to support mentees stuck in their job search.",
      "stack": "Node.js, SQL, AWS",
      "image": "https://via.placeholder.com/150"
    },
  ];

  ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: mentors.length,
      itemBuilder: (context, index) {
        final mentor = mentors[index];
        return Card(
          margin: EdgeInsets.only(bottom: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 28,
                  child: Icon(Icons.person),
                ),
                title: Text(mentor["name"]!,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(mentor["role"]!),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(mentor["bio"]!),
                    SizedBox(height: 8),
                    Wrap(
                      spacing: 6,
                      children: mentor["stack"]!.split(',').map((tag) {
                        return Chip(label: Text(tag.trim()));
                      }).toList(),
                    ),
                    SizedBox(height: 12),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.message),
                        label: Text("Send Intro"),
                        onPressed: () {
                          // TODO: Navigate to message draft screen
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
