import 'package:clinic/diagnosis_input_screen.dart';
import 'package:clinic/patient_registration.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Mock data - replace with actual data source
  final List<PatientRecord> _recentPatients = [
    PatientRecord(
      name: "Rajesh Kumar",
      lastTestDate: "March 25, 2024",
      status: "Pending Review",
    ),
    PatientRecord(
      name: "Priya Sharma",
      lastTestDate: "March 22, 2024",
      status: "Diagnosed",
    ),
    PatientRecord(
      name: "Amit Singh",
      lastTestDate: "March 20, 2024",
      status: "In Progress",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            _buildAppBar(),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildHeaderSection(),
                    SizedBox(height: 24),
                    _buildAnalyticsSection(),
                    SizedBox(height: 24),
                    _buildQuickActionsSection(),
                    SizedBox(height: 24),
                    _buildRecentPatientsSection(),
                    SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF2C7DA0),
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          // Show bottom sheet with quick options
          showModalBottomSheet(
            context: context,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            builder: (context) => _buildQuickActionsSheet(),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      floating: true,
      pinned: true,
      elevation: 0,
      backgroundColor: Color(0xFF2C7DA0),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'HealthGuard AI',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF2C7DA0),
                Color(0xFF61A5C2),
              ],
            ),
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications_outlined, color: Colors.white),
          onPressed: () {
            // Notifications handler
          },
        ),
        IconButton(
          icon: Icon(Icons.account_circle_outlined, color: Colors.white),
          onPressed: () {
            // Profile/Settings handler
          },
        ),
      ],
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome, Clinic Worker',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF212529),
            ),
          ).animate().fadeIn(duration: 300.ms).slideX(begin: -0.1, end: 0),
          SizedBox(height: 5),
          Text(
            'Here\'s your daily overview',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF6C757D),
            ),
          )
              .animate()
              .fadeIn(duration: 300.ms, delay: 100.ms)
              .slideX(begin: -0.1, end: 0),
        ],
      ),
    );
  }

  Widget _buildAnalyticsSection() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Analytics Overview',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF212529),
            ),
          ).animate().fadeIn(duration: 300.ms, delay: 200.ms),
          SizedBox(height: 16),
          Row(
            children: [
              _buildStatCard('Total Patients', '45', Icons.people_alt_rounded),
              SizedBox(width: 16),
              _buildStatCard(
                  'Pending Diagnoses', '12', Icons.pending_actions_rounded),
            ],
          ).animate().fadeIn(duration: 300.ms, delay: 300.ms),
          SizedBox(height: 16),
          _buildLineChart().animate().fadeIn(duration: 300.ms, delay: 400.ms),
        ],
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFF2C7DA0).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: Color(0xFF2C7DA0),
                size: 24,
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF212529),
                  ),
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6C757D),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLineChart() {
    return Container(
      height: 200,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Weekly Diagnoses',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF212529),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const titles = [
                          'Mon',
                          'Tue',
                          'Wed',
                          'Thu',
                          'Fri',
                          'Sat',
                          'Sun'
                        ];
                        final index = value.toInt();
                        if (index >= 0 && index < titles.length) {
                          return Text(
                            titles[index],
                            style: TextStyle(
                              color: Color(0xFF6C757D),
                              fontSize: 12,
                            ),
                          );
                        }
                        return Text('');
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: [
                      FlSpot(0, 2),
                      FlSpot(1, 5),
                      FlSpot(2, 3),
                      FlSpot(3, 7),
                      FlSpot(4, 6),
                      FlSpot(5, 4),
                      FlSpot(6, 8),
                    ],
                    isCurved: true,
                    color: Color(0xFF2C7DA0),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Color(0xFF2C7DA0).withOpacity(0.2),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionsSection() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Color(0xFF212529),
            ),
          ).animate().fadeIn(duration: 300.ms, delay: 500.ms),
          SizedBox(height: 16),
          Row(
            children: [
              _buildQuickActionButton(
                'New Patient',
                Icons.person_add_rounded,
                Color(0xFF2C7DA0),
                PatientRegistrationScreen(),
              ),
              SizedBox(width: 16),
              _buildQuickActionButton(
                'New Diagnosis',
                Icons.medical_services_rounded,
                Color(0xFF9AD4D6),
                DiagnosisInputScreen(),
              ),
            ],
          ).animate().fadeIn(duration: 300.ms, delay: 600.ms),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton(
      String label, IconData icon, Color color, Widget targetScreen) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => targetScreen),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 28),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentPatientsSection() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Patients',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF212529),
                ),
              ),
              TextButton(
                onPressed: () {
                  // View all patients
                },
                child: Text(
                  'View All',
                  style: TextStyle(
                    color: Color(0xFF2C7DA0),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ).animate().fadeIn(duration: 300.ms, delay: 700.ms),
          SizedBox(height: 16),
          _buildRecentPatientsList()
              .animate()
              .fadeIn(duration: 300.ms, delay: 800.ms),
        ],
      ),
    );
  }

  Widget _buildRecentPatientsList() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: _recentPatients.map((patient) {
          return Column(
            children: [
              ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                leading: CircleAvatar(
                  backgroundColor: _getStatusColorLight(patient.status),
                  child: Text(
                    patient.name.substring(0, 1),
                    style: TextStyle(
                      color: _getStatusColor(patient.status),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                title: Text(
                  patient.name,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF212529),
                  ),
                ),
                subtitle: Row(
                  children: [
                    Icon(
                      Icons.calendar_today_rounded,
                      size: 14,
                      color: Color(0xFF6C757D),
                    ),
                    SizedBox(width: 4),
                    Text(
                      patient.lastTestDate,
                      style: TextStyle(color: Color(0xFF6C757D)),
                    ),
                  ],
                ),
                trailing: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: _getStatusColorLight(patient.status),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    patient.status,
                    style: TextStyle(
                      color: _getStatusColor(patient.status),
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                onTap: () {
                  // Patient details navigation
                },
              ),
              if (_recentPatients.indexOf(patient) !=
                  _recentPatients.length - 1)
                Divider(height: 1, indent: 70, endIndent: 20),
            ],
          );
        }).toList(),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Diagnosed':
        return Color(0xFF198754);
      case 'Pending Review':
        return Color(0xFFfd7e14);
      case 'In Progress':
        return Color(0xFF2C7DA0);
      default:
        return Color(0xFF6C757D);
    }
  }

  Color _getStatusColorLight(String status) {
    switch (status) {
      case 'Diagnosed':
        return Color(0xFF198754).withOpacity(0.1);
      case 'Pending Review':
        return Color(0xFFfd7e14).withOpacity(0.1);
      case 'In Progress':
        return Color(0xFF2C7DA0).withOpacity(0.1);
      default:
        return Color(0xFF6C757D).withOpacity(0.1);
    }
  }

  Widget _buildBottomNavigationBar() {
    return BottomAppBar(
      elevation: 10,
      notchMargin: 8,
      shape: CircularNotchedRectangle(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.home_rounded,
                color: Color(0xFF2C7DA0),
                size: 28,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.people_alt_rounded,
                color: Color(0xFF6C757D),
                size: 28,
              ),
              onPressed: () {},
            ),
            SizedBox(width: 40), // Space for FAB
            IconButton(
              icon: Icon(
                Icons.insert_chart_rounded,
                color: Color(0xFF6C757D),
                size: 28,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.settings_rounded,
                color: Color(0xFF6C757D),
                size: 28,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionsSheet() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Quick Actions',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF212529),
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildQuickActionItem(
                'New Patient',
                Icons.person_add_rounded,
                Color(0xFF2C7DA0),
                () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => PatientRegistrationScreen()),
                  );
                },
              ),
              _buildQuickActionItem(
                'New Diagnosis',
                Icons.medical_services_rounded,
                Color(0xFF9AD4D6),
                () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => DiagnosisInputScreen()),
                  );
                },
              ),
              _buildQuickActionItem(
                'Reports',
                Icons.insert_drive_file_rounded,
                Color(0xFF61A5C2),
                () {
                  Navigator.pop(context);
                  // Navigate to reports
                },
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildQuickActionItem(
      String label, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(icon, color: color, size: 30),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: Color(0xFF212529),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class PatientRecord {
  final String name;
  final String lastTestDate;
  final String status;

  PatientRecord({
    required this.name,
    required this.lastTestDate,
    required this.status,
  });
}
