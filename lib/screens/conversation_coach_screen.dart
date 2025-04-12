import 'package:flutter/material.dart';

class ConversationCoachScreen extends StatefulWidget {
  const ConversationCoachScreen({super.key});

  @override
  ConversationCoachScreenState createState() => ConversationCoachScreenState();
}

class ConversationCoachScreenState extends State<ConversationCoachScreen> {
  final _inputController = TextEditingController();
  String? _suggestion;

  void _getSuggestion() {
    setState(() {
      _suggestion = "Try asking: \"Can we revisit my compensation? I'd love to understand how I can grow here.\"";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Conversation Coach")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _inputController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: "What do you want to ask?",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            ElevatedButton.icon(
              icon: Icon(Icons.psychology),
              label: Text("Help me phrase this"),
              onPressed: _getSuggestion,
            ),
            SizedBox(height: 16),
            if (_suggestion != null)
              Card(
                child: Padding(
                  padding: EdgeInsets.all(12),
                  child: Text(_suggestion!, style: TextStyle(fontSize: 16)),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
