import 'package:flutter/material.dart';
import 'package:document_helper_app/screens/service_details_screen.dart';
import 'package:document_helper_app/models/service_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Elegant neutral tones
    const Color backgroundColor = Color(0xFFF9F9F9); // soft white
    const Color cardColor = Color(0xFFEDEDED); // very light grey
    const Color textColor = Colors.black87;
    const Color accentColor = Color(0xFF4C5C68); // elegant dark blue-grey

    /// ✅ Master list with all 14 services
    final List<Map<String, dynamic>> servicesData = [
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

    /// Convert servicesData → ServiceModel list
    final List<ServiceModel> services = servicesData.map((data) {
      return ServiceModel(
        name: data['title'],
        requiredDocuments: List<String>.from(data['docs']),
        procedureSteps: List<String>.from(data['steps']),
      );
    }).toList();

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
                  itemCount: servicesData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    childAspectRatio: 1,
                  ),
                  itemBuilder: (context, index) {
                    final service = servicesData[index]; // for icon + title
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ServiceDetailScreen(
                              service: services[index], // ✅ pass model
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
