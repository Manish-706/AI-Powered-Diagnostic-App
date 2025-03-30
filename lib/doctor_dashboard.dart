import 'package:clinic/patient_case.dart'; // Import the unified PatientCase class
import 'package:clinic/doctor_telemed.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DoctorDashboard extends StatefulWidget {
  final String doctorId;

  const DoctorDashboard({super.key, required this.doctorId});

  @override
  _DoctorDashboardState createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  final List<PatientCase> _allCases = [
    PatientCase(
      patientId: 'P001',
      name: 'Ramesh Kumar',
      age: 35,
      gender: 'Male',
      bloodGroup: 'B+',
      condition: 'Suspected TB',
      urgency: 'Critical',
      lastUpdated: '2h ago',
      consultationCount: 0,
      nextMeeting: null,
      isCompleted: false,
      profileImage: null,
    ),
    PatientCase(
      patientId: 'P002',
      name: 'Sunita Devi',
      age: 28,
      gender: 'Female',
      bloodGroup: 'O+',
      condition: 'Malaria Positive',
      urgency: 'High',
      lastUpdated: '4h ago',
      consultationCount: 1,
      nextMeeting: DateTime(2023, 10, 15),
      isCompleted: false,
      profileImage: null,
    ),
  ];

  String _activeFilter = 'all';
  late List<PatientCase> _filteredCases;

  @override
  void initState() {
    super.initState();
    _filteredCases = _allCases;
  }

  Map<String, int> get _caseStats {
    return {
      'total': _allCases.length,
      'pending': _allCases.where((c) => c.consultationCount == 0).length,
      'scheduled': _allCases.where((c) => c.nextMeeting != null).length,
      'completed': _allCases.where((c) => c.isCompleted).length,
    };
  }

  void _applyFilter(String filter) {
    setState(() {
      _activeFilter = filter;
      _filteredCases = _allCases.where((patientCase) {
        switch (filter) {
          case 'pending':
            return patientCase.consultationCount == 0;
          case 'scheduled':
            return patientCase.nextMeeting != null;
          case 'completed':
            return patientCase.isCompleted;
          default:
            return true;
        }
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final stats = _caseStats;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          'Doctor Dashboard',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: const Color(0xFF2C7DA0),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
          const CircleAvatar(
            radius: 18,
            backgroundColor: Color(0xFF61A5C2),
            child: Text('DR',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildWelcomeHeader(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: Text(
                'Your Patient Overview',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF212529),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF2C7DA0),
                      Color(0xFF61A5C2),
                      Color(0xFF9AD4D6)
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2C7DA0).withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        _buildStatBox(
                          icon: Icons.group,
                          value: stats['total'],
                          label: 'Total Cases',
                          color: Colors.white,
                          flex: 1,
                        ),
                        _buildStatBox(
                          icon: Icons.access_time,
                          value: stats['pending'],
                          label: 'Pending',
                          color: Colors.white,
                          flex: 1,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _buildStatBox(
                          icon: Icons.calendar_today,
                          value: stats['scheduled'],
                          label: 'Scheduled',
                          color: Colors.white,
                          flex: 1,
                        ),
                        _buildStatBox(
                          icon: Icons.check_circle,
                          value: stats['completed'],
                          label: 'Completed',
                          color: Colors.white,
                          flex: 1,
                        ),
                      ],
                    ),
                  ],
                ),
              ).animate().fadeIn(duration: 500.ms).slideY(begin: 0.2, end: 0),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Patient Cases',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF212529),
                    ),
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.filter_list, size: 16),
                    label: const Text('Filter'),
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF2C7DA0),
                    ),
                  ),
                ],
              ),
            ),
            _buildFilterChips(),
            Expanded(
              child: _filteredCases.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _filteredCases.length,
                      itemBuilder: (context, index) =>
                          _buildCaseCard(_filteredCases[index], index),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF2C7DA0),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildWelcomeHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        children: [
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(color: const Color(0xFF212529)),
                children: [
                  TextSpan(
                    text: 'Welcome back, ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: 'Dr. Singh',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF9AD4D6).withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.date_range,
                  size: 16,
                  color: Color(0xFF2C7DA0),
                ),
                const SizedBox(width: 4),
                Text(
                  DateFormat('dd MMM, yyyy').format(DateTime.now()),
                  style: TextStyle(
                    color: const Color(0xFF2C7DA0),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatBox({
    required IconData icon,
    required int? value,
    required String label,
    required Color color,
    required int flex,
  }) {
    return Expanded(
      flex: flex,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, size: 24, color: color),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${value ?? 0}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: color,
                  ),
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: color.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    const filters = {
      'all': 'All Cases',
      'pending': 'Pending',
      'scheduled': 'Scheduled',
      'completed': 'Completed',
    };

    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: filters.entries.map((entry) {
          final isActive = _activeFilter == entry.key;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(entry.value),
              selected: isActive,
              showCheckmark: false,
              backgroundColor: Colors.white,
              selectedColor: const Color(0xFF2C7DA0),
              labelStyle: TextStyle(
                color: isActive ? Colors.white : const Color(0xFF6C757D),
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  color: isActive
                      ? const Color(0xFF2C7DA0)
                      : const Color(0xFFE0E0E0),
                ),
              ),
              onSelected: (_) => _applyFilter(entry.key),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCaseCard(PatientCase patientCase, int index) {
    final urgencyColor = _getUrgencyColor(patientCase.urgency);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFEEEEEE),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
              leading: Stack(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: const Color(0xFFF0F0F0),
                    child: Text(
                      patientCase.name.substring(0, 1),
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2C7DA0),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: urgencyColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              title: Text(
                patientCase.name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF212529),
                ),
              ),
              subtitle: Row(
                children: [
                  _buildInfoBadge(
                    '${patientCase.age} yrs',
                    Colors.grey.shade200,
                    const Color(0xFF6C757D),
                  ),
                  const SizedBox(width: 6),
                  _buildInfoBadge(
                    patientCase.gender,
                    Colors.grey.shade200,
                    const Color(0xFF6C757D),
                  ),
                  const SizedBox(width: 6),
                  _buildInfoBadge(
                    patientCase.bloodGroup,
                    Colors.grey.shade200,
                    const Color(0xFF6C757D),
                  ),
                ],
              ),
              trailing: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _getUrgencyColor(patientCase.urgency).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  patientCase.urgency,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: _getUrgencyColor(patientCase.urgency),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF9AD4D6).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      patientCase.condition,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF2C7DA0),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Updated: ${patientCase.lastUpdated}',
                    style: TextStyle(
                      fontSize: 12,
                      color: const Color(0xFF6C757D),
                    ),
                  ),
                ],
              ),
            ),
            if (patientCase.nextMeeting != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFFAE5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.event,
                        size: 16,
                        color: Color(0xFFFFA000),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Next Appointment: ${DateFormat('MMM dd, hh:mm a').format(patientCase.nextMeeting!)}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFFFFA000),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Divider(height: 1, color: Colors.grey.shade200),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProfessionalTelemedicineScreen(
                      patient: PatientCase(
                        patientId: patientCase.patientId,
                        name: patientCase.name,
                        age: patientCase.age,
                        gender: patientCase.gender,
                        bloodGroup: patientCase.bloodGroup,
                        condition: patientCase.condition,
                        urgency: patientCase.urgency,
                        lastUpdated: patientCase.lastUpdated,
                        consultationCount: patientCase.consultationCount,
                        nextMeeting: patientCase.nextMeeting,
                        isCompleted: patientCase.isCompleted,
                        profileImage: patientCase.profileImage,
                      ),
                    ),
                  ),
                );
              },
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                alignment: Alignment.center,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'View Details',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2C7DA0),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.arrow_forward,
                      size: 16,
                      color: Color(0xFF2C7DA0),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms, delay: (100 * index).ms)
        .slideY(begin: 0.1, end: 0);
  }

  Widget _buildInfoBadge(String text, Color bgColor, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.folder_open,
            size: 72,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No cases found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF6C757D),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try changing your filter or check back later',
            style: TextStyle(
              fontSize: 14,
              color: const Color(0xFF6C757D),
            ),
          ),
        ],
      ),
    );
  }

  Color _getUrgencyColor(String urgency) {
    switch (urgency.toLowerCase()) {
      case 'critical':
        return const Color(0xFFEA4335);
      case 'high':
        return const Color(0xFFFFA000);
      default:
        return const Color(0xFF34A853);
    }
  }
}
