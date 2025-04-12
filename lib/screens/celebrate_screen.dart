import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CelebrateScreen extends StatefulWidget {
  const CelebrateScreen({super.key});

  @override
  State<CelebrateScreen> createState() => _CelebrateScreenState();
}

class _CelebrateScreenState extends State<CelebrateScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> celebrations = [
    {
      "user": {"name": "Alex Kim", "avatar": null},
      "achievement": "Landed my first internship!",
      "message":
          "🎉 That’s incredible! The first step in your journey is always worth celebrating.",
      "reactions": {"🎉": 2, "❤️": 1}
    },
    {
      "user": {"name": "Samira Singh", "avatar": null},
      "achievement": "Completed 100 days of code!",
      "message":
          "🔥 Your dedication is inspiring. Keep pushing forward, coder!",
      "reactions": {"🎉": 3, "❤️": 0}
    },
  ];

  bool _loading = false;

  Future<void> _celebrate() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() => _loading = true);

    try {
      final res = await http.post(
        Uri.parse("http://127.0.0.1:8000/celebrate"), // Replace with deployed
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"achievement": text}),
      );

      final msg =
          jsonDecode(res.body)["message"] ?? "🎉 Congrats on your achievement!";
      celebrations.insert(0, {
        "user": {"name": "You", "avatar": null},
        "achievement": text,
        "message": msg,
        "reactions": {"🎉": 0, "❤️": 0}
      });
      _controller.clear();
    } catch (_) {
      celebrations.insert(0, {
        "user": {"name": "You", "avatar": null},
        "achievement": text,
        "message": "🎊 You're doing amazing! Keep it up!",
        "reactions": {"🎉": 0, "❤️": 0}
      });
    } finally {
      setState(() => _loading = false);
    }
  }

  void _react(int index, String emoji) {
    setState(() {
      celebrations[index]["reactions"][emoji]++;
    });
  }

  Widget _buildReactions(Map<String, int> reactions, int index) {
    return Row(
      children: reactions.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(right: 12),
          child: GestureDetector(
            onTap: () => _react(index, entry.key),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.orange.shade50,
                border: Border.all(color: Colors.orange.shade100),
              ),
              child: Text("${entry.key} ${entry.value}"),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _celebrationCard(Map<String, dynamic> post, int index) {
    final user = post["user"];
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.shade100,
            blurRadius: 6,
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
                backgroundColor: Colors.orange.shade100,
                child: const Icon(Icons.person, color: Colors.brown),
              ),
              const SizedBox(width: 10),
              Text(
                user["name"] ?? "Anonymous",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text("🏆 ${post["achievement"]}",
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(post["message"],
              style:
                  const TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
          const SizedBox(height: 12),
          _buildReactions(post["reactions"], index),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bg = Colors.orange.shade50;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        title: const Text("Celebrate Your Win"),
        backgroundColor: Colors.orange.shade300,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _controller,
                  enabled: !_loading,
                  decoration: InputDecoration(
                    hintText: "What achievement are you proud of today?",
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: _loading ? null : _celebrate,
                  icon: const Icon(Icons.emoji_events),
                  label: const Text("Celebrate with AI"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: celebrations.length,
              itemBuilder: (_, i) => _celebrationCard(celebrations[i], i),
            ),
          )
        ],
      ),
    );
  }
}
