import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mentor_bridge_frontend/screens/affirmation_screen.dart';
import 'package:mentor_bridge_frontend/screens/ask_wall_screen.dart';
import 'package:mentor_bridge_frontend/screens/celebrate_screen.dart';
import 'package:mentor_bridge_frontend/screens/conversation_coach_screen.dart';
import 'package:mentor_bridge_frontend/screens/dashboard_screen.dart';
import 'package:mentor_bridge_frontend/screens/explore_screen.dart';
import 'package:mentor_bridge_frontend/screens/message_draft_screen.dart';
import 'package:mentor_bridge_frontend/screens/profile_screen.dart';
import 'package:mentor_bridge_frontend/screens/settings_screen.dart';
import 'package:mentor_bridge_frontend/screens/login_screen.dart';
import 'package:mentor_bridge_frontend/services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  print("Auth0 client: \${dotenv.env['AUTH0_CLIENT_ID']}");

  final authService = AuthService();
  final isLoggedIn = await authService.isLoggedIn();

  runApp(MentorBridgeApp(startOnMain: isLoggedIn));
}

class MentorBridgeApp extends StatelessWidget {
  final bool startOnMain;
  const MentorBridgeApp({super.key, required this.startOnMain});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MentorBridge',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        scaffoldBackgroundColor: Colors.orange.shade50,
        useMaterial3: true,
        fontFamily: 'Inter',
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        chipTheme: ChipThemeData(
          backgroundColor: Colors.orange.shade100,
          selectedColor: Colors.orange,
          disabledColor: Colors.grey.shade300,
          labelStyle: const TextStyle(color: Colors.black),
          secondaryLabelStyle: const TextStyle(color: Colors.white),
          brightness: Brightness.light,
        ),
      ),
      initialRoute: startOnMain ? '/main' : '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/main': (context) => const MainScreen(),
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const MessageDraftScreen(),
    ExploreScreen(),
    const AskWallScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  void _handleMenuSelection(String value) async {
    Widget? screen;

    switch (value) {
      case 'celebrate':
        screen = const CelebrateScreen();
        break;
      case 'coach':
        screen = const ConversationCoachScreen();
        break;
      case 'affirmations':
        screen = const AffirmationScreen();
        break;
      case 'profile':
        screen = const ProfileScreen();
        break;
      case 'settings':
        screen = const SettingsScreen();
        break;
      case 'logout':
        final authService = AuthService();
        await authService.logout();
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/');
        }
        return;
    }

    if (screen != null) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => screen!),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MentorBridge'),
        actions: [
          PopupMenuButton<String>(
            onSelected: _handleMenuSelection,
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem(
                  value: 'celebrate',
                  child: ListTile(
                      leading: Icon(Icons.emoji_events),
                      title: Text("Celebrate"))),
              const PopupMenuItem(
                  value: 'coach',
                  child: ListTile(
                      leading: Icon(Icons.psychology_alt),
                      title: Text("Conversation Coach"))),
              const PopupMenuItem(
                  value: 'affirmations',
                  child: ListTile(
                      leading: Icon(Icons.favorite_outline),
                      title: Text("Affirmations"))),
              const PopupMenuItem(
                  value: 'profile',
                  child: ListTile(
                      leading: Icon(Icons.person_outline),
                      title: Text("Profile"))),
              const PopupMenuItem(
                  value: 'settings',
                  child: ListTile(
                      leading: Icon(Icons.settings_outlined),
                      title: Text("Settings"))),
              const PopupMenuItem(
                  value: 'logout',
                  child: ListTile(
                      leading: Icon(Icons.logout), title: Text("Logout"))),
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
