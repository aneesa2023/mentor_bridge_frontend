import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool safeMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: ListView(
        children: [
          SwitchListTile(
            value: safeMode,
            title: Text("Enable Safe Mode"),
            subtitle: Text("Hide name/photo in sessions"),
            onChanged: (value) {
              setState(() {
                safeMode = value;
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () {
              // TODO: integrate logout logic
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Logged out")),
              );
            },
          ),
        ],
      ),
    );
  }
}
