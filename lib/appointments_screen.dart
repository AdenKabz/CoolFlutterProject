// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:tibachap/appointments_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:tibachap/user_provider.dart'; // Import for UserProvider access

class AppointmentsScreen extends StatefulWidget {
  final User? user; // Optional user argument (assuming User from Firebase)

  const AppointmentsScreen({super.key, this.user});

  @override
  _AppointmentsScreenState createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  String _selectedDoctor = ''; // Placeholder for doctor selection
  List<Appointment> appointments = []; // Replace with your appointment data
  List<DropdownMenuItem<String>> _doctorMenuItems =
      []; // Initialize an empty list

  @override
  Widget build(BuildContext context) {
    final userProvider =
        Provider.of<UserProvider>(context); // Access UserProvider
    void initState() {
      super.initState();
      // Fetch or populate your list of doctors (implementation needed)
      // Replace this with your actual logic for fetching doctor data
      final doctors = [
        {'id': 'doctor1', 'name': 'Dr. Smith'},
        {'id': 'doctor2', 'name': 'Dr. Jones'},
      ]; // Placeholder doctor data

      _doctorMenuItems = doctors
          .map((doctor) => DropdownMenuItem(
                value: doctor['id'] as String, // Doctor's ID as value
                child:
                    Text(doctor['name'] as String), // Doctor's name displayed
              ))
          .toList();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointments'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Date and Time Pickers
              TextFormField(
                controller: _dateController,
                readOnly: true, // Open date picker on tap
                decoration: InputDecoration(
                  labelText: 'Date',
                  icon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate:
                          DateTime.now().subtract(const Duration(days: 30)),
                      lastDate: DateTime.now().add(const Duration(days: 30)),
                    ).then((date) {
                      _dateController.text = date!.toString().split(' ')[0];
                    }),
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please select a date' : null,
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                controller: _timeController,
                readOnly: true, // Open time picker on tap
                decoration: InputDecoration(
                  labelText: 'Time',
                  icon: IconButton(
                    icon: const Icon(Icons.access_time),
                    onPressed: () => showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    ).then((time) {
                      _timeController.text = time!.format(context);
                    }),
                  ),
                ),
                validator: (value) =>
                    value!.isEmpty ? 'Please select a time' : null,
              ),
              const SizedBox(height: 10.0),
              // Implement Doctor Selection with dropdown
              DropdownButtonFormField<String>(
                value: _selectedDoctor,
                items: _doctorMenuItems.isEmpty
                    ? []
                    : _doctorMenuItems, // Show empty list while loading
                onChanged: (value) =>
                    setState(() => _selectedDoctor = value as String),
                validator: (value) => value == null || value.isEmpty
                    ? 'Please select a doctor'
                    : null,
                // Optional hint text (displayed when no item is selected)
                hint: const Text('Select a Doctor'),
              ),

              const SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Check if user is logged in asynchronously
                    final isLoggedIn = userProvider.isLoggedIn();
                    if (isLoggedIn) {
                      createAppointment();
                    } else {
                      // Handle case where user is not logged in (e.g., show a snackbar)
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content:
                              Text('Please login to schedule an appointment'),
                        ),
                      );
                    }
                  }
                },
                child: const Text('Schedule Appointment'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void createAppointment() async {
    // Get user data asynchronously (assuming Provider approach)
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final user = await userProvider.getUserData(); // Assume async method

    // Use user data (e.g., user.email) in your appointment creation logic
    if (user != null) {
      final userEmail = user.email;
      // ... Use userEmail for appointment creation
    } else {
      // Handle case where user data is not available (optional)
    }
  }
}
