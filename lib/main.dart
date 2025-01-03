import 'package:flutter/material.dart';
import 'package:hedieaty/Model/database_class.dart';
import 'package:hedieaty/View/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> fireBaseInit() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

Future<void>dataBaseInit()async{
  DatabaseClass mydb = DatabaseClass();
  await mydb.initialize();
}

void main() {
  fireBaseInit();
  dataBaseInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'hedieaty',
      home: LoginScreen(),
    );
  }
}
