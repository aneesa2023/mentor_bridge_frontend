import 'package:flutter/material.dart';
import 'package:mentor_bridge_frontend/services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  final authService = AuthService();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(
                'assets/images/mentorship.png',
                height: 200,
              ),
              const SizedBox(height: 24),
              Text(
                "Welcome to MentorBridge",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.brown.shade800,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                "Connect. Learn. Grow.\nEmpowering your tech journey.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                  icon: const Icon(Icons.login),
                  label: const Text("Login or Sign Up with Auth0"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () async {
                    try {
                      await authService.login();
                      final isLoggedIn = await authService.isLoggedIn();
                      if (isLoggedIn && context.mounted) {
                        Navigator.pushReplacementNamed(context, '/main');
                      }
                    } catch (e) {
                      print("Login error: $e");
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Login cancelled or failed. Please try again.")));
                    }
                  }),
              const SizedBox(height: 16),
              Text(
                "By continuing, you agree to our Terms & Privacy Policy.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
