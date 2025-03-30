import 'package:clinic/patient_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

// Patient Model
class PatientModel {
  final String id;
  final String name;
  final int age;
  final String gender;
  final String contact;
  final String email;
  final String bloodGroup;
  final String medicalHistory;

  PatientModel({
    required this.id,
    required this.name,
    required this.age,
    required this.gender,
    required this.contact,
    required this.email,
    required this.bloodGroup,
    required this.medicalHistory,
  });
}

// Dummy Patient Data
PatientModel dummyPatient = PatientModel(
  id: 'PT001',
  name: 'Rajesh Kumar',
  age: 35,
  gender: 'Male',
  contact: '9876543210',
  email: 'rajesh.kumar@example.com',
  bloodGroup: 'B+',
  medicalHistory: 'Hypertension, Annual TB Screening',
);

class PatientLoginScreen extends StatefulWidget {
  @override
  _PatientLoginScreenState createState() => _PatientLoginScreenState();
}

class _PatientLoginScreenState extends State<PatientLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  // Define HealthGuard AI Design System colors
  final Color deepBlue = Color(0xFF2C7DA0);
  final Color softBlue = Color(0xFF61A5C2);
  final Color mintGreen = Color(0xFF9AD4D6);
  final Color lightBackground = Color(0xFFF8F9FA);
  final Color primaryText = Color(0xFF212529);
  final Color secondaryText = Color(0xFF6C757D);

  void _login() {
    // Dummy login validation
    if (_emailController.text == 'patient@example.com' &&
        _passwordController.text == 'password123') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => PatientHomeScreen(patient: dummyPatient),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Invalid credentials',
            style: TextStyle(
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.all(16),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackground,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Color(0xFFF8F9FA),
              Color(0xFFF1F3F5),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo and App Title
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: deepBlue.withOpacity(0.1),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Image.asset(
                            'assets/medical_icon.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ).animate().fadeIn(duration: 600.ms).slideY(
                            begin: -0.2,
                            end: 0,
                            curve: Curves.easeOutQuad,
                            duration: 600.ms,
                          ),
                      SizedBox(height: 24),
                      Text(
                        'HealthGuard AI',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          color: deepBlue,
                          fontFamily: 'Roboto',
                          letterSpacing: 1.2,
                        ),
                      ).animate().fadeIn(
                            delay: 200.ms,
                            duration: 600.ms,
                          ),
                      SizedBox(height: 8),
                      Text(
                        'Rural Clinic Diagnostics',
                        style: TextStyle(
                          fontSize: 16,
                          color: secondaryText,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                      ).animate().fadeIn(
                            delay: 400.ms,
                            duration: 600.ms,
                          ),
                    ],
                  ),
                ),
                SizedBox(height: 60),

                // Welcome Message
                Text(
                  'Welcome Back',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: primaryText,
                    fontFamily: 'Roboto',
                  ),
                ).animate().fadeIn(delay: 600.ms, duration: 600.ms),
                SizedBox(height: 8),
                Text(
                  'Sign in to continue to your patient portal',
                  style: TextStyle(
                    fontSize: 14,
                    color: secondaryText,
                    fontFamily: 'Roboto',
                  ),
                ).animate().fadeIn(delay: 700.ms, duration: 600.ms),
                SizedBox(height: 32),

                // Login Form
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Email Field
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: deepBlue.withOpacity(0.05),
                              blurRadius: 12,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: _emailController,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            color: primaryText,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Email Address',
                            labelStyle: TextStyle(
                              color: secondaryText,
                              fontFamily: 'Roboto',
                              fontSize: 14,
                            ),
                            floatingLabelStyle: TextStyle(
                              color: deepBlue,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w600,
                            ),
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: softBlue,
                              size: 22,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: deepBlue, width: 1.5),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.5),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 20,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                        ),
                      )
                          .animate()
                          .fadeIn(delay: 800.ms, duration: 600.ms)
                          .slideY(
                            begin: 0.2,
                            end: 0,
                            delay: 800.ms,
                            duration: 600.ms,
                          ),
                      SizedBox(height: 20),

                      // Password Field
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: deepBlue.withOpacity(0.05),
                              blurRadius: 12,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: 16,
                            color: primaryText,
                          ),
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                              color: secondaryText,
                              fontFamily: 'Roboto',
                              fontSize: 14,
                            ),
                            floatingLabelStyle: TextStyle(
                              color: deepBlue,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w600,
                            ),
                            prefixIcon: Icon(
                              Icons.lock_outline,
                              color: softBlue,
                              size: 22,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: secondaryText,
                                size: 22,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: deepBlue, width: 1.5),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.5),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 20,
                              horizontal: 20,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                      )
                          .animate()
                          .fadeIn(delay: 900.ms, duration: 600.ms)
                          .slideY(
                            begin: 0.2,
                            end: 0,
                            delay: 900.ms,
                            duration: 600.ms,
                          ),
                      SizedBox(height: 16),

                      // Forgot Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Implement forgot password functionality
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: softBlue,
                            textStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          child: Text('Forgot Password?'),
                        ),
                      ).animate().fadeIn(delay: 1000.ms, duration: 600.ms),
                      SizedBox(height: 32),

                      // Login Button
                      Container(
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: deepBlue.withOpacity(0.25),
                              blurRadius: 12,
                              offset: Offset(0, 6),
                            ),
                          ],
                          gradient: LinearGradient(
                            colors: [deepBlue, softBlue],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _login();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 16),
                            minimumSize: Size(double.infinity, 56),
                            elevation: 0,
                          ),
                          child: Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5,
                              fontFamily: 'Roboto',
                            ),
                          ),
                        ),
                      )
                          .animate()
                          .fadeIn(delay: 1100.ms, duration: 600.ms)
                          .scale(
                            begin: Offset(0.95, 0.95),
                            end: Offset(1, 1),
                            delay: 1100.ms,
                            duration: 600.ms,
                            curve: Curves.easeOutBack,
                          ),
                    ],
                  ),
                ),
                SizedBox(height: 40),

                // Additional Info
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.health_and_safety,
                      size: 16,
                      color: mintGreen,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Secure Healthcare Login',
                      style: TextStyle(
                        fontSize: 14,
                        color: secondaryText,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ).animate().fadeIn(delay: 1200.ms, duration: 600.ms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
