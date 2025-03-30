import 'package:clinic/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _clinicIdController = TextEditingController();

  bool _isPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF2C7DA0),
              Color(0xFF61A5C2),
              Color(0xFF9AD4D6),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height - 100,
                  ),
                  child: IntrinsicHeight(
                    child: GlassmorphicContainer(
                      width: double.infinity,
                      height: 600,
                      borderRadius: 20,
                      blur: 20,
                      alignment: Alignment.bottomCenter,
                      border: 2,
                      linearGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFffffff).withOpacity(0.1),
                          Color(0xFFffffff).withOpacity(0.05),
                        ],
                      ),
                      borderGradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFffffff).withOpacity(0.5),
                          Color(0xFFffffff).withOpacity(0.5),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              _buildHeader(),
                              const SizedBox(height: 40),
                              _buildEmailInput(),
                              const SizedBox(height: 20),
                              _buildPasswordInput(),
                              const SizedBox(height: 20),
                              _buildClinicIdInput(),
                              const SizedBox(height: 30),
                              _buildLoginButton(context),
                              const SizedBox(height: 20),
                              _buildForgotPassword(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Hero(
          tag: 'logo',
          child: Image.asset(
            'assets/medical_icon.png',
            height: 120,
            width: 120,
          ),
        ).animate(effects: [
          FadeEffect(duration: 500.ms),
          ScaleEffect(duration: 500.ms)
        ]),
        const SizedBox(height: 20),
        Text(
          'HealthGuard AI',
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        ).animate().slideY(duration: 300.ms, begin: 0.5, end: 0),
        Text(
          'Clinic Worker Login',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w300,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailInput() {
    return TextFormField(
      controller: _emailController,
      style: TextStyle(color: Colors.white),
      decoration: _buildInputDecoration(
        labelText: 'Email',
        icon: Icons.email,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }
        return null;
      },
    ).animate(effects: [
      FadeEffect(duration: 300.ms),
      SlideEffect(duration: 300.ms, begin: Offset(-0.1, 0), end: Offset.zero)
    ]);
  }

  Widget _buildPasswordInput() {
    return TextFormField(
      controller: _passwordController,
      obscureText: !_isPasswordVisible,
      style: TextStyle(color: Colors.white),
      decoration: _buildInputDecoration(
        labelText: 'Password',
        icon: Icons.lock,
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.white70,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }
        return null;
      },
    ).animate(effects: [
      FadeEffect(duration: 300.ms),
      SlideEffect(duration: 300.ms, begin: Offset(0.1, 0), end: Offset.zero)
    ]);
  }

  Widget _buildClinicIdInput() {
    return TextFormField(
      controller: _clinicIdController,
      style: TextStyle(color: Colors.white),
      decoration: _buildInputDecoration(
        labelText: 'Clinic ID',
        icon: Icons.medical_services,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your Clinic ID';
        }
        return null;
      },
    ).animate(effects: [
      FadeEffect(duration: 300.ms),
      SlideEffect(duration: 300.ms, begin: Offset(-0.1, 0), end: Offset.zero)
    ]);
  }

  InputDecoration _buildInputDecoration({
    required String labelText,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(color: Colors.white70),
      prefixIcon: Icon(icon, color: Colors.white70),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.white, width: 2),
      ),
      errorStyle: TextStyle(color: Colors.amber),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white.withOpacity(0.2),
        foregroundColor: Colors.white,
        minimumSize: const Size(double.infinity, 56),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 0,
      ),
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          try {
            final response = await http.post(
              Uri.parse('http://localhost:5000/clinic/login'),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({
                'workerID': _clinicIdController.text,
                'workerPhone': _passwordController.text,
              }),
            );

            final responseData = jsonDecode(response.body);
            if (response.statusCode == 200) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content:
                        Text(responseData['message'] ?? 'Login successful')),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => DashboardScreen()),
              );
            } else {
              print(responseData);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text(responseData['message'] ?? 'Login failed')),
              );
            }
          } catch (e) {
            print(e);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Connection error')),
            );
          }
        }
      },
      child: Text(
        'LOGIN',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
        ),
      ),
    ).animate(effects: [
      FadeEffect(duration: 300.ms),
      ScaleEffect(duration: 300.ms, begin: Offset(0.9, 0.9), end: Offset(1, 1))
    ]);
  }

  Widget _buildForgotPassword() {
    return TextButton(
      onPressed: () {/* Add forgot password logic */},
      child: Text(
        'Forgot Password?',
        style: TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.w600,
        ),
      ),
    ).animate().fadeIn(duration: 300.ms);
  }
}
