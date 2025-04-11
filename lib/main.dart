import 'package:flutter/material.dart';

void main() {
  runApp(MentorBridgeApp());
}

class MentorBridgeApp extends StatelessWidget {
  const MentorBridgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MentorBridge',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: RoleSelectionScreen(),
    );
  }
}

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("MentorBridge")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Who are you?"),
            ElevatedButton(
              onPressed: () {
                // Navigate to mentee dashboard
              },
              child: Text("I am a Mentee"),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to mentor dashboard
              },
              child: Text("I am a Mentor"),
            ),
          ],
        ),
      ),
    );
  }
}
