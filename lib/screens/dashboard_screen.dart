import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange.shade100, Colors.orange.shade200],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.orange.shade200, blurRadius: 8),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("🌟 Tip of the Day",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(
                  "Break problems into smaller chunks and stay consistent.",
                  style: TextStyle(color: Colors.brown.shade800),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pink.shade100, Colors.pink.shade200],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Colors.pink.shade200, blurRadius: 8),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("🎯 Your Goals",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(
                  "Become confident in Flutter & land a frontend role.",
                  style: TextStyle(color: Colors.brown.shade800),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: const [
              _DashboardTile(
                  icon: Icons.celebration,
                  label: "Celebrate Win",
                  color: Colors.purple),
              _DashboardTile(
                  icon: Icons.question_answer,
                  label: "Ask Question",
                  color: Colors.teal),
              _DashboardTile(
                  icon: Icons.explore,
                  label: "Explore Mentors",
                  color: Colors.blue),
              _DashboardTile(
                  icon: Icons.chat_bubble_outline,
                  label: "Chat Room",
                  color: Colors.redAccent),
            ],
          ),
        ],
      ),
    );
  }
}

class _DashboardTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _DashboardTile(
      {required this.icon, required this.label, this.color = Colors.indigo});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Add navigation logic here if needed
      },
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: color.withOpacity(0.2), blurRadius: 6),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: color),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.brown.shade900),
            ),
          ],
        ),
      ),
    );
  }
}
