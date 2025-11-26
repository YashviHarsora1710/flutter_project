import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:document_helper_app/models/service_model.dart';
import 'package:document_helper_app/screens/service_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchQuery = "";

  IconData _getIconFromString(String iconString) {
    // Convert string codePoint to IconData, default to insert_drive_file
    try {
      return IconData(int.parse(iconString), fontFamily: 'MaterialIcons');
    } catch (e) {
      return Icons.insert_drive_file;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // App colors
    final Color accentColor = theme.colorScheme.primary;
    final Color cardColor = theme.cardColor;
    final Color textColor =
        theme.textTheme.bodyLarge?.color ??
        const Color.fromARGB(255, 28, 28, 28);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),

            // App Name
            Text(
              'Document Helper App',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: accentColor,
              ),
            ),

            const SizedBox(height: 10),

            // Welcome Message
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Need help with documents? Apply, track, and manage with ease.',
                style: TextStyle(fontSize: 16, color: textColor),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 20),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search services...",
                  hintStyle: TextStyle(color: textColor.withOpacity(0.6)),
                  prefixIcon: Icon(Icons.search, color: accentColor),
                  filled: true,
                  fillColor:
                      theme.inputDecorationTheme.fillColor ??
                      (theme.brightness == Brightness.dark
                          ? Colors.grey[800]
                          : Colors.white),
                  contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) => setState(() => searchQuery = value),
                cursorColor: accentColor,
                style: TextStyle(color: textColor),
              ),
            ),

            const SizedBox(height: 20),

            // Services Grid
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('services')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Center(
                      child: CircularProgressIndicator(color: accentColor),
                    );

                  final services = snapshot.data!.docs
                      .where(
                        (service) => service['title'].toLowerCase().contains(
                          searchQuery.toLowerCase(),
                        ),
                      )
                      .toList();

                  return GridView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: services.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                          childAspectRatio: 1,
                        ),
                    itemBuilder: (context, index) {
                      final service = services[index];
                      final IconData iconData = _getIconFromString(
                        service['icon'].toString(),
                      );

                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ServiceDetailScreen(
                                service: ServiceModel(
                                  name: service['title'],
                                  requiredDocuments: List<String>.from(
                                    service['docs'],
                                  ),
                                  procedureSteps: List<String>.from(
                                    service['steps'],
                                  ),
                                ),
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
                                color: theme.shadowColor.withOpacity(0.1),
                                blurRadius: 4,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(iconData, size: 40, color: accentColor),
                              const SizedBox(height: 10),
                              Text(
                                service['title'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
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
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
