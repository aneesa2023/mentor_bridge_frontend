import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // This can be dynamically loaded from Auth0 or user state
    final user = {
      "name": "Priya Sharma",
      "role": "Mentee",
      "tech": "Flutter, Firebase",
      "goal": "Get help preparing for tech interviews"
    };

    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Card(
          child: ListTile(
            title: Text(user["name"] ?? ""),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Role: ${user["role"]}"),
                Text("Tech Stack: ${user["tech"]}"),
                Text("Goal: ${user["goal"]}"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
