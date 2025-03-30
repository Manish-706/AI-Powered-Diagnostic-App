import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:clinic/doctor_login_screen.dart';
import 'package:clinic/patient_login.dart';
import 'package:clinic/login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFF2C7DA0).withOpacity(0.9),
                  const Color(0xFF61A5C2).withOpacity(0.7),
                  const Color(0xFF9AD4D6).withOpacity(0.6),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Subtle Geometric Overlay
          Opacity(
            opacity: 0.1,
            child: Image.asset(
              'assets/medical_pattern.png',
              repeat: ImageRepeat.repeat,
            ),
          ),

          // Main Content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Header Section
                    _buildHeader(),

                    const SizedBox(height: 40),

                    // Feature Highlights
                    _buildFeatureHighlights(),

                    const SizedBox(height: 40),

                    // Role Selection Buttons
                    _buildRoleButtons(context),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Hero(
          tag: 'app-logo',
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset(
                'assets/healthcare_hero.png',
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ).animate().fade(duration: 500.ms).scale(duration: 500.ms),
        const SizedBox(height: 20),
        Text(
          'HealthGuard AI',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: 1.5,
            shadows: [
              Shadow(
                blurRadius: 10,
                color: Colors.black26,
                offset: Offset(3, 3),
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(duration: 500.ms)
            .slideY(begin: 0.5, end: 0, duration: 500.ms),
        const SizedBox(height: 10),
        Text(
          'Empowering Healthcare Through AI',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white70,
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.italic,
          ),
        )
            .animate()
            .fadeIn(duration: 500.ms)
            .slideY(begin: 0.5, end: 0, duration: 500.ms),
      ],
    );
  }

  Widget _buildFeatureHighlights() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildFeatureItem(Icons.medical_services, 'Advanced\nDiagnosis'),
          _buildFeatureItem(Icons.analytics, 'AI Analytics'),
          _buildFeatureItem(Icons.security, 'Secure\nReporting'),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 500.ms)
        .scaleXY(begin: 0.9, end: 1, duration: 500.ms);
  }

  Widget _buildFeatureItem(IconData icon, String text) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 40),
        const SizedBox(height: 8),
        Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildRoleButtons(BuildContext context) {
    return Column(
      children: [
        _buildRoleButton(
          context,
          'Clinic Worker',
          Icons.medical_services_rounded,
          const Color(0xFF2C7DA0),
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
          ),
        )
            .animate()
            .fadeIn(duration: 500.ms)
            .slideX(begin: -0.1, end: 0, duration: 500.ms),
        const SizedBox(height: 20),
        _buildRoleButton(
          context,
          'Doctor',
          Icons.person_rounded,
          const Color(0xFF61A5C2),
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => DoctorLoginScreen()),
          ),
        )
            .animate()
            .fadeIn(duration: 500.ms)
            .slideX(begin: 0.1, end: 0, duration: 500.ms),
        const SizedBox(height: 20),
        _buildRoleButton(
          context,
          'Patient',
          Icons.local_hospital_rounded,
          const Color(0xFF9AD4D6),
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => PatientLoginScreen()),
          ),
        )
            .animate()
            .fadeIn(duration: 500.ms)
            .slideX(begin: -0.1, end: 0, duration: 500.ms),
      ],
    );
  }

  Widget _buildRoleButton(BuildContext context, String text, IconData icon,
      Color color, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 28),
        label: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.1,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          minimumSize: const Size(double.infinity, 70),
          elevation: 0,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
