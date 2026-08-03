// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UDA Party App',
      theme: ThemeData(primarySwatch: Colors.green, useMaterial3: true),
      home: const UDASplashScreen(),
      routes: {'/home': (context) => const HomeScreen()},
      debugShowCheckedModeBanner: false,
    );
  }
}
