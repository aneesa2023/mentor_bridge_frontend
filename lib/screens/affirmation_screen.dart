import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AffirmationScreen extends StatefulWidget {
  const AffirmationScreen({super.key});

  @override
  AffirmationScreenState createState() => AffirmationScreenState();
}

class AffirmationScreenState extends State<AffirmationScreen>
    with SingleTickerProviderStateMixin {
  String? _affirmation;
  bool _loading = true;

  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _fetchAffirmation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _fetchAffirmation() async {
    setState(() {
      _loading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/affirmation'), // Replace in prod
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _affirmation = data["reply"];
          _controller.forward(from: 0);
        });
      } else {
        setState(() => _affirmation = "Oops! Something went wrong.");
      }
    } catch (e) {
      setState(() => _affirmation = "Error: ${e.toString()}");
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bgColor = Colors.orange.shade50;
    final cardColor = Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        title: const Text("Daily Affirmation"),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: Center(
        child: _loading
            ? const CircularProgressIndicator()
            : FadeTransition(
                opacity: _fade,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Card(
                    color: cardColor,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            "🌞",
                            style: TextStyle(fontSize: 36),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            "Your Boost for Today",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            '"${_affirmation ?? ""}"',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              height: 1.5,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            "— from MentorBridge AI",
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: _fetchAffirmation,
                            icon: const Icon(Icons.refresh),
                            label: const Text("New Boost"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
