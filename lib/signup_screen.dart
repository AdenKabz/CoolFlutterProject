// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:tibachap/user_provider.dart';

class SignupScreen extends StatefulWidget {
  final UserType userType;

  const SignupScreen({super.key, required this.userType});
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter email' : null,
                onSaved: (value) => setState(() => _email = value!),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true, // Hide password characters
                validator: (value) =>
                    value!.isEmpty ? 'Please enter password' : null,
                onSaved: (value) => setState(() => _password = value!),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Handle user signup logic (implementation depends on your backend)
                    // Potentially use UserProvider to update login state
                  }
                },
                child: const Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
