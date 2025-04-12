import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mentor_bridge_frontend/services/auth_service.dart';

class UserService {
  final _authService = AuthService();

  Future<Map<String, dynamic>?> getUserProfile() async {
    final token = await _authService.getAccessToken();

    final response = await http.get(
      Uri.parse('http://127.0.0.1:8000/api/users/init'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      return json.decode(response.body);
    } else {
      print('Failed to fetch user profile: ${response.body}');
      return null;
    }
  }
}
