import 'package:clinic/doctor_assignment_screen.dart';
import 'package:clinic/report_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HealthGuardTheme {
  static const _primaryFont = 'Roboto';
  static const _deepBlue = Color(0xFF2C7DA0);
  static const _softBlue = Color(0xFF61A5C2);
  static const _mintGreen = Color(0xFF9AD4D6);
  static const _lightBackground = Color(0xFFF8F9FA);
}

// Patient class definition
class Patient {
  final String id;
  final String name;
  final int age;
  final String gender;
  final String contact;

  Patient({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.contact,
  });
}

// Dummy data for testing
List<Patient> dummyPatients = [
  Patient(
    id: '1',
    name: 'Ramesh Kumar',
    age: 35,
    gender: 'Male',
    contact: '9876543210',
  ),
  Patient(
    id: '2',
    name: 'Sunita Devi',
    age: 28,
    gender: 'Female',
    contact: '9123456789',
  ),
  Patient(
    id: '3',
    name: 'Anil Sharma',
    age: 42,
    gender: 'Male',
    contact: '9645231870',
  ),
  Patient(
    id: '4',
    name: 'Meera Patel',
    age: 33,
    gender: 'Female',
    contact: '9512364780',
  ),
];

class DiagnosisInputScreen extends StatefulWidget {
  const DiagnosisInputScreen({Key? key}) : super(key: key);

  @override
  _DiagnosisInputScreenState createState() => _DiagnosisInputScreenState();
}

