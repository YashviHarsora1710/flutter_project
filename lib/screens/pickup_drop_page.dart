import 'package:flutter/material.dart';

class PickupDropPage extends StatefulWidget {
  @override
  _PickupDropPageState createState() => _PickupDropPageState();
}

class _PickupDropPageState extends State<PickupDropPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController pickupController = TextEditingController();
  final TextEditingController dropController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pick-up & Drop")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
                validator: (val) => val!.isEmpty ? "Enter Name" : null,
              ),
              TextFormField(
                controller: pickupController,
                decoration: InputDecoration(labelText: "Pickup Address"),
                validator: (val) =>
                    val!.isEmpty ? "Enter Pickup Address" : null,
              ),
              TextFormField(
                controller: dropController,
                decoration: InputDecoration(labelText: "Drop Address"),
                validator: (val) => val!.isEmpty ? "Enter Drop Address" : null,
              ),
              TextFormField(
                controller: mobileController,
                decoration: InputDecoration(labelText: "Mobile Number"),
                keyboardType: TextInputType.phone,
                validator: (val) => val!.isEmpty ? "Enter Mobile Number" : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Show success message
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Pick-up & Drop Request Submitted"),
                      ),
                    );

                    // Clear all fields after submit
                    nameController.clear();
                    pickupController.clear();
                    dropController.clear();
                    mobileController.clear();
                  }
                },
                child: Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
