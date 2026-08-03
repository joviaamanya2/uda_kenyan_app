// lib/screens/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For rootBundle

class UDASplashScreen extends StatelessWidget {
  const UDASplashScreen({super.key});

  // Function to navigate to home when the arrow is tapped
  void _navigateToHome(BuildContext context) {
    print('🔄 Navigating to home...');
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    print('🟢 UDASplashScreen building...');
    
    // Log the asset path for debugging
    const String assetPath = 'assets/images/logo.png';
    print('📁 Looking for asset at: $assetPath');
    
    // Check if asset exists (this will log to console)
    _checkAssetExists(assetPath);
    
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // Solid UDA Green background
        color: const Color(0xFF1A5C2A),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // White square card with logo (matching NRM design)
              Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(
                      assetPath,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        // Log the error details
                        print('❌ ERROR loading image: $assetPath');
                        print('❌ Error details: $error');
                        print('❌ Stack trace: $stackTrace');
                        
                        // Fallback logo design if image fails to load
                        return _buildFallbackLogo();
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Party abbreviation
              const Text(
                'UDA',
                style: TextStyle(
                  color: Color(0xFFFFCC00), 
                  fontSize: 48,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 4,
                ),
              ),

              const SizedBox(height: 8),

              // Full party name
              const Text(
                'United Democratic Alliance',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                ),
              ),

              const SizedBox(height: 60), // Space before the arrow

              // The Arrow Button
              GestureDetector(
                onTap: () => _navigateToHome(context),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFFFCC00), // UDA Yellow
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Color(0xFF1A5C2A), // UDA Green
                    size: 32,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Fallback logo shown if the asset is missing
  Widget _buildFallbackLogo() {
    print('⚠️ Showing fallback logo (image failed to load)');
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.account_balance, size: 80, color: Color(0xFF1A5C2A)),
          SizedBox(height: 8),
          Text(
            'UDA',
            style: TextStyle(
              color: Color(0xFF1A5C2A),
              fontSize: 26,
              fontWeight: FontWeight.w900,
              letterSpacing: 3,
            ),
          ),
        ],
      ),
    );
  }

  /// Helper function to check if asset exists
  Future<void> _checkAssetExists(String assetPath) async {
    try {
      print('🔍 Checking if asset exists: $assetPath');
      final data = await rootBundle.load(assetPath);
      print('✅ Asset loaded successfully! Size: ${data.lengthInBytes} bytes');
    } catch (e) {
      print('❌ Asset NOT found: $assetPath');
      print('❌ Error: $e');
      print('💡 Make sure the asset is listed in pubspec.yaml like this:');
      print('   assets:');
      print('     - assets/images/logo.png');
    }
  }
}