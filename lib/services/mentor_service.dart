import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mentor_bridge_frontend/models/mentor.dart';

class MentorService {
  static const String _baseUrl =
      "https://alq9rgfi10.execute-api.us-east-1.amazonaws.com/dev";

  static Future<List<Mentor>> fetchMentors() async {
    final response = await http.get(Uri.parse("$_baseUrl/mentors"));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Mentor.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load mentors');
    }
  }
}
