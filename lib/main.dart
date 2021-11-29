import 'package:finance_app/Screens/dashboard.dart';
import 'package:finance_app/Screens/earning_screen.dart';
import 'package:finance_app/Screens/profile_master_screen.dart';
import 'package:finance_app/Screens/quiz_screen.dart';
import 'package:finance_app/Screens/welcome_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Dashboard(),
    );
  }
}
