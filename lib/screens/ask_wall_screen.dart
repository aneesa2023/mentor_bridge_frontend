import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AskWallScreen extends StatefulWidget {
  const AskWallScreen({super.key});

  @override
  State<AskWallScreen> createState() => _AskWallScreenState();
}

class _AskWallScreenState extends State<AskWallScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _loading = false;

  final List<Map<String, dynamic>> posts = [
    {
      "question": "I’m scared to ask questions in meetings. Any advice?",
      "timestamp": "2h ago",
      "reply":
          "You're not alone. Start by writing questions down and asking one per meeting.",
      "liked": false,
      "likeCount": 4,
      "expanded": false,
      "anonymous": true,
      "user": {
        "name": "Jane Doe",
        "avatarUrl": null,
      },
      "comments": [
        {
          "name": "Priya",
          "isAnonymous": false,
          "avatarUrl": null,
          "text": "I used to be like that too. Start with 1:1 meetings."
        },
        {
          "name": "Anonymous",
          "isAnonymous": true,
          "avatarUrl": null,
          "text": "Try scripting your question beforehand!"
        }
      ]
    },
    {
      "question": "How do I find a mentor who understands career switches?",
      "timestamp": "4h ago",
      "reply":
          "Look for people who’ve done similar transitions and reach out through forums or LinkedIn.",
      "liked": true,
      "likeCount": 9,
      "expanded": false,
      "anonymous": false,
      "user": {
        "name": "Aanya Sharma",
        "avatarUrl": null,
      },
      "comments": [
        {
          "name": "Ravi",
          "isAnonymous": false,
          "avatarUrl": null,
          "text": "WomenWhoCode and ADPList are good places to start."
        }
      ]
    },
    {
      "question": "What’s the best way to prepare for a mock interview?",
      "timestamp": "5h ago",
      "reply":
          "Record yourself answering questions. Then review and refine your responses.",
      "liked": false,
      "likeCount": 2,
      "expanded": false,
      "anonymous": true,
      "user": {
        "name": "Anonymous",
        "avatarUrl": null,
      },
      "comments": []
    }
  ];

  Future<void> _post() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() => _loading = true);

    try {
      final res = await http.post(
        Uri.parse('http://127.0.0.1:8000/ask-reply'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"question": text}),
      );

      final reply =
          jsonDecode(res.body)["reply"] ?? "We'll get back to you soon.";

      setState(() {
        posts.insert(0, {
          "question": text,
          "timestamp": "Just now",
          "reply": reply,
          "liked": false,
          "likeCount": 0,
          "expanded": false,
          "anonymous": true,
          "user": {"name": "Anonymous", "avatarUrl": null},
          "comments": []
        });
        _controller.clear();
      });
    } catch (_) {
    } finally {
      setState(() => _loading = false);
    }
  }

  void _toggleExpand(int index) {
    setState(() => posts[index]["expanded"] = !posts[index]["expanded"]);
  }

  void _toggleLike(int index) {
    setState(() {
      posts[index]["liked"] = !posts[index]["liked"];
      posts[index]["likeCount"] += posts[index]["liked"] ? 1 : -1;
    });
  }

  Widget _buildComment(Map<String, dynamic> comment) {
    final isAnon = comment["isAnonymous"] == true;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: Colors.grey.shade300,
            child: isAnon
                ? const Icon(Icons.person_outline)
                : const Icon(Icons.person),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isAnon ? "Anonymous" : comment["name"],
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 13),
                ),
                Text(
                  comment["text"],
                  style: const TextStyle(fontSize: 14),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bg = Colors.orange.shade50;

    return Scaffold(
      backgroundColor: bg,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                final user = post["user"];
                final isAnonymous = post["anonymous"] == true;
                final comments = post["comments"] as List;

                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.shade100,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: isAnonymous
                                ? Colors.orange.shade100
                                : Colors.blue.shade100,
                            child: const Icon(Icons.person_outline,
                                color: Colors.brown),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            isAnonymous ? "Anonymous" : user["name"],
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          Text(post["timestamp"],
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(post["question"],
                          style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              post["liked"]
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: Colors.red,
                            ),
                            onPressed: () => _toggleLike(index),
                          ),
                          Text("${post["likeCount"]}"),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.comment_outlined,
                                color: Colors.grey),
                            onPressed: () => _toggleExpand(index),
                          ),
                          Text("${comments.length + 1}",
                              style: const TextStyle(color: Colors.grey))
                        ],
                      ),
                      if (post["expanded"]) ...[
                        const Divider(),
                        Text("💬 MentorBridge AI",
                            style: TextStyle(
                                color: Colors.orange.shade800,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Text(post["reply"],
                            style: const TextStyle(fontSize: 14)),
                        const SizedBox(height: 12),
                        ...comments
                            .map<Widget>(
                                (c) => _buildComment(c as Map<String, dynamic>))
                            .toList()
                      ]
                    ],
                  ),
                );
              },
            ),
          ),
          SafeArea(
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              color: Colors.orange.shade100.withOpacity(0.2),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      enabled: !_loading,
                      decoration: InputDecoration(
                        hintText: "Ask something anonymously...",
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(color: Colors.orange.shade300),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide(
                              color: Colors.orange.shade400, width: 2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.send_rounded),
                    onPressed: _loading ? null : _post,
                    color: Colors.orange.shade700,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
