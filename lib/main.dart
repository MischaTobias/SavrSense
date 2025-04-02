import 'package:flutter/material.dart';
import 'package:savr_sense/core/di/service_locator.dart';
import 'package:savr_sense/features/home/presentation/home_screen.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SavrSense',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomeScreen(),
    );
  }
}
