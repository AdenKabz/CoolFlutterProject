import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _loginUser() async {
    try {
      final email = _emailController.text;
      final password = _passwordController.text;
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      // Navigate to Home Page after successful login (implemented later)
    } on FirebaseAuthException catch (e) {
      String message = 'Login failed.';
      if (e.code == 'user-not-found') {
        message = 'The email you entered is not registered.';
      } else if (e.code == 'wrong-password') {
        message = 'The password is incorrect.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _loginUser,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
