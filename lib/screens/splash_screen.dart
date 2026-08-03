// lib/screens/splash_screen.dart
import 'package:flutter/material.dart';

class UDASplashScreen extends StatefulWidget {
  const UDASplashScreen({super.key});

  @override
  State<UDASplashScreen> createState() => _UDASplashScreenState();
}

class _UDASplashScreenState extends State<UDASplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF1A5C2A), Color(0xFF2E7D32)],
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 8,
                width: double.infinity,
                color: const Color(0xFFFFCC00),
              ),
              const SizedBox(height: 24),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFFFCC00), width: 5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 16,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(75),
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Text(
                          'U',
                          style: TextStyle(
                            color: Color(0xFFFFCC00),
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'UNITED',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3.5,
                ),
              ),
              const Text(
                'DEMOCRATIC',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3.5,
                ),
              ),
              const Text(
                'ALLIANCE',
                style: TextStyle(
                  color: Color(0xFFFFCC00),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.45),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFFFCC00), width: 1),
                ),
                child: const Text(
                  'KAZI NI KAZI',
                  style: TextStyle(
                    color: Color(0xFFFFCC00),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.5,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              Container(height: 8, width: double.infinity, color: Colors.black),
            ],
          ),
        ),
      ),
    );
  }
}
