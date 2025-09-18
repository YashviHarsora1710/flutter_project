import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

// --- OTP Request Page ---
class RequestOtpPage extends StatefulWidget {
  const RequestOtpPage({super.key});

  @override
  State<RequestOtpPage> createState() => _RequestOtpPageState();
}

class _RequestOtpPageState extends State<RequestOtpPage> {
  final TextEditingController _emailController = TextEditingController();

  Future<void> _sendOtp() async {
    final email = _emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      Fluttertoast.showToast(msg: 'Enter a valid email');
      return;
    }

    // Generate OTP
    final otp = (Random().nextInt(900000) + 100000).toString();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('otp', otp);
    await prefs.setString('otp_email', email);

    // DEMO: print OTP to console
    // ignore: avoid_print
    print('Generated OTP for $email: $otp');

    Fluttertoast.showToast(msg: 'OTP generated (check console)');

    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const VerifyOtpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Request OTP")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "Enter your email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _sendOtp, child: const Text("Send OTP")),
          ],
        ),
      ),
    );
  }
}

// --- Verify OTP Page ---
class VerifyOtpPage extends StatefulWidget {
  const VerifyOtpPage({super.key});

  @override
  State<VerifyOtpPage> createState() => _VerifyOtpPageState();
}

class _VerifyOtpPageState extends State<VerifyOtpPage> {
  final TextEditingController _otpController = TextEditingController();

  Future<void> _verifyOtp() async {
    final inputOtp = _otpController.text.trim();
    final prefs = await SharedPreferences.getInstance();
    final savedOtp = prefs.getString('otp');

    if (inputOtp == savedOtp) {
      Fluttertoast.showToast(msg: "OTP verified!");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ResetPasswordPage()),
      );
    } else {
      Fluttertoast.showToast(msg: "Invalid OTP");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Verify OTP")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _otpController,
              decoration: const InputDecoration(
                labelText: "Enter OTP",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _verifyOtp, child: const Text("Verify")),
          ],
        ),
      ),
    );
  }
}

// --- Reset Password Page ---
class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _confirmController = TextEditingController();

  Future<void> _savePassword() async {
    final p1 = _passController.text.trim();
    final p2 = _confirmController.text.trim();

    if (p1.isEmpty || p2.isEmpty) {
      Fluttertoast.showToast(msg: "Fill all fields");
      return;
    }
    if (p1 != p2) {
      Fluttertoast.showToast(msg: "Passwords do not match");
      return;
    }

    Fluttertoast.showToast(msg: "Password reset successful (demo)");
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _passController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "New Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _confirmController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Confirm Password",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _savePassword, child: const Text("Save")),
          ],
        ),
      ),
    );
  }
}
