import 'package:flutter/material.dart';
import 'package:document_helper_app/screens/scan_screen.dart';
import 'package:document_helper_app/screens/pdf_to_word_screen.dart';
import 'package:document_helper_app/screens/translate_screen.dart';
import 'package:document_helper_app/screens/sign_document.dart';

class ServiceScreenPage extends StatelessWidget {
  const ServiceScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Services'),
        centerTitle: true,
        backgroundColor: isDark
            ? Colors.grey[900]
            : const Color.fromARGB(255, 235, 231, 241),
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          children: [
            ServiceCard(
              title: 'Scan Document',
              icon: Icons.document_scanner,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScanScreen()),
                );
              },
            ),
            ServiceCard(
              title: 'PDF to Word',
              icon: Icons.picture_as_pdf,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PDFToWordScreen(),
                  ),
                );
              },
            ),
            ServiceCard(
              title: 'Translate',
              icon: Icons.translate,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TranslateScreen(),
                  ),
                );
              },
            ),
            ServiceCard(
              title: 'Sign Document',
              icon: Icons.edit_document,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignDocumentScreen(),
                  ),
                );
              },
            ),
            // The following are placeholders (no navigation yet)
            ServiceCard(
              title: 'Compress PDF',
              icon: Icons.compress,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Compress PDF coming soon...')),
                );
              },
            ),
            ServiceCard(
              title: 'Extract Text',
              icon: Icons.text_snippet,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Extract Text coming soon...')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const ServiceCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      color: isDark ? Colors.grey[850] : Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.deepPurple),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
