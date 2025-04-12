import 'package:flutter/material.dart';
import 'package:mentor_bridge_frontend/screens/affirmation_screen.dart';
import 'package:mentor_bridge_frontend/screens/ask_wall_screen.dart';
import 'package:mentor_bridge_frontend/screens/celebrate_screen.dart';
import 'package:mentor_bridge_frontend/screens/conversation_coach_screen.dart';
import 'package:mentor_bridge_frontend/screens/dashboard_screen.dart';
import 'package:mentor_bridge_frontend/screens/explore_screen.dart';
import 'package:mentor_bridge_frontend/screens/message_draft_screen.dart';
import 'package:mentor_bridge_frontend/screens/profile_screen.dart';
import 'package:mentor_bridge_frontend/screens/progress_screen.dart';
import 'package:mentor_bridge_frontend/screens/schedule_screen.dart';
import 'package:mentor_bridge_frontend/screens/settings_screen.dart';

void main() {
  runApp(MentorBridgeApp());
}

class MentorBridgeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MentorBridge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        scaffoldBackgroundColor: Colors.orange.shade50,
        useMaterial3: true,
        fontFamily: 'Inter', // optional if you’re using custom fonts
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: Colors.orange.shade100,
          selectedColor: Colors.orange,
          disabledColor: Colors.grey.shade300,
          labelStyle: TextStyle(color: Colors.black),
          secondaryLabelStyle: TextStyle(color: Colors.white),
          brightness: Brightness.light,
        ),
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    DashboardScreen(),
    ScheduleScreen(),
    MessageDraftScreen(),
    ExploreScreen(),
    AskWallScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  void _handleMenuSelection(String value) {
    Widget screen;

    switch (value) {
      case 'celebrate':
        screen = CelebrateScreen();
        break;
      case 'coach':
        screen = ConversationCoachScreen();
        break;
      case 'affirmations':
        screen = AffirmationScreen();
        break;
      case 'progress':
        screen = ProgressScreen();
        break;
      case 'profile':
        screen = ProfileScreen();
        break;
      case 'settings':
        screen = SettingsScreen();
        break;
      default:
        return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MentorBridge'),
        actions: [
          PopupMenuButton<String>(
            onSelected: _handleMenuSelection,
            itemBuilder: (BuildContext context) => [
              PopupMenuItem(
                  value: 'celebrate',
                  child: ListTile(
                      leading: Icon(Icons.emoji_events),
                      title: Text("Celebrate"))),
              PopupMenuItem(
                  value: 'coach',
                  child: ListTile(
                      leading: Icon(Icons.psychology_alt),
                      title: Text("Conversation Coach"))),
              PopupMenuItem(
                  value: 'affirmations',
                  child: ListTile(
                      leading: Icon(Icons.favorite_outline),
                      title: Text("Affirmations"))),
              PopupMenuItem(
                  value: 'progress',
                  child: ListTile(
                      leading: Icon(Icons.timeline), title: Text("Progress"))),
              PopupMenuItem(
                  value: 'profile',
                  child: ListTile(
                      leading: Icon(Icons.person_outline),
                      title: Text("Profile"))),
              PopupMenuItem(
                  value: 'settings',
                  child: ListTile(
                      leading: Icon(Icons.settings_outlined),
                      title: Text("Settings"))),
            ],
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.schedule_outlined), label: "Schedule"),
          BottomNavigationBarItem(
              icon: Icon(Icons.auto_fix_high_outlined), label: "Messages"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_search_outlined), label: "Explore"),
          BottomNavigationBarItem(
              icon: Icon(Icons.forum_outlined), label: "Ask Wall"),
        ],
      ),
    );
  }
}
