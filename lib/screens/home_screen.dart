import 'package:flutter/material.dart';
<<<<<<< HEAD
=======
import 'package:document_helper_app/screens/service_details_screen.dart';
>>>>>>> yashvi

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Welcome to Lost Document Helper!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              "This app helps you manage your lost & found documents.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: () {
                // Placeholder action
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Report Lost Document")),
                );
              },
              icon: const Icon(Icons.report),
              label: const Text("Report Lost Document"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                // Placeholder action
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("View Found Documents")),
                );
              },
              icon: const Icon(Icons.search),
              label: const Text("View Found Documents"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50),
=======
    // Elegant neutral tones
    const Color backgroundColor = Color(0xFFF9F9F9); // soft white
    const Color cardColor = Color(0xFFEDEDED); // very light grey
    const Color textColor = Colors.black87;
    const Color accentColor = Color(0xFF4C5C68); // elegant dark blue-grey

    final List<Map<String, dynamic>> services = [
      {'title': 'Apply for PAN', 'icon': Icons.credit_card},
      {'title': 'Aadhaar Update', 'icon': Icons.perm_identity},
      {'title': 'Ration Card', 'icon': Icons.receipt_long},
      {'title': 'Voter ID', 'icon': Icons.how_to_vote},
      {'title': 'Birth Certificate', 'icon': Icons.cake},
      {'title': 'Pension Scheme', 'icon': Icons.account_balance_wallet},
      {'title': 'Driving License', 'icon': Icons.directions_car},
      {'title': 'Passport Application', 'icon': Icons.flight},
      {'title': 'Income Certificate', 'icon': Icons.money},
      {'title': 'Caste Certificate', 'icon': Icons.assignment_ind},
      {'title': 'Disability Certificate', 'icon': Icons.accessible},
      {'title': 'Death Certificate', 'icon': Icons.sentiment_very_dissatisfied},
      {'title': 'Marriage Certificate', 'icon': Icons.favorite},
      {'title': 'Land Record Request', 'icon': Icons.home_work},
    ];

    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),

            // App Name
            const Text(
              'Document Helper App',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: accentColor,
              ),
            ),

            const SizedBox(height: 10),

            // Welcome Message
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Need help with documents?\nWe’re here to make it easier — apply, track, and manage with ease.',
                style: TextStyle(fontSize: 16, color: textColor),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 30),

            // Services Grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: GridView.builder(
                  itemCount: services.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final service = services[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ServiceDetailScreen(
                              serviceName: service['title'],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(service['icon'], size: 40, color: accentColor),
                            const SizedBox(height: 10),
                            Text(
                              service['title'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
>>>>>>> yashvi
              ),
            ),
          ],
        ),
      ),
    );
  }
}
