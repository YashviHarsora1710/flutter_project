import 'package:flutter/material.dart';

class PickupDropScreen extends StatefulWidget {
  const PickupDropScreen({super.key});

  @override
  State<PickupDropScreen> createState() => _PickupDropScreenState();
}

class _PickupDropScreenState extends State<PickupDropScreen> {
  final _formKey = GlobalKey<FormState>();

  // Form fields
  String? name, phone, pickupAddress, dropAddress;
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  // Pick Date
  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // Pick Time
  Future<void> _pickTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  // Confirm Booking
  void _confirmBooking() {
    if (_formKey.currentState!.validate() &&
        selectedDate != null &&
        selectedTime != null) {
      _formKey.currentState!.save();

      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text("Booking Confirmed"),
          content: Text(
            "Name: $name\n"
            "Phone: $phone\n"
            "Pickup: $pickupAddress\n"
            "Drop: $dropAddress\n"
            "Date: ${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}\n"
            "Time: ${selectedTime!.format(context)}",
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("OK"),
            ),
          ],
        ),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pickup & Drop Service")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Name
              TextFormField(
                decoration: const InputDecoration(labelText: "Name"),
                validator: (val) =>
                    val == null || val.isEmpty ? "Enter your name" : null,
                onSaved: (val) => name = val,
              ),

              const SizedBox(height: 12),

              // Phone
              TextFormField(
                decoration: const InputDecoration(labelText: "Phone Number"),
                keyboardType: TextInputType.phone,
                validator: (val) =>
                    val == null || val.isEmpty ? "Enter phone number" : null,
                onSaved: (val) => phone = val,
              ),

              const SizedBox(height: 12),

              // Pickup Address
              TextFormField(
                decoration: const InputDecoration(labelText: "Pickup Address"),
                maxLines: 2,
                validator: (val) =>
                    val == null || val.isEmpty ? "Enter pickup address" : null,
                onSaved: (val) => pickupAddress = val,
              ),

              const SizedBox(height: 12),

              // Drop Address
              TextFormField(
                decoration: const InputDecoration(labelText: "Drop Address"),
                maxLines: 2,
                validator: (val) =>
                    val == null || val.isEmpty ? "Enter drop address" : null,
                onSaved: (val) => dropAddress = val,
              ),

              const SizedBox(height: 12),

              // Date Picker
              ListTile(
                title: Text(
                  selectedDate == null
                      ? "Select Date"
                      : "Date: ${selectedDate!.day}-${selectedDate!.month}-${selectedDate!.year}",
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: _pickDate,
              ),

              // Time Picker
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

              // Confirm Button
              ElevatedButton(
                onPressed: _confirmBooking,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
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
