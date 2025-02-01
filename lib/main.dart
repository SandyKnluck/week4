import 'package:flutter/material.dart';
import 'package:week4/api_test/simple_api_call.dart';
import 'package:week4/form/registration_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SimpleApiCall(),
    );
  }
}
