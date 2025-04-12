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
    const url =
        'https://alq9rgfi10.execute-api.us-east-1.amazonaws.com/dev/mentors';
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

  Widget _buildChipSection(String title, List<dynamic> values) {
    if (values.isEmpty) return SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 6),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: values.map((e) => Chip(label: Text(e))).toList(),
          )
        ],
      ),
    );
  }

  Widget _buildMentorCard(dynamic mentor) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundImage: NetworkImage(mentor['photo_url'] ?? ''),
                  backgroundColor: Colors.orange.shade100,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        mentor['full_name'] ?? '',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(mentor['current_company_role'] ?? '',
                          style: const TextStyle(fontSize: 14)),
                      Text(
                          'Experience: ${mentor['experience_years'] ?? ''} years'),
                      if (mentor['school'] != null)
                        Text('School: ${mentor['school']}',
                            style: const TextStyle(fontSize: 14)),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            _buildChipSection("Tech Stack", mentor['tech_stack']),
            _buildChipSection("Industries", mentor['industries']),
            _buildChipSection("Domains", mentor['domains']),
            _buildChipSection("Personality", mentor['personality_tags']),
            _buildChipSection("Mentoring Style", mentor['mentoring_style']),
            _buildChipSection(
                "Communication Style", mentor['communication_style']),
            _buildChipSection("Languages Spoken", mentor['languages_spoken']),
            _buildChipSection("Hobbies", mentor['hobbies']),
            _buildChipSection("Mentee Types", mentor['mentee_types_to_help']),
            const SizedBox(height: 8),
            if (mentor['mentoring_reason'] != null)
              Text('Why Mentor?: ${mentor['mentoring_reason']}',
                  style: const TextStyle(fontStyle: FontStyle.italic)),
            const SizedBox(height: 10),
            Row(
              children: [
                if (mentor['linkedin_url'] != null)
                  IconButton(
                    icon: const Icon(Icons.linked_camera_rounded),
                    onPressed: () =>
                        launchUrl(Uri.parse(mentor['linkedin_url'])),
                  ),
                if (mentor['github'] != null)
                  IconButton(
                    icon: const Icon(Icons.code),
                    onPressed: () => launchUrl(Uri.parse(mentor['github'])),
                  ),
                if (mentor['website'] != null)
                  IconButton(
                    icon: const Icon(Icons.web),
                    onPressed: () => launchUrl(Uri.parse(mentor['website'])),
                  ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
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
