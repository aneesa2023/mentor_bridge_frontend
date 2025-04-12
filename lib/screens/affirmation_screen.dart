import 'package:flutter/material.dart';

class AffirmationScreen extends StatefulWidget {
  const AffirmationScreen({super.key});

  @override
  _AffirmationScreenState createState() => _AffirmationScreenState();
}

class _AffirmationScreenState extends State<AffirmationScreen>
    with SingleTickerProviderStateMixin {
  final List<String> affirmations = [
    "You’re doing better than you think.",
    "Progress is still progress.",
    "You belong here.",
  ];

  String? _affirmation;
  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
  }

  void _showAffirmation() {
    final next = (affirmations..shuffle()).first;
    setState(() => _affirmation = next);
    _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          ElevatedButton.icon(
            onPressed: _showAffirmation,
            icon: Icon(Icons.favorite_outline),
            label: Text("Inspire Me"),
          ),
          SizedBox(height: 20),
          if (_affirmation != null)
            FadeTransition(
              opacity: _fade,
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    _affirmation!,
                    style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
