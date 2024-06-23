import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:tibachap/medical_professional_signup.dart';
import 'package:tibachap/patient_signup.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tibachap/user_provider.dart';
import 'package:tibachap/user_info_display.dart';
import 'package:tibachap/appointments_screen.dart'; // Importing AppointmentsScreen
import 'package:tibachap/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProvider>(
      create: (context) => UserProvider(),
      child: MaterialApp(
        title: 'TibaChap',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        initialRoute: '/', // Set initial route to '/'
        routes: {
          '/': (context) => const MyHomePage(), // Home screen
          '/appointments': (context) =>
              const AppointmentsScreen(), // Appointments screen
          '/patient-login': (context) => const PatientLoginScreen(),
          '/patient-signup': (context) =>
              const SignupScreen(userType: UserType.patient), // Pass user type
          '/medical-professional-login': (context) =>
              const MedicalProfessionalLoginScreen(),
          '/medical-professional-signup': (context) => const SignupScreen(
              userType: UserType.medicalProfessional), // Pass user type
          // ... add more routes as needed
        },
      ),
    );
  }

  // Replace this function with your actual logic to check login status
  // (might involve checking userProvider or local storage)
  bool isUserLoggedIn() {
    final user = FirebaseAuth.instance.currentUser;
    return user != null;
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance; // Initialize Firebase Auth
  late final UserProvider
      _userProvider; // Access UserProvider (assuming in build)

  bool isUserLoggedIn() {
    final user = _auth.currentUser;
    return user != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TibaChap'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UserInfoDisplay(userProvider: _userProvider), // Use the widget
            if (!isUserLoggedIn()) ...[
              // Only show login/signup buttons if not logged in
              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/patient-login'),
                child: const Text('Login as Patient'),
              ),
              ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/medical-professional-login'),
                child: const Text('Login as Medical Professional'),
              ),
              const SizedBox(width: 10.0),
              ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/patient-signup'),
                child: const Text('Sign Up as Patient'),
              ),

              ElevatedButton(
                onPressed: () => Navigator.pushNamed(
                    context, '/medical-professional-signup'),
                child: const Text('Sign Up as Medical Professional'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
