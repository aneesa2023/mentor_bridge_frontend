import 'package:flutter/material.dart';

class AskWallScreen extends StatefulWidget {
  const AskWallScreen({super.key});

  @override
  State<AskWallScreen> createState() => _AskWallScreenState();
}

class _AskWallScreenState extends State<AskWallScreen> {
  final List<String> questions = [
    "How do I ask for a raise?",
    "Is switching careers at 30 too late?",
  ];
  final TextEditingController _controller = TextEditingController();

  void _post() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        questions.insert(0, _controller.text.trim());
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
              labelText: "Ask a question anonymously...",
              suffixIcon: IconButton(icon: Icon(Icons.send), onPressed: _post),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: questions.length,
            itemBuilder: (context, index) => ListTile(
              leading: CircleAvatar(child: Icon(Icons.person_outline)),
              title: Text(questions[index]),
            ),
          ),
        )
      ],
    );
  }
}
