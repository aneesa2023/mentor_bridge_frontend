import 'package:flutter/material.dart';

class AskWallScreen extends StatefulWidget {
  const AskWallScreen({super.key});

  @override
  State<AskWallScreen> createState() => _AskWallScreenState();
}

class _AskWallScreenState extends State<AskWallScreen> {
  final List<Map<String, String>> posts = [
    {
      "question": "I’m scared to ask questions in meetings. Any advice?",
      "timestamp": "2h ago"
    },
    {
      "question": "Is it okay to say I don’t know during interviews?",
      "timestamp": "4h ago"
    },
  ];

  final TextEditingController _controller = TextEditingController();

  void _post() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        posts.insert(0, {
          "question": _controller.text.trim(),
          "timestamp": "Just now",
        });
        _controller.clear();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(12),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: "Ask something anonymously...",
              suffixIcon: IconButton(icon: Icon(Icons.send), onPressed: _post),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.all(12),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return Card(
                margin: EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: CircleAvatar(child: Icon(Icons.person_outline)),
                  title: Text(post["question"]!),
                  subtitle: Text(post["timestamp"]!),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
