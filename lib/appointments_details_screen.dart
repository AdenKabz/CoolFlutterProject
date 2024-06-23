import 'package:flutter/material.dart';
import 'package:tibachap/google_maps_screen.dart';

class AppointmentDetailsScreen extends StatelessWidget {
  final Appointment appointment; // Appointment object passed as argument

  const AppointmentDetailsScreen({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Appointment Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              'Doctor: ${appointment.doctorName}',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Date: ${appointment.date}',
              style: const TextStyle(fontSize: 16.0),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Time: ${appointment.time}',
              style: const TextStyle(fontSize: 16.0),
            ),
            if (appointment.location != null) ...[
              // Show location details if available
              const SizedBox(height: 10.0),
              Text(
                'Location: ${appointment.location}',
                style: const TextStyle(fontSize: 16.0),
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GoogleMapsScreen(
                      location: appointment.location!,
                    ),
                  ),
                ),
                child: const Text('View on Map'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Appointment class (replace with your actual appointment data structure)
class Appointment {
  final String doctorName;
  final String date;
  final String time;
  final String? location;

  const Appointment({
    required this.doctorName,
    required this.date,
    required this.time,
    this.location,
  });
}
