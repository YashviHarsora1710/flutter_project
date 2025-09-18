import 'package:flutter/material.dart';

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  List<Map<String, dynamic>> services = [
    {
      'title': 'Apply for PAN',
      'icon': Icons.credit_card,
      'docs': ['Identity Proof', 'Address Proof', 'Photograph'],
      'steps': [
        'Fill PAN application form',
        'Attach documents',
        'Submit at PAN center',
        'Receive PAN card',
      ],
    },
    {
      'title': 'Aadhaar Update',
      'icon': Icons.perm_identity,
      'docs': [
        'Existing Aadhaar Card',
        'Proof of Address',
        'Proof of Identity',
      ],
      'steps': [
        'Visit Aadhaar center',
        'Submit documents',
        'Biometric verification',
        'Receive updated Aadhaar',
      ],
    },
    // ... (rest of services)
  ];

  void _editService(int index) {
    final theme = Theme.of(context);
    final titleController = TextEditingController(
      text: services[index]['title'],
    );
    final docsController = TextEditingController(
      text: services[index]['docs'].join(", "),
    );
    final stepsController = TextEditingController(
      text: services[index]['steps'].join(", "),
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
                decoration: InputDecoration(labelText: "Service Title"),
              ),
              TextField(
                controller: docsController,
                decoration: InputDecoration(
                  labelText: "Documents (comma separated)",
                ),
              ),
              TextField(
                controller: stepsController,
                decoration: InputDecoration(
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
            onPressed: () {
              setState(() {
                services[index]['title'] = titleController.text;
                services[index]['docs'] = docsController.text
                    .split(",")
                    .map((e) => e.trim())
                    .toList();
                services[index]['steps'] = stepsController.text
                    .split(",")
                    .map((e) => e.trim())
                    .toList();
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "Admin Home",
          style: TextStyle(
            color: theme.appBarTheme.foregroundColor ?? Colors.white,
          ),
        ),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              size: 28,
              color: theme.appBarTheme.foregroundColor ?? Colors.white,
            ),
            onPressed: () async {
              final newService = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddServicePage()),
              );
              if (newService != null) setState(() => services.add(newService));
            },
          ),
        ],
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: services.length,
        itemBuilder: (context, index) {
          var service = services[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ServiceDetailPage(
                    title: service["title"],
                    documents: List<String>.from(service["docs"]),
                    steps: List<String>.from(service["steps"]),
                  ),
                ),
              );
            },
            child: Card(
              color: theme.scaffoldBackgroundColor == Colors.white
                  ? Colors.white
                  : const Color.fromARGB(255, 60, 60, 60),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(service['icon'], size: 40, color: primaryColor),
                    Text(
                      service["title"],
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.green),
                          onPressed: () => _editService(index),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () =>
                              setState(() => services.removeAt(index)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ServiceDetailPage extends StatelessWidget {
  final String title;
  final List<String> documents;
  final List<String> steps;

  const ServiceDetailPage({
    required this.title,
    required this.documents,
    required this.steps,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(title),
        backgroundColor: theme.primaryColor,
        foregroundColor: theme.appBarTheme.foregroundColor ?? Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Required Documents:",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ...documents.map(
              (doc) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text("• $doc", style: theme.textTheme.bodyLarge),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Steps:",
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            ...steps.asMap().entries.map(
              (entry) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  "${entry.key + 1}. ${entry.value}",
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddServicePage extends StatefulWidget {
  @override
  _AddServicePageState createState() => _AddServicePageState();
}

class _AddServicePageState extends State<AddServicePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController docsController = TextEditingController();
  final TextEditingController stepsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("Add New Service"),
        backgroundColor: theme.primaryColor,
        foregroundColor: theme.appBarTheme.foregroundColor ?? Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: "Service Title"),
            ),
            TextField(
              controller: docsController,
              decoration: InputDecoration(
                labelText: "Documents (comma separated)",
              ),
            ),
            TextField(
              controller: stepsController,
              decoration: InputDecoration(labelText: "Steps (comma separated)"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
              ),
              child: Text(
                "Save",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                String title = titleController.text;
                List<String> docs = docsController.text
                    .split(",")
                    .map((e) => e.trim())
                    .toList();
                List<String> steps = stepsController.text
                    .split(",")
                    .map((e) => e.trim())
                    .toList();

                Navigator.pop(context, {
                  "title": title,
                  "docs": docs,
                  "steps": steps,
                  "icon": Icons.insert_drive_file,
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
