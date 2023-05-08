import 'package:chatapp_firebase/helper/helper_function.dart';
import 'package:chatapp_firebase/pages/home_page.dart';
import 'package:chatapp_firebase/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:chatapp_firebase/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    // initialization for web
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: Constants.apiKey,
            appId: Constants.appId,
            messagingSenderId: Constants.messagingSenderId,
            projectId: Constants.projectId));
  } else {
    //intialization for android
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _issignedin = false;

  @override
  void initState() {
    super.initState();
    getUSerLoggedInStatus();
  }

  getUSerLoggedInStatus() async {
    await HelperFunctions.getUSerLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
        _issignedin = value;          
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Constants().primaryColor,
          scaffoldBackgroundColor: Colors.black),
      debugShowCheckedModeBanner: false,
      home: _issignedin ? const HomePage() : const LoginPage(),
    );
  }
}
