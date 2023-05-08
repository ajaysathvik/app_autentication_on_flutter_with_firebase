import 'package:chatapp_firebase/pages/login_page.dart';
import 'package:chatapp_firebase/services/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthService authService = AuthService();
  final FirebaseAuth auth = FirebaseAuth.instance;

  // signout function
  Future<void> signOut() async {
    try {
      await auth.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text("LOGOUT"),
          onPressed: () {
            signOut();
          },
        ),
      ),
    );
  }
}