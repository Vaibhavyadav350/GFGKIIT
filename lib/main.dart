import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gfg_kiit/user/wrapper.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.green,
      theme: ThemeData(
        primarySwatch: Colors.green,
        primaryColor: Colors.green,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          labelStyle: TextStyle(color: Colors.green),
          fillColor: Colors.green.withOpacity(0.1),
        ),
      ),
      home: Wrapper()
    );
  }
}

