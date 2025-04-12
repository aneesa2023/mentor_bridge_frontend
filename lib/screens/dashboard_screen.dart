import 'package:flutter/material.dart';
import 'package:mentor_bridge_frontend/services/auth_service.dart';
import 'package:mentor_bridge_frontend/screens/chat_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final AuthService _authService = AuthService();

  void _handleLogout(BuildContext context) async {
    await _authService.logout();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  void initState() {
    super.initState();
    // Future: fetch dashboard data, tips, session info
  }

  final List<DashboardItem> items = [
    DashboardItem(
      title: "Next Session",
      icon: Icons.calendar_today,
      subtitle: "with Alex - Tomorrow",
    ),
    DashboardItem(
      title: "Today's Tip",
      icon: Icons.lightbulb_outline,
      subtitle: "Ask questions. Stay curious.",
    ),
    DashboardItem(
      title: "Celebrate",
      icon: Icons.emoji_events_outlined,
      subtitle: "Log your wins!",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: items.map((item) {
                return Card(
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(item.icon, size: 32, color: Colors.indigo),
                        const SizedBox(height: 12),
                        Text(
                          item.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          item.subtitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 12),
                        ),

                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatScreen(
                      menteeId: 'mentee123', mentorId: 'mentor456'),
                ),
              );
            },
            child: const Text('Chat'),
          )
        ],
      ),
    );
  }
}

class DashboardItem {
  final String title;
  final IconData icon;
  final String subtitle;

  DashboardItem({
    required this.title,
    required this.icon,
    required this.subtitle,
  });
}
