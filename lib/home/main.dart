import 'package:flutter/material.dart';
import 'package:gfg_kiit/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.green,
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomePage()
    );

  }
}