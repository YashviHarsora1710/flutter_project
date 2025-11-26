import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'admin_pickup_detail_screen.dart';

class AdminPickupScreen extends StatelessWidget {
  const AdminPickupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _firestore = FirebaseFirestore.instance;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin - Pick-Up Requests"),
        backgroundColor: theme.primaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection("pickup_drop").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;
          if (docs.isEmpty)
            return const Center(child: Text("No requests found"));

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final docId = docs[index].id;

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: const Color(0xFF4C5C68),
                    foregroundColor: Colors.white,
                    child: Text(data["name"][0]),
                  ),
                  title: Text(
                    data["name"],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      _firestore.collection("pickup_drop").doc(docId).delete();
                    },
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PickupDetailScreen(
                          request: {
                            "name": data["name"],
                            "phone": data["phone"],
                            "pickup": data["pickup"],
                            "drop": data["drop"],
                            "date": data["date"],
                            "time": data["time"],
                          },
                          onDelete: () {
                            _firestore
                                .collection("pickup_drop")
                                .doc(docId)
                                .delete();
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
