import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MessageDraftScreen extends StatefulWidget {
  const MessageDraftScreen({super.key});

  @override
  State<MessageDraftScreen> createState() => _MessageDraftScreenState();
}

class _MessageDraftScreenState extends State<MessageDraftScreen> {
  final TextEditingController _controller = TextEditingController();
  String? aiMessage;
  List<Map<String, dynamic>> conversations = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _generateMessage() {
    setState(() {
      aiMessage = "Hi! I’m excited to learn from your journey. Can we connect?";
    });
  }

  void _sendMessage(String message) {
    final newMessage = {
      'from': 'mentee',
      'to': 'mentor',
      'message': message,
      'timestamp': DateTime.now().toIso8601String()
    };
    setState(() {
      conversations.add(newMessage);
      _controller.clear();
    });
  }

  Future<void> _loadConversation() async {
    // Mock data, you can replace this with API call later
    final response = await http.get(Uri.parse('https://alq9rgfi10.execute-api.us-east-1.amazonaws.com/dev/messages'));
    if (response.statusCode == 200) {
      setState(() {
        conversations = List<Map<String, dynamic>>.from(json.decode(response.body));
      });
    } else {
      // Handle error
    }
  }

  @override
  void initState() {
    super.initState();
    _loadConversation();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
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
          const SizedBox(height: 12),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: _generateMessage,
                icon: const Icon(Icons.auto_fix_high),
                label: const Text("Draft with AI"),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () => _sendMessage(_controller.text),
                icon: const Icon(Icons.send),
                label: const Text("Send Message"),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (aiMessage != null)
            Card(
              key: ValueKey(aiMessage),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(aiMessage!, style: const TextStyle(fontSize: 16)),
              ),
            ),
          const Divider(height: 32),
          const Text("Previous Messages", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Expanded(
            child: ListView.builder(
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                final msg = conversations[index];
                return ListTile(
                  leading: msg['from'] == 'mentee' ? const Icon(Icons.person_outline) : const Icon(Icons.school_outlined),
                  title: Text(msg['message'] ?? ''),
                  subtitle: Text("${msg['from']} • ${DateTime.parse(msg['timestamp']).toLocal()}"),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
