import 'package:blood_donation/Views/Authentication/authentication.dart';
import 'package:blood_donation/firebase_options.dart';
import 'package:firebase_core_dart/firebase_core_dart.dart';
import 'package:flutter/material.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blood Donation',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
        useMaterial3: true,
        primaryColor: Colors.red,
      ),
      home: const Authentication(),
    );
  }
}