class _DiagnosisInputScreenState extends State<DiagnosisInputScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Patient selection
  List<Patient> _patients = [];
  Patient? _selectedPatient;

  // Symptoms input
  final TextEditingController _symptomsController = TextEditingController();

  // Image upload state
  XFile? _uploadedImage;

  // Suggested symptoms
  final List<String> _suggestedSymptoms = [
    'Persistent Cough',
    'Fever',
    'Night Sweats',
    'Chest Pain',
    'Fatigue',
    'Weight Loss',
    'Shortness of Breath',
  ];

  // Selected symptoms
  List<String> _selectedSymptoms = [];

  @override
  void initState() {
    super.initState();
    _fetchPatients();
    _tabController = TabController(length: 3, vsync: this);
  }

  void _fetchPatients() {
    setState(() {
      _patients = dummyPatients;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _symptomsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HealthGuard AI Diagnosis',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                letterSpacing: 0.5,
                color: Colors.white)),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [HealthGuardTheme._deepBlue, HealthGuardTheme._softBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TabBar(
              controller: _tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: const LinearGradient(
                  colors: [
                    HealthGuardTheme._mintGreen,
                    HealthGuardTheme._softBlue
                  ],
                ),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: HealthGuardTheme._deepBlue,
              tabs: const [
                Tab(icon: Icon(Icons.person_outline_rounded), text: 'Patient'),
                Tab(
                    icon: Icon(Icons.medical_information_rounded),
                    text: 'Symptoms'),
                Tab(
                    icon: Icon(Icons.photo_camera_back_rounded),
                    text: 'Upload'),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [HealthGuardTheme._lightBackground, Colors.white],
          ),
        ),
        child: TabBarView(
          controller: _tabController,
          children: [
            _buildPatientSelectionTab(),
            _buildSymptomsTab(),
            _buildImageUploadTab(),
          ],
        ),
      ),
      floatingActionButton: _selectedPatient != null
          ? FloatingActionButton.extended(
              onPressed: _proceedToAIAnalysis,
              elevation: 4,
              icon: const Icon(Icons.auto_awesome_mosaic_rounded,
                  size: 28, color: Colors.white),
              label: const Text('Analyze Case',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              backgroundColor: HealthGuardTheme._deepBlue,
            )
              .animate(onPlay: (controller) => controller.repeat())
              .shimmer(duration: 1500.ms, color: HealthGuardTheme._mintGreen)
          : null,
    );
  }

  Widget _buildPatientSelectionTab() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search Patients',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onChanged: (value) {},
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _patients.length,
            itemBuilder: (context, index) {
              final patient = _patients[index];
              return ListTile(
                title: Text(patient.name),
                subtitle: Text(
                    'ID: ${patient.id} | ${patient.age} years, ${patient.gender}'),
                trailing: Radio<Patient>(
                  value: patient,
                  groupValue: _selectedPatient,
                  onChanged: (Patient? selectedPatient) {
                    setState(() {
                      _selectedPatient = selectedPatient;
                    });
                  },
                ),
                selected: _selectedPatient == patient,
                onTap: () {
                  setState(() {
                    _selectedPatient = patient;
                  });
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSymptomsTab() {
    if (_selectedPatient == null) {
      return const Center(
        child: Text(
          'Please select a patient first',
          style: TextStyle(color: Colors.red),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Patient: ${_selectedPatient!.name}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _symptomsController,
            maxLines: 4,
            decoration: InputDecoration(
              hintText: 'Provide detailed description of patient symptoms...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Quick Select Symptoms',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _suggestedSymptoms.map((symptom) {
              final isSelected = _selectedSymptoms.contains(symptom);
              return ChoiceChip(
                label: Text(symptom),
                selected: isSelected,
                onSelected: (bool selected) {
                  setState(() {
                    if (selected) {
                      _selectedSymptoms.add(symptom);
                    } else {
                      _selectedSymptoms.remove(symptom);
                    }
                  });
                },
                selectedColor: const Color(0xFF2196F3).withOpacity(0.2),
                backgroundColor: Colors.grey[200],
                labelStyle: TextStyle(
                  color: isSelected ? const Color(0xFF2196F3) : Colors.black54,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildImageUploadTab() {
    if (_selectedPatient == null) {
      return const Center(
        child: Text('Please select a patient first',
            style: TextStyle(color: Colors.red)),
      );
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Patient: ${_selectedPatient!.name}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _uploadedImage != null
                ? _buildImagePreview()
                : _buildImageUploadPrompt(),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.camera),
                  icon: const Icon(Icons.camera_alt_outlined),
                  label: const Text('Capture'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2196F3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: () => _pickImage(ImageSource.gallery),
                  icon: const Icon(Icons.upload_outlined),
                  label: const Text('Upload'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePreview() {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF2196F3), width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: kIsWeb
            ? Image.asset(
                'assets/medical_icon.png',
                fit: BoxFit.cover,
              )
            : Image.file(
                File(_uploadedImage!.path),
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  Widget _buildImageUploadPrompt() {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[400]!, width: 2),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.upload_file_outlined,
            size: 80,
            color: Colors.grey[600],
          ),
          const SizedBox(height: 16),
          const Text(
            'Upload X-Ray or Blood Smear',
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Supported formats: JPEG, PNG, DICOM',
            style: TextStyle(
              color: Colors.black45,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _uploadedImage = pickedFile;
      });
    }
  }

  void _proceedToAIAnalysis() {
    if (_selectedPatient == null) {
      _showValidationDialog('Please select a patient');
      return;
    }

    if (_symptomsController.text.isEmpty && _selectedSymptoms.isEmpty) {
      _showValidationDialog('Please describe symptoms');
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AIResultsScreen(
          patient: _selectedPatient!,
          symptoms: _selectedSymptoms,
          medicalImages:
              _uploadedImage != null ? [XFile(_uploadedImage!.path)] : [],
          diagnosisResults: {'tb': 0.85, 'malaria': 0.92},
          timestamp: DateTime.now(),
        ),
      ),
    );
  }

  void _showValidationDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Incomplete Information'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

class AIResultsScreen extends StatelessWidget {
  final Patient patient;
  final List<String> symptoms;
  final List<XFile> medicalImages;
  final Map<String, double> diagnosisResults;
  final DateTime timestamp;

  const AIResultsScreen({
    super.key,
    required this.patient,
    required this.symptoms,
    required this.medicalImages,
    required this.diagnosisResults,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'AI Diagnosis Results',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF2C7DA0),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.share, color: Colors.white),
            onPressed: _shareResults,
            tooltip: 'Share Results',
          ),
        ],
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPatientHeader(),
              const SizedBox(height: 24),
              _buildDiagnosisSummary(),
              const SizedBox(height: 24),
              _buildDetailedAnalysis(),
              const SizedBox(height: 32),
              _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPatientHeader() {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF2C7DA0), Color(0xFF61A5C2)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(12),
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 36,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patient.name,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${patient.age} years | ${patient.gender}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Examined on ${DateFormat('MMM dd, yyyy').format(timestamp)}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiagnosisSummary() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2C7DA0).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.analytics_rounded,
                    color: Color(0xFF2C7DA0),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'AI Diagnosis Summary',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF212529),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(
              color: Color(0xFFE0E0E0),
              thickness: 1,
            ),
            const SizedBox(height: 16),
            _buildDiagnosisIndicator(
              'Tuberculosis',
              diagnosisResults['tb'] ?? 0.0,
              criticalThreshold: 0.7,
            ),
            const SizedBox(height: 14),
            _buildDiagnosisIndicator(
              'Malaria',
              diagnosisResults['malaria'] ?? 0.0,
              criticalThreshold: 0.8,
            ),
            const SizedBox(height: 24),
            _buildStatusBanner(),
          ],
        ),
      ),
    );
  }

  Widget _buildDiagnosisIndicator(String disease, double confidence,
      {required double criticalThreshold}) {
    final isCritical = confidence >= criticalThreshold;
    final percentValue = (confidence * 100).toStringAsFixed(1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                disease,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Color(0xFF212529),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              decoration: BoxDecoration(
                color: (isCritical
                        ? const Color(0xFFEA4335)
                        : const Color(0xFF34A853))
                    .withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isCritical
                      ? const Color(0xFFEA4335)
                      : const Color(0xFF34A853),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    isCritical
                        ? Icons.warning_amber_rounded
                        : Icons.check_circle,
                    color: isCritical
                        ? const Color(0xFFEA4335)
                        : const Color(0xFF34A853),
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '$percentValue%',
                    style: TextStyle(
                      color: isCritical
                          ? const Color(0xFFEA4335)
                          : const Color(0xFF34A853),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: confidence,
          backgroundColor: const Color(0xFFE0E0E0),
          valueColor: AlwaysStoppedAnimation<Color>(
            isCritical ? const Color(0xFFEA4335) : const Color(0xFF34A853),
          ),
          borderRadius: BorderRadius.circular(10),
          minHeight: 8,
        ),
      ],
    );
  }

  Widget _buildStatusBanner() {
    final isCritical = diagnosisResults.values.any((v) => v >= 0.7);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: isCritical
              ? [
                  const Color(0xFFEA4335).withOpacity(0.9),
                  const Color(0xFFEA4335),
                ]
              : [
                  const Color(0xFF34A853).withOpacity(0.9),
                  const Color(0xFF34A853),
                ],
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color:
                (isCritical ? const Color(0xFFEA4335) : const Color(0xFF34A853))
                    .withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isCritical ? Icons.warning : Icons.check_circle,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isCritical ? 'Critical Case' : 'Stable Condition',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isCritical
                      ? 'Requires immediate attention'
                      : 'Regular monitoring recommended',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedAnalysis() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Text(
            'Detailed Analysis',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF212529),
            ),
          ),
        ),
        const SizedBox(height: 16),
        _buildAnalysisCard(
          'Reported Symptoms',
          Icons.sick_rounded,
          child: symptoms.isNotEmpty
              ? Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: symptoms
                      .map(
                        (symptom) => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF61A5C2).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: const Color(0xFF61A5C2).withOpacity(0.3),
                            ),
                          ),
                          child: Text(
                            symptom,
                            style: const TextStyle(
                              color: Color(0xFF2C7DA0),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                      .toList(),
                )
              : const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'No symptoms reported',
                      style: TextStyle(
                        color: Color(0xFF6C757D),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
        ),
        const SizedBox(height: 16),
        _buildAnalysisCard(
          'Medical Images',
          Icons.image,
          child: medicalImages.isNotEmpty
              ? GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1,
                  ),
                  itemCount: medicalImages.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: kIsWeb
                            ? Image.asset(
                                'assets/medical_icon.png',
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(medicalImages[index].path),
                                fit: BoxFit.cover,
                              ),
                      ),
                    );
                  },
                )
              : const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Column(
                      children: [
                        Icon(
                          Icons.image_not_supported_outlined,
                          color: Color(0xFF6C757D),
                          size: 48,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No medical images uploaded',
                          style: TextStyle(
                            color: Color(0xFF6C757D),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildAnalysisCard(String title, IconData icon,
      {required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF9AD4D6).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: const Color(0xFF2C7DA0),
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF212529),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(
              color: Color(0xFFE0E0E0),
              thickness: 1,
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildActionButton(
            context,
            label: 'Generate Report',
            icon: Icons.assignment_outlined,
            backgroundColor: const Color(0xFF2C7DA0),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ReportScreen(
                    patient: patient,
                    symptoms: symptoms,
                    diagnosisResults: {
                      'tb': 0.85,
                      'malaria': 0.92
                    }, // Dummy data
                    timestamp: DateTime.now(),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildActionButton(
            context,
            label: 'Assign Doctor',
            icon: Icons.medical_services_outlined,
            backgroundColor: const Color(0xFFEA4335),
            onPressed: () => _assignDoctor(context),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required String label,
    required IconData icon,
    required Color backgroundColor,
    required VoidCallback onPressed,
  }) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        icon: Icon(icon, color: Colors.white),
        label: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0,
          minimumSize: const Size(double.infinity, 56),
        ),
        onPressed: onPressed,
      ),
    );
  }

  void _generateReport() {}

  void _assignDoctor(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DoctorAssignmentScreen(patient: patient),
      ),
    );
  }

  void _shareResults() {}
}
