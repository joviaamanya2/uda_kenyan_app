// lib/screens/signup_screen.dart
import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'info_page_screen.dart';
import 'login_screen.dart';
import '../services/api_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _acceptTerms = false;
  bool _isLoading = false;

  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  final List<String> _districts = [
    'Nairobi',
    'Mombasa',
    'Kisumu',
    'Nakuru',
    'Eldoret',
    'Thika',
    'Malindi',
    'Kitale',
    'Garissa',
    'Kakamega',
    'Embu',
    'Lamu',
  ];

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat(reverse: true);

    _slideAnimation =
        Tween<Offset>(
          begin: const Offset(-0.3, 0),
          end: const Offset(0.3, 0),
        ).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeInOut),
        );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _districtController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _slideController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    // DEBUG: form-validation gates (terms acceptance, password match, empty
    // fields) are temporarily disabled so sign-up can be tested without
    // filling the form. Restore these guards before shipping:
    // if (!_acceptTerms) { ...show snackbar...; return; }
    // if (_passwordController.text != _confirmPasswordController.text) { ...show snackbar...; return; }

    setState(() {
      _isLoading = true;
    });

    try {
      await ApiService.instance.register(
        _usernameController.text.trim(),
        _emailController.text.trim(),
        _passwordController.text,
      );
      if (!mounted) return;
      setState(() {
        _isLoading = false;
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const UDAHomeScreen()),
      );
    } catch (error) {
      if (!mounted) return;
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString()), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardInset = MediaQuery.of(context).viewInsets.bottom;
    final keyboardOpen = keyboardInset > 0;
    final bannerHeight =
        MediaQuery.of(context).size.height * (keyboardOpen ? 0.20 : 0.38);

    return Scaffold(
      backgroundColor: const Color(0xFF1B1D20),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.08,
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemBuilder: (context, index) => Image.asset(
                  'assets/images/uda_logo.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox.shrink(),
                ),
              ),
            ),
          ),

          SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.only(bottom: keyboardInset),
              child: Column(
                children: [
                  Stack(
                    children: [
                      AnimatedBuilder(
                        animation: _slideAnimation,
                        builder: (context, child) {
                          return ClipRect(
                            child: Container(
                              height: bannerHeight,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: const AssetImage(
                                    'assets/images/new.jpg',
                                  ),
                                  fit: BoxFit.cover,
                                  alignment: Alignment(
                                    _slideAnimation.value.dx * 0.5,
                                    0.0,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      Container(
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color(0xFFFFCC00),
                              const Color(0xFFFFCC00).withOpacity(0.8),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 10,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [_buildDot(0), _buildDot(1), _buildDot(2)],
                        ),
                      ),

                      Positioned(
                        top: 10,
                        left: 10,
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 20,
                          ),
                          onPressed: () => Navigator.pop(context),
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white.withOpacity(0.8),
                            shape: const CircleBorder(),
                            padding: const EdgeInsets.all(8),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Transform.translate(
                    offset: const Offset(0, -35),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF9F9F9),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFF1A5C2A),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            // Title
                            const Text(
                              'Create Account',
                              style: TextStyle(
                                color: Color(0xFF1A5C2A),
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Join the UDA community',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 14),

                            // Username Field
                            _buildOutlinedField(
                              controller: _usernameController,
                              label: 'Username',
                              icon: Icons.account_circle,
                            ),
                            const SizedBox(height: 12),

                            // Email Field
                            _buildOutlinedField(
                              controller: _emailController,
                              label: 'Email',
                              icon: Icons.email,
                            ),
                            const SizedBox(height: 12),

                            // District Dropdown
                            DropdownButtonFormField<String>(
                              value: _districtController.text.isEmpty
                                  ? null
                                  : _districtController.text,
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                              dropdownColor: Colors.white,
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.grey,
                                size: 22,
                              ),
                              decoration: InputDecoration(
                                labelText: 'District',
                                labelStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 14,
                                  vertical: 12,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: Colors.grey[400]!,
                                    width: 1.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                    color: Color(0xFF1A5C2A),
                                    width: 2,
                                  ),
                                ),
                                fillColor: const Color(0xFFF2F2F2),
                                filled: true,
                                isDense: true,
                              ),
                              items: _districts.map((district) {
                                return DropdownMenuItem<String>(
                                  value: district,
                                  child: Text(
                                    district,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _districtController.text = value!;
                                });
                              },
                            ),
                            const SizedBox(height: 12),

                            // Password Field
                            _buildOutlinedField(
                              controller: _passwordController,
                              label: 'Password',
                              icon: Icons.lock,
                              obscureText: _obscurePassword,
                              onToggleVisibility: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                            const SizedBox(height: 12),

                            // Confirm Password Field
                            _buildOutlinedField(
                              controller: _confirmPasswordController,
                              label: 'Confirm Password',
                              icon: Icons.lock,
                              obscureText: _obscureConfirmPassword,
                              onToggleVisibility: () {
                                setState(() {
                                  _obscureConfirmPassword =
                                      !_obscureConfirmPassword;
                                });
                              },
                            ),
                            const SizedBox(height: 14),

                            // Terms Links
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const InfoPageScreen(
                                        title: 'Terms & Conditions',
                                        lastUpdated: 'August 2026',
                                        sections: udaTermsSections,
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'Terms and conditions',
                                    style: TextStyle(
                                      color: Color(0xFF1A5C2A),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const InfoPageScreen(
                                        title: 'Privacy Policy',
                                        lastUpdated: 'August 2026',
                                        sections: udaPrivacyPolicySections,
                                      ),
                                    ),
                                  ),
                                  child: const Text(
                                    'Privacy',
                                    style: TextStyle(
                                      color: Color(0xFF1A5C2A),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            // Accept Terms Checkbox
                            Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: Checkbox(
                                    value: _acceptTerms,
                                    onChanged: (value) {
                                      setState(() {
                                        _acceptTerms = value!;
                                      });
                                    },
                                    activeColor: const Color(0xFF1A5C2A),
                                    checkColor: Colors.white,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _acceptTerms = !_acceptTerms;
                                      });
                                    },
                                    child: const Text(
                                      'Accept terms',
                                      style: TextStyle(
                                        color: Colors.black87,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 18),

                            // Sign Up Button
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                onPressed: _isLoading ? null : _handleSignUp,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFFFCC00),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24),
                                  ),
                                ),
                                child: _isLoading
                                    ? const CircularProgressIndicator(
                                        color: Colors.black,
                                        strokeWidth: 2.5,
                                      )
                                    : const Text(
                                        'Sign Up',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontSize: 15,
                                        ),
                                      ),
                              ),
                            ),

                            const SizedBox(height: 14),

                            // Back to Login
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Already have an account?',
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    'Login',
                                    style: TextStyle(
                                      color: Color(0xFF1A5C2A),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutlinedField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool obscureText = false,
    VoidCallback? onToggleVisibility,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        prefixIcon: Icon(icon, color: Colors.black87, size: 20),
        suffixIcon: onToggleVisibility != null
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey[700],
                  size: 20,
                ),
                onPressed: onToggleVisibility,
                padding: const EdgeInsets.all(8),
                constraints: const BoxConstraints(),
              )
            : null,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 12,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey[400]!, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF1A5C2A), width: 2),
        ),
        fillColor: const Color(0xFFF2F2F2),
        filled: true,
        isDense: true,
      ),
    );
  }

  Widget _buildDot(int index) {
    double progress = _slideController.value;
    bool isActive = false;

    if (progress < 0.33) {
      isActive = index == 0;
    } else if (progress < 0.66) {
      isActive = index == 1;
    } else {
      isActive = index == 2;
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      width: isActive ? 20 : 6,
      height: isActive ? 8 : 6,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: isActive
            ? const Color(0xFFFFCC00)
            : Colors.white.withOpacity(0.4),
        boxShadow: isActive
            ? [
                BoxShadow(
                  color: const Color(0xFFFFCC00).withOpacity(0.5),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
    );
  }
}
