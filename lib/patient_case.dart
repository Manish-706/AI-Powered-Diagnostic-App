class PatientCase {
  final String patientId;
  final String name;
  final int age;
  final String gender;
  final String bloodGroup;
  final String condition;
  final String urgency;
  final String lastUpdated;
  final int consultationCount;
  final DateTime? nextMeeting;
  final bool isCompleted;
  final String? profileImage; // Nullable string for image path or URL

  PatientCase({
    required this.patientId,
    required this.name,
    required this.age,
    required this.gender,
    required this.bloodGroup,
    required this.condition,
    required this.urgency,
    required this.lastUpdated,
    required this.consultationCount,
    this.nextMeeting,
    required this.isCompleted,
    this.profileImage,
  });
}
