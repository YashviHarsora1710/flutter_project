import 'package:document_helper_app/screens/admin_feedback_screen.dart';
import 'package:document_helper_app/screens/admin_home_screen.dart';
import 'package:document_helper_app/screens/admin_profile_screen.dart';
import 'package:document_helper_app/screens/admin_services_screen.dart';
import 'package:flutter/material.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      body: Column(
        children: [
          // ✅ Custom Gradient Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 55, 77, 75),
                  Color.fromARGB(255, 55, 77, 75),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Admin Panel",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // ✅ Service Cards List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildServiceCard(
                  context,
                  icon: Icons.home,
                  title: "Home",
                  subtitle: "Go to Admin Home",
                  page: AdminHomeScreen(),
                  gradient: [Colors.purpleAccent, Colors.deepPurple],
                ),
                _buildServiceCard(
                  context,
                  icon: Icons.build,
                  title: "Services",
                  subtitle: "Manage available services",
                  page: const AdminServicesScreen(),
                  gradient: [Colors.orange, Colors.deepOrangeAccent],
                ),
                _buildServiceCard(
                  context,
                  icon: Icons.feedback,
                  title: "Feedback",
                  subtitle: "View user feedback",
                  page: const AdminFeedbackScreen(),
                  gradient: [Colors.green, Colors.teal],
                ),
                _buildServiceCard(
                  context,
                  icon: Icons.person,
                  title: "Profile",
                  subtitle: "Manage your profile",
                  page: const ProfileScreen(),
                  gradient: [Colors.blueAccent, Colors.indigo],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget page,
    required List<Color> gradient,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      },
      child: Card(
        elevation: 6,
        shadowColor: Colors.black26,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(vertical: 12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // ✅ Gradient Icon Circle
              Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(colors: gradient),
                ),
                child: Icon(icon, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),

              // ✅ Title & Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

              // ✅ Arrow
              const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }
}
