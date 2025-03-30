import 'package:clinic/diagnosis_input_screen.dart';
import 'package:clinic/patient_login.dart';
import 'package:clinic/patient_telemedicine.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:clinic/patient_case.dart';

import 'report_screen.dart';

class PatientHomeScreen extends StatefulWidget {
  final PatientModel patient;

  const PatientHomeScreen({Key? key, required this.patient}) : super(key: key);

  @override
  _PatientHomeScreenState createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  int _selectedIndex = 0;

  // Define HealthGuard AI Design System colors
  final Color deepBlue = Color(0xFF2C7DA0);
  final Color softBlue = Color(0xFF61A5C2);
  final Color mintGreen = Color(0xFF9AD4D6);
  final Color lightBackground = Color(0xFFF8F9FA);
  final Color primaryText = Color(0xFF212529);
  final Color secondaryText = Color(0xFF6C757D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackground,
      body: SafeArea(
        child: Column(
          children: [
            _buildCustomAppBar(),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      // Patient Profile Header
                      _buildPatientProfileHeader()
                          .animate()
                          .fadeIn(duration: 500.ms),
                      SizedBox(height: 30),

                      // Health Summary
                      _buildHealthSummary()
                          .animate()
                          .fadeIn(delay: 200.ms, duration: 500.ms),
                      SizedBox(height: 30),

                      // Quick Actions Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Quick Actions',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Roboto',
                              color: primaryText,
                              letterSpacing: 0.3,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // View all actions
                            },
                            child: Text(
                              'View All',
                              style: TextStyle(
                                color: deepBlue,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                        ],
                      ).animate().fadeIn(delay: 300.ms, duration: 500.ms),
                      SizedBox(height: 16),

                      // Quick Actions Grid
                      _buildQuickActionsGrid()
                          .animate()
                          .fadeIn(delay: 400.ms, duration: 500.ms),
                      SizedBox(height: 30),

                      // Recent Medical Records
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Recent Medical Records',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'Roboto',
                              color: primaryText,
                              letterSpacing: 0.3,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // View all records
                            },
                            child: Text(
                              'View All',
                              style: TextStyle(
                                color: deepBlue,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Roboto',
                              ),
                            ),
                          ),
                        ],
                      ).animate().fadeIn(delay: 500.ms, duration: 500.ms),
                      SizedBox(height: 16),

                      // Recent Medical Records List
                      _buildRecentMedicalRecords()
                          .animate()
                          .fadeIn(delay: 600.ms, duration: 500.ms),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: deepBlue.withOpacity(0.1),
              blurRadius: 20,
              spreadRadius: 0,
              offset: Offset(0, -4),
            ),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            selectedItemColor: deepBlue,
            unselectedItemColor: secondaryText,
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontFamily: 'Roboto',
              fontSize: 12,
            ),
            unselectedLabelStyle: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 12,
            ),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home_rounded),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.medical_services_outlined),
                activeIcon: Icon(Icons.medical_services_rounded),
                label: 'Medical',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_outlined),
                activeIcon: Icon(Icons.chat_rounded),
                label: 'Consult',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                activeIcon: Icon(Icons.person_rounded),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomAppBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: deepBlue.withOpacity(0.05),
            offset: Offset(0, 4),
            blurRadius: 15,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: mintGreen.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.health_and_safety_rounded,
                  color: deepBlue,
                  size: 24,
                ),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'HealthGuard AI',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Roboto',
                      color: deepBlue,
                      letterSpacing: 0.5,
                    ),
                  ),
                  Text(
                    'Patient Dashboard',
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      color: secondaryText,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  // Search functionality
                },
                icon: Icon(Icons.search_rounded, color: secondaryText),
                splashRadius: 24,
              ),
              IconButton(
                onPressed: () {
                  _showNotificationsDialog();
                },
                icon: Stack(
                  children: [
                    Icon(Icons.notifications_outlined, color: secondaryText),
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: BoxConstraints(
                          minWidth: 8,
                          minHeight: 8,
                        ),
                      ),
                    ),
                  ],
                ),
                splashRadius: 24,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPatientProfileHeader() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            deepBlue,
            softBlue,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: deepBlue.withOpacity(0.3),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: 36,
                  backgroundColor: mintGreen.withOpacity(0.3),
                  child: Text(
                    widget.patient.name[0],
                    style: TextStyle(
                      color: deepBlue,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.patient.name,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.badge_outlined,
                          color: Colors.white.withOpacity(0.7),
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'ID: ${widget.patient.id}',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.person_outline,
                          color: Colors.white.withOpacity(0.7),
                          size: 16,
                        ),
                        SizedBox(width: 4),
                        Text(
                          '${widget.patient.age} years, ${widget.patient.gender}',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontFamily: 'Roboto',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              _buildPatientInfoItem(
                icon: Icons.bloodtype_outlined,
                label: 'Blood Type',
                value: widget.patient.bloodGroup,
              ),
              SizedBox(width: 16),
              _buildPatientInfoItem(
                icon: Icons.medical_information_outlined,
                label: 'Medical History',
                value: 'Hypertension',
              ),
              SizedBox(width: 16),
              _buildPatientInfoItem(
                icon: Icons.calendar_today_outlined,
                label: 'Last Visit',
                value: 'Mar 15',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPatientInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 16,
                  color: Colors.white.withOpacity(0.7),
                ),
                SizedBox(width: 4),
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 12,
                    fontFamily: 'Roboto',
                  ),
                ),
              ],
            ),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 14,
                fontFamily: 'Roboto',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthSummary() {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: deepBlue.withOpacity(0.08),
            blurRadius: 15,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Health Summary',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: primaryText,
                  fontFamily: 'Roboto',
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: mintGreen.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Good',
                  style: TextStyle(
                    color: deepBlue,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    fontFamily: 'Roboto',
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              _buildHealthMetricItem(
                icon: Icons.favorite_outline,
                label: 'Heart Rate',
                value: '72 bpm',
                color: Colors.red.shade400,
              ),
              SizedBox(width: 16),
              _buildHealthMetricItem(
                icon: Icons.thermostat_outlined,
                label: 'Temperature',
                value: '37.2°C',
                color: Colors.orange.shade400,
              ),
              SizedBox(width: 16),
              _buildHealthMetricItem(
                icon: Icons.filter_drama_outlined,
                label: 'Oxygen',
                value: '98%',
                color: Colors.blue.shade400,
              ),
            ],
          ),
          SizedBox(height: 16),
          Divider(color: Colors.grey.withOpacity(0.2)),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Next Screening:',
                style: TextStyle(
                  color: secondaryText,
                  fontFamily: 'Roboto',
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.event_outlined,
                    size: 16,
                    color: deepBlue,
                  ),
                  SizedBox(width: 4),
                  Text(
                    'TB Follow-up on April 5, 2024',
                    style: TextStyle(
                      color: deepBlue,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHealthMetricItem({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 22,
              color: color,
            ),
            SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: primaryText,
                fontFamily: 'Roboto',
              ),
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: secondaryText,
                fontFamily: 'Roboto',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionsGrid() {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 0.9,
      children: [
        _buildQuickActionItem(
          icon: Icons.description_outlined,
          label: 'My Reports',
          color: softBlue,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ReportScreen(
                  patient: Patient(
                    id: widget.patient.id,
                    name: widget.patient.name,
                    age: widget.patient.age,
                    gender: widget.patient.gender,
                    contact: '9876543210', // Dummy contact
                  ),
                  symptoms: [
                    'Persistent Cough',
                    'Fever',
                    'Night Sweats',
                    'Chest Pain',
                  ], // Dummy symptoms
                  diagnosisResults: {
                    'tb': 0.85,
                    'malaria': 0.92,
                  }, // Dummy diagnosis results
                  timestamp: DateTime.now(),
                ),
              ),
            );
          },
        ),
        _buildQuickActionItem(
          icon: Icons.calendar_today_outlined,
          label: 'Appointments',
          color: Colors.purple.shade300,
          onTap: () {
            // Navigate to appointments screen
          },
        ),
        _buildQuickActionItem(
          icon: Icons.medication_outlined,
          label: 'Prescriptions',
          color: Colors.orange.shade300,
          onTap: () {
            // Navigate to prescriptions screen
          },
        ),
        _buildQuickActionItem(
          icon: Icons.chat_outlined,
          label: 'Consult',
          color: Colors.green.shade300,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PatientTelemedicineScreen(
                  patient: PatientCase(
                    // id: widget.patient.id,
                    name: widget.patient.name,
                    age: widget.patient.age,
                    gender: widget.patient.gender,
                    bloodGroup: widget.patient.bloodGroup,
                    condition: 'Follow-up for TB Treatment', // Dummy condition
                    urgency: 'High', // Dummy urgency
                    lastUpdated: '2h ago', // Dummy last updated time
                    consultationCount: 3, // Dummy consultation count
                    nextMeeting: DateTime.now()
                        .add(const Duration(days: 7)), // Dummy next meeting
                    isCompleted: false, patientId: '',
                  ),
                  doctorName: 'Dr. Ramesh Kumar', // Dummy doctor name
                  doctorSpecialty: 'Pulmonologist', // Dummy doctor specialty
                ),
              ),
            );
          },
        ),
        _buildQuickActionItem(
          icon: Icons.notifications_active_outlined,
          label: 'Reminders',
          color: Colors.red.shade300,
          onTap: () {
            // Manage medical reminders
          },
        ),
        _buildQuickActionItem(
          icon: Icons.help_outline,
          label: 'Support',
          color: Colors.teal.shade300,
          onTap: () {
            // Open support chat
          },
        ),
      ],
    );
  }

  Widget _buildQuickActionItem({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.15),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),
            SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: primaryText,
                fontFamily: 'Roboto',
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentMedicalRecords() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: deepBlue.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            _buildMedicalRecordItem(
              date: 'March 15, 2024',
              type: 'TB Screening',
              status: 'Completed',
              icon: Icons.check_circle_outline,
              statusColor: Colors.green,
            ),
            Divider(
                height: 1, thickness: 1, color: Colors.grey.withOpacity(0.1)),
            _buildMedicalRecordItem(
              date: 'February 22, 2024',
              type: 'Annual Checkup',
              status: 'Reviewed',
              icon: Icons.task_alt,
              statusColor: Colors.orange,
            ),
            Divider(
                height: 1, thickness: 1, color: Colors.grey.withOpacity(0.1)),
            _buildMedicalRecordItem(
              date: 'January 10, 2024',
              type: 'Blood Test',
              status: 'Completed',
              icon: Icons.check_circle_outline,
              statusColor: Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicalRecordItem({
    required String date,
    required String type,
    required String status,
    required IconData icon,
    required Color statusColor,
  }) {
    return InkWell(
      onTap: () {
        // Navigate to detailed record
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: deepBlue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.medical_information_outlined,
                color: deepBlue,
                size: 24,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: primaryText,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    date,
                    style: TextStyle(
                      color: secondaryText,
                      fontSize: 14,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    size: 14,
                    color: statusColor,
                  ),
                  SizedBox(width: 4),
                  Text(
                    status,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      fontFamily: 'Roboto',
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

  void _showNotificationsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.notifications, color: deepBlue),
            SizedBox(width: 12),
            Text(
              'Notifications',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: primaryText,
                fontFamily: 'Roboto',
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        content: Container(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildNotificationItem(
                title: 'Upcoming Appointment',
                subtitle: 'TB Follow-up on April 5, 2024',
                icon: Icons.calendar_today,
                iconColor: deepBlue,
              ),
              Divider(),
              _buildNotificationItem(
                title: 'Test Results Available',
                subtitle: 'Recent Blood Test Results Ready',
                icon: Icons.medical_services,
                iconColor: Colors.green,
              ),
              Divider(),
              _buildNotificationItem(
                title: 'Medication Reminder',
                subtitle: 'Take Hypertension medicine today',
                icon: Icons.medication,
                iconColor: Colors.orange,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            style: TextButton.styleFrom(
              foregroundColor: secondaryText,
            ),
            child: Text(
              'Close',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Mark all as read
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: deepBlue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            child: Text(
              'Mark All as Read',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color iconColor,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      leading: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: iconColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: iconColor),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 16,
          fontFamily: 'Roboto',
          color: primaryText,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: secondaryText,
          fontFamily: 'Roboto',
        ),
      ),
      onTap: () {
        Navigator.of(context).pop();
        // Handle notification interaction
      },
    );
  }
}
