import 'dart:developer';
import 'package:document_helper_app/auth/auth_service.dart';
import 'package:document_helper_app/screens/Forgot_Password.dart';
import 'package:document_helper_app/screens/admin.dart';
import 'package:document_helper_app/screens/main_navigation.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  final Function(bool)? onThemeChanged; // Optional theme toggle

  const LoginScreen({super.key, this.onThemeChanged});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthService _auth = AuthService();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Admin fixed credentials
    const String adminEmail = "john@gmail.com";
    const String adminPassword = "john123";

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome Back!",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // Email field
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            const SizedBox(height: 20),

            // Password field
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
              ),
            ),
            const SizedBox(height: 30),

            // Login Button
            CustomButton(
              text: "Login",
              onPressed: () async {
                final email = emailController.text.trim();
                final password = passwordController.text.trim();

                // Admin login
                if (email == adminEmail && password == adminPassword) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => AdminPanel(
                        onThemeChanged: widget.onThemeChanged ?? (_) {},
                      ),
                    ),
                  );
                  return;
                }

                // Firebase user login
                try {
                  final user = await _auth.loginUserWithEmailAndPassword(
                    email,
                    password,
                  );

                  if (user != null) {
                    log("✅ User Logged In: ${user.email}");
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MainNavigation(), // User panel
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Invalid email or password!"),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                } catch (e) {
                  log("❌ Login Error: $e");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Login failed: $e"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
            ),

            const SizedBox(height: 15),

            // Forgot Password
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ForgotPassword()),
                );
              },
              child: const Text("Forgot Password?"),
            ),

            // Sign Up
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SignUpScreen()),
                );
              },
              child: const Text("Don't have an account? Sign up"),
            ),
          ],
        ),
      ),
    );
  }
}
