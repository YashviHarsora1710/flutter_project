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
    {
      'title': 'Ration Card',
      'icon': Icons.receipt_long,
      'docs': ['Address Proof', 'Income Certificate', 'Family details'],
      'steps': [
        'Fill ration card form',
        'Submit documents to local authority',
        'Verification process',
        'Receive ration card',
      ],
    },
    {
      'title': 'Voter ID',
      'icon': Icons.how_to_vote,
      'docs': ['Proof of Age', 'Proof of Address', 'Photograph'],
      'steps': [
        'Fill Form 6 online/offline',
        'Submit required documents',
        'Verification by Booth Level Officer',
        'Receive Voter ID',
      ],
    },
    {
      'title': 'Birth Certificate',
      'icon': Icons.cake,
      'docs': ['Hospital Report', 'Parents ID Proof', 'Address Proof'],
      'steps': [
        'Collect hospital record',
        'Fill birth certificate form',
        'Submit to municipal office',
        'Receive birth certificate',
      ],
    },
    {
      'title': 'Pension Scheme',
      'icon': Icons.account_balance_wallet,
      'docs': ['ID Proof', 'Bank Passbook', 'Age Proof'],
      'steps': [
        'Fill pension scheme application',
        'Attach documents',
        'Submit to local authority',
        'Verification and approval',
      ],
    },
    {
      'title': 'Driving License',
      'icon': Icons.directions_car,
      'docs': ['Age Proof', 'Address Proof', 'Learner License'],
      'steps': [
        'Apply online/offline for driving test',
        'Attach documents',
        'Appear for driving test',
        'Receive Driving License',
      ],
    },
    {
      'title': 'Passport Application',
      'icon': Icons.flight,
      'docs': ['Birth Certificate', 'ID Proof', 'Address Proof'],
      'steps': [
        'Fill passport application form',
        'Attach documents',
        'Book appointment at PSK',
        'Verification and police check',
        'Receive passport',
      ],
    },
    {
      'title': 'Income Certificate',
      'icon': Icons.money,
      'docs': ['ID Proof', 'Address Proof', 'Salary/Income proof'],
      'steps': [
        'Fill income certificate form',
        'Attach income proof documents',
        'Submit at Tehsil office',
        'Verification and issuance',
      ],
    },
    {
      'title': 'Caste Certificate',
      'icon': Icons.assignment_ind,
      'docs': ['ID Proof', 'Address Proof', 'Community Proof'],
      'steps': [
        'Fill caste certificate application',
        'Attach caste/community proof',
        'Submit to Tehsil office',
        'Verification and issuance',
      ],
    },
    {
      'title': 'Disability Certificate',
      'icon': Icons.accessible,
      'docs': ['Medical Report', 'ID Proof', 'Address Proof'],
      'steps': [
        'Visit government hospital',
        'Medical board assessment',
        'Submit application with documents',
        'Receive disability certificate',
      ],
    },
    {
      'title': 'Death Certificate',
      'icon': Icons.sentiment_very_dissatisfied,
      'docs': ['Hospital/Doctor Report', 'Family ID Proof', 'Address Proof'],
      'steps': [
        'Collect death report from hospital',
        'Fill death certificate application',
        'Submit to municipal authority',
        'Receive death certificate',
      ],
    },
    {
      'title': 'Marriage Certificate',
      'icon': Icons.favorite,
      'docs': [
        'Wedding Invitation Card',
        'Bride & Groom ID Proofs',
        'Witness ID Proofs',
      ],
      'steps': [
        'Fill marriage registration form',
        'Submit required documents',
        'Verification of witnesses',
        'Receive marriage certificate',
      ],
    },
    {
      'title': 'Land Record Request',
      'icon': Icons.home_work,
      'docs': ['Land Ownership Proof', 'ID Proof', 'Tax Receipt'],
      'steps': [
        'Fill land record request form',
        'Submit ownership documents',
        'Verification by land records office',
        'Receive land record copy',
      ],
    },
    {
      'title': 'Non-Criminal Certificate',
      'icon': Icons.home_work,
      'docs': [
        'Identity Proof (Aadhar Card / Passport / Voter ID)',
        'Address Proof (Utility Bill / Ration Card)',
        'Passport-size Photographs',
        'Application Form',
        'Affidavit (as required by authority)',
      ],
      'steps': [
        'Collect required documents',
        'Fill the application form for Non-Criminal Certificate',
        'Get the affidavit prepared and notarized',
        'Submit documents to the concerned government office (e.g., Taluka / Collector Office)',
        'Police verification will be conducted',
        'After approval, collect the Non-Criminal Certificate from the office',
      ],
    },
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
              color: theme.brightness == Brightness.light
                  ? const Color.fromARGB(255, 243, 240, 240) // Light mode color
                  : const Color.fromARGB(255, 60, 60, 60), // Dark mode color
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
