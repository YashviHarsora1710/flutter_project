import 'package:document_helper_app/screens/admin_feedback_screen.dart';
import 'package:document_helper_app/screens/admin_home_screen.dart';
import 'package:document_helper_app/screens/admin_profile_screen.dart';
import 'package:document_helper_app/screens/admin_services_screen.dart';
import 'package:flutter/material.dart';

import 'admin_pickup_screen.dart';

class AdminPanel extends StatelessWidget {
  final Function(bool darkMode) onThemeChanged;
  const AdminPanel({super.key, required this.onThemeChanged});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, //  Theme aware
      body: Column(
        children: [
          // Themed Gradient Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.colorScheme.primary,
                  theme.colorScheme.secondary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Admin Panel",
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          //  Service Cards
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _buildServiceCard(
                  context,
                  icon: Icons.home,
                  title: "Home",
                  subtitle: "Go to Admin Home",
                  page: const AdminHomeScreen(),
                ),
                _buildServiceCard(
                  context,
                  icon: Icons.build,
                  title: "Services",
                  subtitle: "Manage available services",
                  page: const AdminServicesScreen(),
                ),
                _buildServiceCard(
                  context,
                  icon: Icons.local_shipping,
                  title: "Pick Up",
                  subtitle: "Manage pickup requests",
                  page: const AdminPickupScreen(),
                ),
                _buildServiceCard(
                  context,
                  icon: Icons.feedback,
                  title: "Feedback",
                  subtitle: "View user feedback",
                  page: const AdminFeedbackScreen(),
                ),
                _buildServiceCard(
                  context,
                  icon: Icons.person,
                  title: "Profile",
                  subtitle: "Manage your profile",
                  page: ProfileScreen(onThemeChanged: onThemeChanged),
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
  }) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      },
      child: Card(
        elevation: 6,
        shadowColor: theme.shadowColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        margin: const EdgeInsets.symmetric(vertical: 12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              //  Themed Icon Circle
              Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      theme.colorScheme.primary,
                      theme.colorScheme.secondary,
                    ],
                  ),
                ),
                child: Icon(icon, color: theme.colorScheme.onPrimary, size: 28),
              ),
              const SizedBox(width: 16),

              // Title & Subtitle
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.hintColor,
                      ),
                    ),
                  ],
                ),
              ),

              Icon(
                Icons.arrow_forward_ios,
                size: 18,
                color: theme.iconTheme.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
