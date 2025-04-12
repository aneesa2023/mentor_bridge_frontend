import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  final List<Map<String, dynamic>> mentors = [
    {
      "name": "Sarah M.",
      "role": "Frontend Engineer",
      "experience": "4+ yrs",
      "bio": "Excited to help career switchers and frontend devs!",
      "skills": ["React", "JS", "HTML"],
      "avatarUrl": null,
      "available": true
    },
    {
      "name": "Rahul K.",
      "role": "Backend Mentor",
      "experience": "6 yrs",
      "bio": "Here to support mentees stuck in their job search.",
      "skills": ["Node.js", "SQL", "AWS"],
      "avatarUrl": null,
      "available": false
    }
  ];

  ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mentors.length,
        itemBuilder: (context, index) {
          final mentor = mentors[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 20),
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Colors.orange.shade100,
                        backgroundImage: mentor["avatarUrl"] != null
                            ? NetworkImage(mentor["avatarUrl"])
                            : null,
                        child: mentor["avatarUrl"] == null
                            ? const Icon(Icons.person,
                                size: 28, color: Colors.brown)
                            : null,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(mentor["name"],
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18)),
                            const SizedBox(height: 2),
                            Text("${mentor["role"]} • ${mentor["experience"]}",
                                style: TextStyle(
                                    color: Colors.grey.shade700, fontSize: 14)),
                          ],
                        ),
                      ),
                      Icon(
                        mentor["available"]
                            ? Icons.circle
                            : Icons.circle_outlined,
                        color: mentor["available"] ? Colors.green : Colors.grey,
                        size: 12,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    mentor["bio"],
                    style: const TextStyle(fontSize: 15, height: 1.4),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: mentor["skills"]
                        .map<Widget>(
                          (skill) => Chip(
                            label: Text(skill),
                            backgroundColor: Colors.orange.shade100,
                            labelStyle: const TextStyle(color: Colors.brown),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                      ),
                      onPressed: () {
                        // Trigger intro message
                      },
                      icon: const Icon(Icons.message_rounded),
                      label: const Text("Send Intro"),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
