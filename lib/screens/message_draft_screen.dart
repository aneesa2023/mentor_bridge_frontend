import 'package:flutter/material.dart';

class MessageDraftScreen extends StatefulWidget {
  const MessageDraftScreen({super.key});

  @override
  State<MessageDraftScreen> createState() => _MessageDraftScreenState();
}

class _MessageDraftScreenState extends State<MessageDraftScreen> {
  final TextEditingController _controller = TextEditingController();
  String? aiMessage;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _generateMessage() {
    // Future: integrate Gemini API here
    setState(() {
      aiMessage = "Hi! I’m excited to learn from your journey. Can we connect?";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _controller,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: "Describe what you need help with...",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: _generateMessage,
            icon: Icon(Icons.auto_fix_high),
            label: Text("Draft with AI"),
          ),
          SizedBox(height: 16),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: aiMessage == null
                ? Container()
                : Card(
              key: ValueKey(aiMessage),
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Text(aiMessage!, style: TextStyle(fontSize: 16)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
