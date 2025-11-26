import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PickupDropScreen extends StatefulWidget {
  const PickupDropScreen({super.key});

  @override
  State<PickupDropScreen> createState() => _PickupDropScreenState();
}

class _PickupDropScreenState extends State<PickupDropScreen> {
  final _formKey = GlobalKey<FormState>();

  String? name, phone, pickupAddress, dropAddress;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  TextEditingController? _nameController;
  TextEditingController? _phoneController;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  // Load user name and phone from Firestore
  Future<void> _loadUserProfile() async {
    final user = _auth.currentUser;

    if (user != null) {
      final doc = await _firestore
          .collection("pickup_drop")
          .doc(user.uid)
          .get();

      if (doc.exists) {
        final data = doc.data()!;
        setState(() {
          name = data['name'] ?? "";
          phone = data['phone'] ?? "";
          _nameController = TextEditingController(text: name);
          _phoneController = TextEditingController(text: phone);
        });
      } else {
        // First user entry
        setState(() {
          _nameController = TextEditingController(text: user.displayName ?? "");
          _phoneController = TextEditingController(text: "");
        });
      }
    }
  }

  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => selectedDate = picked);
  }

  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) setState(() => selectedTime = picked);
  }

  // Save Booking to Firestore
  Future<void> _confirmBooking() async {
    if (_formKey.currentState!.validate() &&
        selectedDate != null &&
        selectedTime != null) {
      _formKey.currentState!.save();

      final user = _auth.currentUser;
      if (user != null) {
        // Save or update booking for this user
        await _firestore.collection("pickup_drop").doc(user.uid).set({
          "userId": user.uid,
          "name": name,
          "phone": phone,
          "pickup": pickupAddress,
          "drop": dropAddress,
          "date":
              "${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
          "time": selectedTime!.format(context),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Booking saved successfully!")),
        );

        // Clear form fields
        setState(() {
          pickupAddress = '';
          dropAddress = '';
          selectedDate = null;
          selectedTime = null;
        });
      }
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pickup & Drop Service"),
        backgroundColor: const Color(0xFF4C5C68),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _nameController == null || _phoneController == null
            ? const Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: "Name"),
                      validator: (val) =>
                          val == null || val.isEmpty ? "Enter your name" : null,
                      onSaved: (val) => name = val,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: "Phone Number",
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (val) => val == null || val.isEmpty
                          ? "Enter phone number"
                          : null,
                      onSaved: (val) => phone = val,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Pickup Address",
                      ),
                      maxLines: 2,
                      validator: (val) => val == null || val.isEmpty
                          ? "Enter pickup address"
                          : null,
                      onSaved: (val) => pickupAddress = val,
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Drop Address",
                      ),
                      maxLines: 2,
                      validator: (val) => val == null || val.isEmpty
                          ? "Enter drop address"
                          : null,
                      onSaved: (val) => dropAddress = val,
                    ),
                    const SizedBox(height: 12),
                    ListTile(
                      title: Text(
                        selectedDate == null
                            ? "Select Date"
                            : "Date: ${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
                      ),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: _pickDate,
                    ),
                    ListTile(
                      title: Text(
                        selectedTime == null
                            ? "Select Time"
                            : "Time: ${selectedTime!.format(context)}",
                      ),
                      trailing: const Icon(Icons.access_time),
                      onTap: _pickTime,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _confirmBooking,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        backgroundColor: const Color(0xFF4C5C68),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text(
                        "Confirm Booking",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
