// lib/screens/language_selection_screen.dart

import 'package:flutter/material.dart';
import 'package:uda_app/screens/login_screen.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen>
    with SingleTickerProviderStateMixin {
  String _selectedLanguage = 'English';
  bool _isLoading = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> _languages = [
    {
      'name': 'English',

      'flag': '🇬🇧',
      'code': 'en',
      'speakers': 'Official Language',
    },
    {
      'name': 'Kiswahili',

      'flag': '🇰🇪',
      'code': 'sw',
      'speakers': 'National Language',
    },
  ];

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleLanguageSelection() {
    setState(() {
      _isLoading = true;
    });

    Future.delayed(const Duration(milliseconds: 800), () {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
            settings: const RouteSettings(name: '/login'),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // ----------------------------------------------------------
                // SPACE ABOVE LOGO
                // ----------------------------------------------------------
                const SizedBox(height: 35),

                // ----------------------------------------------------------
                // HEADER
                // ----------------------------------------------------------
                Container(
                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                  color: Colors.white,
                  child: Column(
                    children: [
                      // Logo
                      Container(
                        width: 64,
                        height: 64,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFFFFCC00),
                            width: 2,
                          ),
                        ),
                        child: ClipOval(
                          child: Image.asset(
                            'assets/images/uda_logo.png',
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: const Color(0xFFFFCC00),
                                child: const Center(
                                  child: Text(
                                    'UDA',
                                    style: TextStyle(
                                      color: Color(0xFF1A5C2A),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Title
                      const Text(
                        'Choose your language',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF1A5C2A),
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.3,
                        ),
                      ),

                      const SizedBox(height: 4),

                      // Subtitle
                      Text(
                        'Select your preferred language to continue',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),

                // ----------------------------------------------------------
                // LANGUAGE CARDS
                // ----------------------------------------------------------
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 0),
                  child: Column(
                    children: [
                      ..._languages.asMap().entries.map((entry) {
                        final index = entry.key;
                        final language = entry.value;
                        final isSelected =
                            _selectedLanguage == language['name'];

                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: index == _languages.length - 1 ? 0 : 10,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0xFFFFCC00).withOpacity(0.08)
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: isSelected
                                    ? const Color(0xFFFFCC00)
                                    : Colors.grey.shade200,
                                width: isSelected ? 2 : 1,
                              ),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(14),
                              onTap: () {
                                setState(() {
                                  _selectedLanguage =
                                      language['name'] as String;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 13,
                                ),
                                child: Row(
                                  children: [
                                    // Flag
                                    Container(
                                      width: 44,
                                      height: 44,
                                      decoration: BoxDecoration(
                                        color: isSelected
                                            ? const Color(
                                                0xFFFFCC00,
                                              ).withOpacity(0.15)
                                            : Colors.grey.shade50,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Center(
                                        child: Text(
                                          language['flag'] as String,
                                          style: const TextStyle(fontSize: 24),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 14),

                                    // Language information
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                language['name'] as String,
                                                style: TextStyle(
                                                  fontWeight: isSelected
                                                      ? FontWeight.w700
                                                      : FontWeight.w600,
                                                  fontSize: 16,
                                                  color: isSelected
                                                      ? const Color(0xFF1A5C2A)
                                                      : Colors.black87,
                                                ),
                                              ),

                                              const SizedBox(width: 6),

                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 2,
                                                    ),
                                                decoration: BoxDecoration(
                                                  color: Colors.grey.shade100,
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                              ),
                                            ],
                                          ),

                                          const SizedBox(height: 3),
                                        ],
                                      ),
                                    ),

                                    // Selected indicator
                                    if (isSelected)
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFFFFCC00),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.check_rounded,
                                          color: Color(0xFF1A5C2A),
                                          size: 16,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),

                // ----------------------------------------------------------
                // SMALL SPACE BEFORE BUTTONS
                // ----------------------------------------------------------
                const SizedBox(height: 16),

                // ----------------------------------------------------------
                // CONTINUE BUTTON
                // ----------------------------------------------------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleLanguageSelection,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFCC00),
                        foregroundColor: const Color(0xFF1A5C2A),
                        disabledBackgroundColor: Colors.grey.shade300,
                        disabledForegroundColor: Colors.grey.shade600,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: _isLoading
                          ? const SizedBox(
                              height: 22,
                              width: 22,
                              child: CircularProgressIndicator(
                                color: Color(0xFF1A5C2A),
                                strokeWidth: 2.5,
                              ),
                            )
                          : Text(
                              'Continue in $_selectedLanguage',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                                color: Color(0xFF1A5C2A),
                              ),
                            ),
                    ),
                  ),
                ),

                // ----------------------------------------------------------
                // SKIP
                // ----------------------------------------------------------
                const SizedBox(height: 2),

                InkWell(
                  onTap: () {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    }
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
                    child: Text(
                      'Skip for now',
                      style: TextStyle(
                        color: Color(0xFFBDBDBD),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                // Small space at bottom
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
