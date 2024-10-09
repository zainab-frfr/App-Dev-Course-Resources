import 'package:flutter/material.dart';
import 'package:midterm/home_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Space Missions', style: TextStyle(fontWeight: FontWeight.bold),),
        ),
        body: const MyHomePage(),
      ),
    );
  }
}