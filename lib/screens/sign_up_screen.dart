import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  String _errorText = '';
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void _signUp() async {
    final String email = _emailController.text.trim();
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();
    final String confirmPassword = _confirmPasswordController.text.trim();

    setState(() {
      _errorText = '';
    });

    if (password.length < 8 ||
        !password.contains(RegExp(r'[A-Z]')) ||
        !password.contains(RegExp(r'[a-z]')) ||
        !password.contains(RegExp(r'[0-9]')) ||
        !password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      setState(() {
        _errorText =
            'Password minimal 8 karakter, kombinasi huruf besar, huruf kecil, angka, dan simbol.';
      });
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        _errorText = 'Password dan konfirmasi password tidak sama.';
      });
      return;
    }

    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'username': username,
        'email': email,
        'role' : 'U',
      });
      Navigator.pushReplacementNamed(
          context, '/signin');
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorText = e.message!;
      });
    } catch (e) {
      setState(() {
        _errorText = 'Terjadi kesalahan. Silakan coba lagi.';
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
 Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 73, 128, 117),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(width: 20),
                  const Text(
                    'SIGN UP',
                    style: TextStyle(fontSize: 50.0, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _usernameController,
                label: 'Username',
                obscureText: false,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _emailController,
                label: 'Email',
                obscureText: false,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _passwordController,
                label: 'Password',
                obscureText: _obscurePassword,
                toggleObscureText: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: _confirmPasswordController,
                label: 'Confirm Password',
                obscureText: _obscureConfirmPassword,
                toggleObscureText: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),
              if (_errorText.isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(
                  _errorText,
                  style: const TextStyle(color: Colors.red),
                ),
              ],
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _signUp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 5.0,
                ),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(color: Colors.black, fontSize: 30),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required bool obscureText,
    void Function()? toggleObscureText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 25, color: Colors.white),
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          cursorColor: const Color(0xFF777777),
          obscureText: obscureText,
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 5.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(
                color: Colors.black,
                width: 5.0,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            hintText: label,
            suffixIcon: toggleObscureText != null
                ? IconButton(
                    onPressed: toggleObscureText,
                    icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility,
                      color: const Color(0xFF777777),
                    ),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
