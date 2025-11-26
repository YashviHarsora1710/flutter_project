import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  IconData getIconFromTitle(String title) {
    switch (title.toLowerCase()) {
      case "apply for pan":
        return Icons.credit_card;
      case "aadhaar update":
        return Icons.perm_identity;
      case "ration card":
        return Icons.receipt_long;
      case "voter id":
        return Icons.how_to_vote;
      case "birth certificate":
        return Icons.cake;
      case "passport application":
        return Icons.flight;
      case "pension scheme":
        return Icons.account_balance_wallet;
      case "driving license":
        return Icons.directions_car;
      case "income certificate":
        return Icons.money;
      case "caste certificate":
        return Icons.assignment_ind;
      case "disability certificate":
        return Icons.accessible;
      case "death certificate":
        return Icons.sentiment_very_dissatisfied;
      case "marriage certificate":
        return Icons.favorite;
      case "land record request":
        return Icons.home_work;
      case "non-criminal certificate":
        return Icons.home_work;
      default:
        return Icons.insert_drive_file;
    }
  }

  void _editService(DocumentSnapshot serviceDoc) {
    final theme = Theme.of(context);
    final titleController = TextEditingController(text: serviceDoc['title']);
    final docsController = TextEditingController(
      text: (serviceDoc['docs'] as List).join(", "),
    );
    final stepsController = TextEditingController(
      text: (serviceDoc['steps'] as List).join(", "),
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.scaffoldBackgroundColor,
        title: Text("Edit Service", style: theme.textTheme.titleMedium),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: "Service Title"),
              ),
              TextField(
                controller: docsController,
                decoration: const InputDecoration(
                  labelText: "Documents (comma separated)",
                ),
              ),
              TextField(
                controller: stepsController,
                decoration: const InputDecoration(
                  labelText: "Steps (comma separated)",
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel", style: theme.textTheme.bodyLarge),
          ),
          ElevatedButton(
            onPressed: () async {
              String newTitle = titleController.text;
              await _firestore
                  .collection('services')
                  .doc(serviceDoc.id)
                  .update({
                    "title": newTitle,
                    "docs": docsController.text
                        .split(",")
                        .map((e) => e.trim())
                        .toList(),
                    "steps": stepsController.text
                        .split(",")
                        .map((e) => e.trim())
                        .toList(),
                    "icon": getIconFromTitle(newTitle).codePoint.toString(),
                  });
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.primaryColor,
            ),
            child: Text(
              "Save",
              style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _deleteService(String docId) async {
    await _firestore.collection('services').doc(docId).delete();
  }

  void _addService() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AddServicePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Home"),
        foregroundColor: Colors.white,
        backgroundColor: primaryColor,
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: _addService),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('services').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return const Center(child: CircularProgressIndicator());
          final services = snapshot.data!.docs;

          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: services.length,
            itemBuilder: (context, index) {
              final service = services[index];
              final iconData = IconData(
                int.tryParse(service['icon'] ?? '') ??
                    Icons.insert_drive_file.codePoint,
                fontFamily: 'MaterialIcons',
              );

              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(iconData, size: 40),
                      Text(
                        service['title'],
                        textAlign: TextAlign.center,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.green),
                            onPressed: () => _editService(service),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteService(service.id),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class AddServicePage extends StatefulWidget {
  const AddServicePage({super.key});

  @override
  State<AddServicePage> createState() => _AddServicePageState();
}

class _AddServicePageState extends State<AddServicePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController docsController = TextEditingController();
  final TextEditingController stepsController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  IconData getIconFromTitle(String title) {
    switch (title.toLowerCase()) {
      case "apply for pan":
        return Icons.credit_card;
      case "aadhaar update":
        return Icons.perm_identity;
      case "ration card":
        return Icons.receipt_long;
      case "voter id":
        return Icons.how_to_vote;
      case "birth certificate":
        return Icons.cake;
      case "passport application":
        return Icons.flight;
      case "pension scheme":
        return Icons.account_balance_wallet;
      case "driving license":
        return Icons.directions_car;
      case "income certificate":
        return Icons.money;
      case "caste certificate":
        return Icons.assignment_ind;
      case "disability certificate":
        return Icons.accessible;
      case "death certificate":
        return Icons.sentiment_very_dissatisfied;
      case "marriage certificate":
        return Icons.favorite;
      case "land record request":
        return Icons.home_work;
      case "non-criminal certificate":
        return Icons.home_work;
      default:
        return Icons.insert_drive_file;
    }
  }

  void _saveService() async {
    String title = titleController.text;
    await _firestore.collection('services').add({
      "title": title,
      "docs": docsController.text.split(",").map((e) => e.trim()).toList(),
      "steps": stepsController.text.split(",").map((e) => e.trim()).toList(),
      "icon": getIconFromTitle(title).codePoint.toString(),
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Service"),
        backgroundColor: theme.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Service Title"),
            ),
            TextField(
              controller: docsController,
              decoration: const InputDecoration(
                labelText: "Documents (comma separated)",
              ),
            ),
            TextField(
              controller: stepsController,
              decoration: const InputDecoration(
                labelText: "Steps (comma separated)",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _saveService, child: const Text("Save")),
          ],
        ),
      ),
    );
  }
}
