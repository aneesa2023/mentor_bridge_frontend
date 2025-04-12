import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final List<Map<String, String>> chats = [
    {
      "name": "Rashmi Subhash",
      "lastMessage": "Perfect! I’ll send you a resource pack.",
      "time": "2m ago"
    },
    {
      "name": "Aneesa Shaik",
      "lastMessage": "Do you have availability this weekend?",
      "time": "10m ago"
    },
    {
      "name": "Aanya Sharma",
      "lastMessage": "Thanks for the suggestions!",
      "time": "1h ago"
    },
    {
      "name": "Vikram Patel",
      "lastMessage": "No worries, we’ll make it stronger together.",
      "time": "3h ago"
    },
    {
      "name": "Leela Joseph",
      "lastMessage": "Can we schedule a session next week?",
      "time": "1d ago"
    },
    {
      "name": "Harshita Mehra",
      "lastMessage": "That portfolio advice was super helpful 🙌",
      "time": "2d ago"
    },
    {
      "name": "MentorBot AI",
      "lastMessage": "Here’s your personalized weekly tip!",
      "time": "2d ago"
    }
  ];

  void openChat(String name) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatDetailScreen(name: name),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: ListView.separated(
        itemCount: chats.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.orange,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text(chat['name']!),
            subtitle: Text(chat['lastMessage']!),
            trailing: Text(chat['time']!,
                style: const TextStyle(fontSize: 12, color: Colors.grey)),
            onTap: () => openChat(chat['name']!),
          );
        },
      ),
    );
  }
}

class ChatDetailScreen extends StatefulWidget {
  final String name;
  const ChatDetailScreen({super.key, required this.name});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _controller = TextEditingController();

  late final List<String> messages;

  @override
  void initState() {
    super.initState();
    messages = _getMessageVariant(widget.name);
  }

  List<String> _getMessageVariant(String name) {
    switch (name) {
      case "Vikram Patel":
        return [
          "Hi! I wanted feedback on my resume for tech roles.",
          "Sure, send it over. Are you applying to any specific company or role?",
          "Looking at entry-level software engineering jobs.",
          "Got it. I'll review for structure, keywords, and clarity.",
          "Thank you! I’m nervous about how it looks right now.",
          "No worries, we’ll make it stronger together."
        ];
      case "Rashmi Subhash":
      default:
        return [
          "Hi, I’m looking for guidance on learning Flutter.",
          "Sure! Let’s plan a roadmap for you.",
          "That would be great. Thank you!",
          "What areas are you most interested in?",
          "Mobile app dev and animations mostly.",
          "Perfect! I’ll send you a resource pack."
        ];
    }
  }

  void sendMessage() {
    final msg = _controller.text.trim();
    if (msg.isEmpty) return;
    setState(() {
      messages.add(msg);
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final isMe = index % 2 == 0;
                return Align(
                  alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color:
                          isMe ? Colors.orange.shade300 : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(messages[index]),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Type your message...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.orange),
                  onPressed: sendMessage,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
