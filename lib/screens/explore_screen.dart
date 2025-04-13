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
  PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    fetchMentors();
  }

  Future<String> fetchGeminiSummary(Map<String, dynamic> mentor) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/gemini-summary'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(mentor),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['reply'] ?? "No summary available.";
      } else {
        return "Could not fetch summary.";
      }
    } catch (e) {
      return "Error fetching summary.";
    }
  }

  Future<void> fetchMentors() async {
    const url =
        'https://alq9rgfi10.execute-api.us-east-1.amazonaws.com/dev/mentors';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      // Fetch summaries in parallel
      final List<Future<void>> summaryFutures = data.map((mentor) async {
        final summary = await fetchGeminiSummary(mentor);
        mentor['gemini_summary'] = summary;
      }).toList();

      await Future.wait(summaryFutures);

      setState(() {
        mentors = data;
        isLoading = false;
      });
    } else {
      setState(() => isLoading = false);
    }
  }

  Widget _buildChipList(String title, List<dynamic> values) {
    if (values.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: values.map((e) => Chip(label: Text(e))).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildMentorCard(dynamic mentor, int index) {
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, 6),
                ),
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
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Container(
                            height: 120,
                            width: 100,
                            color: Colors.orange.shade100,
                            alignment: Alignment.center,
                            child:
                            const CircularProgressIndicator(strokeWidth: 2),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) => Container(
                          height: 120,
                          width: 100,
                          color: Colors.orange.shade100,
                          alignment: Alignment.center,
                          child: const Icon(Icons.person,
                              size: 50, color: Colors.white),
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
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Text(mentor['current_company_role'] ?? '',
                              style: const TextStyle(fontSize: 14)),
                          const SizedBox(height: 2),
                          if (mentor['school'] != null)
                            Text('🎓 ${mentor['school']}',
                                style: const TextStyle(fontSize: 13)),
                          if (mentor['experience_years'] != null)
                            Text(
                                'Experience: ${mentor['experience_years']} years'),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        if (mentor['linkedin_url'] != null)
                          GestureDetector(
                            onTap: () => openUrl(Uri.parse(mentor['linkedin_url'])),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Image.asset(
                                'assets/images/linkedin_logo.png',
                                height: 20,
                                width: 20,
                              ),
                            ),
                          ),
                        if (mentor['github'] != null)
                          GestureDetector(
                            onTap: () => openUrl(Uri.parse(mentor['github'])),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Image.asset(
                                'assets/images/github_logo.png',
                                height: 20,
                                width: 20,
                              ),
                            ),
                          ),
                        if (mentor['website'] != null)
                          GestureDetector(
                            onTap: () => openUrl(Uri.parse(mentor['website'])),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Image.asset(
                                'assets/images/website_logo.jpeg',
                                height: 20,
                                width: 20,
                              ),
                            ),
                          ),
                      ],
                    )

                  ],
                ),
                const SizedBox(height: 16),
                if (mentor['gemini_summary'] != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      mentor['gemini_summary'],
                      style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                    ),
                  ),
                _buildChipList("Tech Stack", mentor['tech_stack'] ?? []),
                _buildChipList("Industries", mentor['industries'] ?? []),
                _buildChipList("Domains", mentor['domains'] ?? []),
                _buildChipList("Personality", mentor['personality_tags'] ?? []),
                _buildChipList(
                    "Mentoring Style", mentor['mentoring_style'] ?? []),
                _buildChipList(
                    "Communication Style", mentor['communication_style'] ?? []),
                _buildChipList("Languages", mentor['languages_spoken'] ?? []),
                _buildChipList("Hobbies", mentor['hobbies'] ?? []),
                _buildChipList(
                    "Mentee Types", mentor['mentee_types_to_help'] ?? []),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 24,
          left: 30,
          right: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("See later"),
                      duration: Duration(seconds: 1),
                    ),
                  );
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                icon: const Icon(Icons.clear),
                label: const Text("See later"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey.shade300,
                  foregroundColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Connection request sent"),
                      duration: Duration(seconds: 1),
                    ),
                  );
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                },
                icon: const Icon(Icons.favorite_border),
                label: const Text("Connect"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade50,
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: mentors.length,
        itemBuilder: (context, index) =>
            _buildMentorCard(mentors[index], index),
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