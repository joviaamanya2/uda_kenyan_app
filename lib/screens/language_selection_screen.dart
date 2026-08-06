// lib/screens/language_selection_screen.dart
import 'package:flutter/material.dart';
import 'package:uda_app/screens/login_screen.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String _selectedLanguage = 'English';
  bool _isLoading = false;

  final List<Map<String, dynamic>> _languages = [
    {
      'name': 'English',
      'nativeName': 'English',
      'flag': '🇬🇧',
      'code': 'en',
      'speakers': 'Official Language',
    },
    {
      'name': 'Kiswahili',
      'nativeName': 'Kiswahili',
      'flag': '🇰🇪',
      'code': 'sw',
      'speakers': 'National Language',
    },
    {
      'name': 'Luo',
      'nativeName': 'Dholuo',
      'flag': '🇰🇪',
      'code': 'luo',
      'speakers': 'Western Kenya',
    },
    {
      'name': 'Kikuyu',
      'nativeName': 'Gĩkũyũ',
      'flag': '🇰🇪',
      'code': 'kik',
      'speakers': 'Central Kenya',
    },
    {
      'name': 'Luhya',
      'nativeName': 'Oluluhya',
      'flag': '🇰🇪',
      'code': 'luy',
      'speakers': 'Western Kenya',
    },
    {
      'name': 'Kalenjin',
      'nativeName': 'Kipsigis',
      'flag': '🇰🇪',
      'code': 'kln',
      'speakers': 'Rift Valley',
    },
    {
      'name': 'Kamba',
      'nativeName': 'Kikamba',
      'flag': '🇰🇪',
      'code': 'kam',
      'speakers': 'Eastern Kenya',
    },
    {
      'name': 'Meru',
      'nativeName': 'Kimîîru',
      'flag': '🇰🇪',
      'code': 'mer',
      'speakers': 'Eastern Kenya',
    },
    {
      'name': 'Somali',
      'nativeName': 'Af-Soomaali',
      'flag': '🇸🇴',
      'code': 'som',
      'speakers': 'North Eastern',
    },
    {
      'name': 'Maa',
      'nativeName': 'ɔl Maa',
      'flag': '🇰🇪',
      'code': 'mas',
      'speakers': 'Rift Valley',
    },
  ];

  void _handleLanguageSelection() {
    setState(() {
      _isLoading = true;
    });

    // Simulate language change
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A5C2A),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF1A5C2A),
                    const Color(0xFF0D3B1E),
                  ],
                ),
              ),
              child: Column(
                children: [
                  // Logo
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFFFCC00),
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Text(
                              'UDA',
                              style: TextStyle(
                                color: Color(0xFF1A5C2A),
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Select Language',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Choose your preferred language',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Language List
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  physics: const BouncingScrollPhysics(),
                  itemCount: _languages.length,
                  itemBuilder: (context, index) {
                    final language = _languages[index];
                    final isSelected = _selectedLanguage == language['name'];

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedLanguage = language['name'] as String;
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: isSelected 
                              ? const Color(0xFFFFCC00).withOpacity(0.15)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected 
                                ? const Color(0xFFFFCC00)
                                : Colors.grey.shade200,
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: isSelected 
                                  ? const Color(0xFFFFCC00).withOpacity(0.2)
                                  : Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: isSelected 
                                  ? const Color(0xFFFFCC00).withOpacity(0.2)
                                  : const Color(0xFF1A5C2A).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                language['flag'] as String,
                                style: const TextStyle(fontSize: 24),
                              ),
                            ),
                          ),
                          title: Text(
                            language['name'] as String,
                            style: TextStyle(
                              fontWeight: isSelected 
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                              color: isSelected 
                                  ? const Color(0xFF1A5C2A)
                                  : Colors.black87,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 2),
                              Text(
                                language['nativeName'] as String,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: isSelected 
                                      ? const Color(0xFF1A5C2A).withOpacity(0.7)
                                      : Colors.grey.shade600,
                                ),
                              ),
                              Text(
                                language['speakers'] as String,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade500,
                                ),
                              ),
                            ],
                          ),
                          trailing: isSelected
                              ? Container(
                                  width: 28,
                                  height: 28,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFFFFCC00),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: Color(0xFF1A5C2A),
                                    size: 18,
                                  ),
                                )
                              : null,
                          onTap: () {
                            setState(() {
                              _selectedLanguage = language['name'] as String;
                            });
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),

            // Bottom Button
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleLanguageSelection,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFCC00),
                        foregroundColor: const Color(0xFF1A5C2A),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                color: Color(0xFF1A5C2A),
                                strokeWidth: 2,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Continue in ',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  _selectedLanguage,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text(
                      'Skip for now',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}