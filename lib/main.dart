import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizmasterapp/Pages/HomePage.dart';
import 'package:quizmasterapp/Pages/signinPage.dart';
import 'package:quizmasterapp/Services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  AuthServices authServices = AuthServices();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: authServices.isSignedIn() ? const HomePage() : const SignInPage(),
    );
  }
}
