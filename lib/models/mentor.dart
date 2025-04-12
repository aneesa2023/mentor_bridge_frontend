class Mentor {
  final String id;
  final String fullName;
  final String photoUrl;
  final String currentCompanyRole;
  final List<String> techStack;

  Mentor({
    required this.id,
    required this.fullName,
    required this.photoUrl,
    required this.currentCompanyRole,
    required this.techStack,
  });

  factory Mentor.fromJson(Map<String, dynamic> json) {
    return Mentor(
      id: json["_id"] ?? "",
      fullName: json["full_name"] ?? "No Name",
      photoUrl: json["photo_url"] ?? "https://via.placeholder.com/150",
      currentCompanyRole: json["current_company_role"] ?? "Unknown Role",
      techStack: List<String>.from(json["tech_stack"] ?? []),
    );
  }
}
