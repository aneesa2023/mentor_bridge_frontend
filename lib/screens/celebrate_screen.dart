import 'package:flutter/material.dart';

class CelebrateScreen extends StatefulWidget {
  const CelebrateScreen({super.key});

  @override
  CelebrateScreenState createState() => CelebrateScreenState();
}

class CelebrateScreenState extends State<CelebrateScreen> {
  final _controller = TextEditingController();
  String? _message;

  void _generateCelebration() {
    setState(() {
      _message = "🎉 Huge Congrats!\nYou're making waves. Keep going!";
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Celebrate Your Win")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: "What did you achieve?",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton.icon(
              icon: Icon(Icons.emoji_events),
              label: Text("Celebrate with AI"),
              onPressed: _generateCelebration,
            ),
            SizedBox(height: 16),
            if (_message != null)
              Card(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(_message!, style: TextStyle(fontSize: 16)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
