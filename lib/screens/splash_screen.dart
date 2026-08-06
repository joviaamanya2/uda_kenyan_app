// lib/screens/splash_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'language_selection_screen.dart';

class UDASplashScreen extends StatefulWidget {
  const UDASplashScreen({super.key});

  @override
  State<UDASplashScreen> createState() => _UDASplashScreenState();
}

class _UDASplashScreenState extends State<UDASplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LanguageSelectionScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFCC00), // All in Yellow as requested
      body: Stack(
        children: [
          // Background repeated pattern of small UDA logos (faintly visible)
          Positioned.fill(
            child: Opacity(
              opacity: 0.08, // Not seen clearly as requested
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemBuilder: (context, index) => Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                ),
              ),
            ),
          ),

          // Main Center Content with Black Words
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // White card container with UDA Logo
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: const Color(0xFF1A5C2A), width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          blurRadius: 15,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) => const Icon(
                            Icons.flag,
                            size: 60,
                            color: Color(0xFF1A5C2A),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Black Party Abbreviation
                  const Text(
                    'UDA',
                    style: TextStyle(
                      color: Colors.black, // Black words as requested
                      fontSize: 48,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 4,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Black Full Party Name
                  const Text(
                    'United Democratic Alliance',
                    style: TextStyle(
                      color: Colors.black, // Black words as requested
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Green Motto Tag
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A5C2A),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'KAZI NI KAZI',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}