import 'package:flutter/material.dart';
import 'package:hedieaty/View/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
Future<void> fireBaseInit() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}
void main() {
  fireBaseInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'hedieaty',
      home: LoginScreen(),
    );
  }
}
