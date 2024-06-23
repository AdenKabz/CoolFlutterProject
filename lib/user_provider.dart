// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String email;
  final UserType userType;

  const User({required this.uid, required this.email, required this.userType});

  Future<User?> fromMap(dynamic userData) async {
    try {
      if (userData != null) {
        // Implement logic to convert data to a User object
        // Replace with your actual implementation
        final email = userData['email']; // Replace with actual key name
        final uid = userData['uid']; // Replace with actual key name
        return User(
            email: email,
            uid: uid,
            userType: userType); // Example user creation
      } else {
        return null;
      }
    } catch (error) {
      // Handle exceptions and potentially return null
      debugPrint("Error parsing user data: $error");
      return null;
    }
  }
}

enum UserType { patient, medicalProfessional }

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;

  void setUser(User? user) {
    _user = user;
    notifyListeners(); // Notify listeners about the change
  }

  bool isLoggedIn() {
    final user = FirebaseAuth.instance.currentUser;
    return _user != null;
  }

  // New method to fetch user data asynchronously (if needed)
  Future<User?> getUserData() async {
    // Implement your logic to fetch user data (e.g., from Firebase)
    // Replace this with your actual implementation
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      // Access Firestore using user ID
      final docRef = FirebaseFirestore.instance.collection('users').doc(userId);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        // Firestore document exists, return data
        final userData = docSnapshot.data();
        final convertedUser = await user?.fromMap(userData);
        return convertedUser;
      } else {
        print("User document not found in Firestore");
        return null; // Return null if no user is found
      }
    } else {
      return null; // No user logged in
    }
  }

  // Login logic with user type determination using custom claims
  Future<User?> login(String email, String password) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the ID token with claims (requires 'wait: true')
      final idTokenResult = await userCredential.user!.getIdTokenResult(true);
      final claims = idTokenResult.claims;

      final userTypeString =
          claims?['userType']; // Assuming a claim named 'userType'

      UserType? userType;
      if (userTypeString == 'patient') {
        userType = UserType.patient;
      } else if (userTypeString == 'medicalProfessional') {
        userType = UserType.medicalProfessional;
      } else {
        // Handle invalid or missing userType claim
        debugPrint('Error: Invalid or missing userType claim');
        return null; // Handle login failure
      }

      // Return User object with additional userType information
      return User(
          userType: userType,
          uid: 'uid',
          email: 'email'); // Assuming a User constructor or field);
    } catch (error) {
      // Handle login errors (optional)
      debugPrint("Login error: $error");
      return null;
    }
  }
}
