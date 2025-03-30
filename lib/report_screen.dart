import 'package:clinic/diagnosis_input_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

class ReportScreen extends StatelessWidget {
  final Patient patient;
  final List<String> symptoms;
  final DateTime timestamp;
  final Map<String, double> diagnosisResults;

  const ReportScreen({
    super.key,
    required this.patient,
    required this.symptoms,
    required this.diagnosisResults,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Diagnosis Report',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: const Color(0xFF2C7DA0),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF2C7DA0).withOpacity(0.05),
              Colors.white,
            ],
            stops: const [0.0, 0.2],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildHeader().animate().fade(duration: 400.ms),
                const SizedBox(height: 24),
                _buildPatientSection().animate().fade(delay: 100.ms).slideY(
                      begin: 0.1,
                      end: 0,
                      curve: Curves.easeOut,
                      duration: 400.ms,
                    ),
                const SizedBox(height: 16),
                _buildDiagnosisSection().animate().fade(delay: 200.ms).slideY(
                      begin: 0.1,
                      end: 0,
                      curve: Curves.easeOut,
                      duration: 400.ms,
                    ),
                const SizedBox(height: 16),
                _buildSymptomsSection().animate().fade(delay: 300.ms).slideY(
                      begin: 0.1,
                      end: 0,
                      curve: Curves.easeOut,
                      duration: 400.ms,
                    ),
                const SizedBox(height: 16),
                _buildRecommendationsSection()
                    .animate()
                    .fade(delay: 400.ms)
                    .slideY(
                      begin: 0.1,
                      end: 0,
                      curve: Curves.easeOut,
                      duration: 400.ms,
                    ),
                const SizedBox(height: 24),
                _buildFooter().animate().fade(delay: 500.ms),
                const SizedBox(height: 24),
                _buildActionButtons().animate().fade(delay: 600.ms).scale(
                      delay: 600.ms,
                      duration: 300.ms,
                      begin: const Offset(0.95, 0.95),
                      end: const Offset(1, 1),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Center(
            child: Image.asset(
              'assets/clinic_logo.png',
              height: 60,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'HealthGuard AI Report',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C7DA0),
            letterSpacing: 0.5,
          ),
        ),
        const Text(
          'Affiliated with Indian Rural Health Initiative',
          style: TextStyle(
            color: Color(0xFF6C757D),
            fontSize: 14,
            letterSpacing: 0.2,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFF61A5C2).withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Report ID: #${DateTime.now().millisecondsSinceEpoch}',
            style: const TextStyle(
              color: Color(0xFF2C7DA0),
              fontWeight: FontWeight.w500,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPatientSection() {
    return _buildSectionCard(
      title: 'Patient Details',
      icon: Icons.person,
      children: [
        Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFF61A5C2).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  patient.name.substring(0, 1).toUpperCase(),
                  style: const TextStyle(
                    color: Color(0xFF2C7DA0),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
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
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF212529),
                    ),
                  ),
                  Text(
                    '${patient.age} years • ${patient.gender}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6C757D),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Divider(height: 1),
        const SizedBox(height: 16),
        _buildInfoRow(
          icon: Icons.phone,
          label: 'Contact',
          value: patient.contact,
        ),
        _buildInfoRow(
          icon: Icons.location_on,
          label: 'Location',
          value: 'Wardha, Maharashtra',
        ),
        _buildInfoRow(
          icon: Icons.calendar_today,
          label: 'Visit Date',
          value: DateFormat('dd MMM yyyy, hh:mm a').format(timestamp),
        ),
      ],
    );
  }

  Widget _buildDiagnosisSection() {
    final tbResult = diagnosisResults['tb'] ?? 0.0;
    final malariaResult = diagnosisResults['malaria'] ?? 0.0;
    final isCritical = _getOverallStatus().contains('CRITICAL');

    return _buildSectionCard(
      title: 'Diagnosis Results',
      icon: Icons.medical_services,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isCritical
                ? const Color(0xFFEA4335).withOpacity(0.05)
                : const Color(0xFF34A853).withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isCritical
                  ? const Color(0xFFEA4335).withOpacity(0.2)
                  : const Color(0xFF34A853).withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: isCritical
                      ? const Color(0xFFEA4335).withOpacity(0.1)
                      : const Color(0xFF34A853).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isCritical ? Icons.warning_amber_rounded : Icons.check_circle,
                  color: isCritical
                      ? const Color(0xFFEA4335)
                      : const Color(0xFF34A853),
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getOverallStatus(),
                      style: TextStyle(
                        color: isCritical
                            ? const Color(0xFFEA4335)
                            : const Color(0xFF34A853),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isCritical
                          ? 'Doctor consultation required'
                          : 'Monitor symptoms regularly',
                      style: const TextStyle(
                        color: Color(0xFF6C757D),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _buildResultIndicator(
          disease: 'Tuberculosis',
          confidence: tbResult,
          threshold: 0.7,
        ),
        const SizedBox(height: 12),
        _buildResultIndicator(
          disease: 'Malaria',
          confidence: malariaResult,
          threshold: 0.8,
        ),
      ],
    );
  }

  Widget _buildSymptomsSection() {
    return _buildSectionCard(
      title: 'Reported Symptoms',
      icon: Icons.coronavirus,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: symptoms.map((symptom) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF9AD4D6).withOpacity(0.1),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: const Color(0xFF9AD4D6).withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Text(
                symptom,
                style: const TextStyle(
                  color: Color(0xFF2C7DA0),
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRecommendationsSection() {
    final isCritical = _getOverallStatus().contains('CRITICAL');

    final recommendations = isCritical
        ? [
            'Immediate doctor consultation required',
            'Start treatment as prescribed by doctor',
            'Monitor vital signs every 4 hours'
          ]
        : [
            'Rest and stay hydrated',
            'Follow-up visit in one week',
            'Contact clinic if symptoms worsen'
          ];

    return _buildSectionCard(
      title: 'Recommendations',
      icon: Icons.lightbulb_outline,
      children: [
        ...recommendations.map((rec) => _buildRecommendationItem(rec)),
      ],
    );
  }

  Widget _buildRecommendationItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check_circle,
            color: Color(0xFF61A5C2),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF212529),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: const Color(0xFF61A5C2).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.local_hospital,
                  color: Color(0xFF2C7DA0),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. Ramesh Patel',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF212529),
                      ),
                    ),
                    Text(
                      'Clinic Worker',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF6C757D),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Divider(height: 1),
          const SizedBox(height: 12),
          const Row(
            children: [
              Icon(
                Icons.location_on,
                color: Color(0xFF6C757D),
                size: 16,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Gram Panchayat Clinic, Wardha, Maharashtra',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6C757D),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        ElevatedButton.icon(
          icon: const Icon(Icons.picture_as_pdf),
          label: const Text(
            'GENERATE PDF REPORT',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2C7DA0),
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            elevation: 4,
          ),
          onPressed: () {}, // TODO: Add PDF export
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                icon: const Icon(Icons.print),
                label: const Text('Print'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF2C7DA0),
                  side: const BorderSide(color: Color(0xFF2C7DA0), width: 2),
                  minimumSize: const Size(0, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {}, // TODO: Add print
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                icon: const Icon(Icons.share),
                label: const Text('Share'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF2C7DA0),
                  side: const BorderSide(color: Color(0xFF2C7DA0), width: 2),
                  minimumSize: const Size(0, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {}, // TODO: Add share
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Helper methods
  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF61A5C2).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
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
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Color(0xFF2C7DA0),
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: const Color(0xFF9AD4D6).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: const Color(0xFF2C7DA0),
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF6C757D),
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF212529),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultIndicator({
    required String disease,
    required double confidence,
    required double threshold,
  }) {
    final isCritical = confidence >= threshold;
    final percentage = (confidence * 100).toStringAsFixed(1);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: isCritical
            ? const Color(0xFFEA4335).withOpacity(0.05)
            : const Color(0xFF34A853).withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                disease,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xFF212529),
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: isCritical
                      ? const Color(0xFFEA4335).withOpacity(0.1)
                      : const Color(0xFF34A853).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
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
                      '$percentage%',
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
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: confidence,
              backgroundColor: Colors.grey.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(
                isCritical ? const Color(0xFFEA4335) : const Color(0xFF34A853),
              ),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            isCritical
                ? 'Requires immediate medical attention'
                : 'Within normal parameters',
            style: TextStyle(
              fontSize: 12,
              color: isCritical
                  ? const Color(0xFFEA4335)
                  : const Color(0xFF34A853),
            ),
          ),
        ],
      ),
    );
  }

  String _getOverallStatus() {
    final tbCritical = (diagnosisResults['tb'] ?? 0) >= 0.7;
    final malariaCritical = (diagnosisResults['malaria'] ?? 0) >= 0.8;

    if (tbCritical || malariaCritical) {
      return 'CRITICAL CASE';
    }
    return 'STABLE CONDITION';
  }
}
