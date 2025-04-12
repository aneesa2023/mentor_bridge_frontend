import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  List<dynamic> mentors = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchMentors();
  }

  Future<void> fetchMentors() async {
    const url = 'https://alq9rgfi10.execute-api.us-east-1.amazonaws.com/dev/mentors';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        mentors = data;
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
    }
  }

  Widget _buildChipList(List<dynamic> values) {
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: values.map((e) => Chip(label: Text(e))).toList(),
    );
  }

  Widget _buildMentorCard(dynamic mentor) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 6))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  mentor['photo_url'] ?? '',
                  height: 120,
                  width: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    height: 120,
                    width: 100,
                    color: Colors.orange.shade100,
                    alignment: Alignment.center,
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mentor['full_name'] ?? '',
                      style:
                      const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(mentor['current_company_role'] ?? '',
                        style: const TextStyle(fontSize: 14)),
                    const SizedBox(height: 2),
                    if (mentor['school'] != null)
                      Text('🎓 ${mentor['school']}',
                          style: const TextStyle(fontSize: 13)),
                    if (mentor['experience_years'] != null)
                      Text('Experience: ${mentor['experience_years']} years'),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          if (mentor['mentoring_reason'] != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text('"${mentor['mentoring_reason']}"',
                  style:
                  const TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
            ),
          if (mentor['tech_stack'] != null)
            _buildChipList(mentor['tech_stack']),
          const SizedBox(height: 10),
          Row(
            children: [
              if (mentor['linkedin_url'] != null)
                IconButton(
                  icon: const Icon(Icons.linked_camera_rounded),
                  onPressed: () => openUrl(Uri.parse(mentor['linkedin_url'])),
                ),
              if (mentor['github'] != null)
                IconButton(
                  icon: const Icon(Icons.code),
                  onPressed: () => openUrl(Uri.parse(mentor['github'])),
                ),
              if (mentor['website'] != null)
                IconButton(
                  icon: const Icon(Icons.web),
                  onPressed: () => openUrl(Uri.parse(mentor['website'])),
                ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: mentors.length,
        itemBuilder: (context, index) => _buildMentorCard(mentors[index]),
      ),
    );
  }

  Future<void> openUrl(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
