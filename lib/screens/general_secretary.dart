// lib/screens/general_secretary_profile_screen.dart
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../theme/theme_ext.dart';

class GeneralSecretaryProfileScreen extends StatelessWidget {
  const GeneralSecretaryProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        title: const Text(
          'GENERAL SECRETARY',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFCC00),
        foregroundColor: Colors.black,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: const Icon(Icons.share, color: Colors.black),
              onPressed: () {
                SharePlus.instance.share(
                  ShareParams(
                    text:
                        'Sen. Hassan Omar — Secretary General, United '
                        'Democratic Alliance (UDA).',
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image - Large Banner with Omar's image as background
            Container(
              width: double.infinity,
              height: 300,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Background Image - Omar's photo filling the entire container
                  Image.asset(
                    'assets/images/Hon. Sen. Hassan Omar.PNG',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback to gradient if image fails to load
                      return Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF1A5C2A), Color(0xFF0D3B1E)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      );
                    },
                  ),

                  // Dark overlay for better text visibility
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withOpacity(0.3),
                          Colors.black.withOpacity(0.6),
                        ],
                      ),
                    ),
                  ),

                  // Position badge at bottom
                  Positioned(
                    bottom: 24,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFCC00),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Text(
                          'UDA SECRETARY GENERAL',
                          style: TextStyle(
                            color: Color(0xFF1A5C2A),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Name and Title Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: context.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'Hon. Sen. Hassan Omar',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A5C2A),
                      letterSpacing: 1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFCC00).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'SECRETARY GENERAL • UDA PARTY',
                      style: TextStyle(
                        color: Color(0xFF1A5C2A),
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Biography Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'BIOGRAPHY',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A5C2A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 40,
                    height: 3,
                    color: const Color(0xFFFFCC00),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Hon. Sen. Hassan Omar is a distinguished Kenyan politician and the Secretary General of the United Democratic Alliance (UDA) party. He is also a Member of the East African Legislative Assembly (EALA), representing Kenya with distinction.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: context.textStrong,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'With a strong background in law and governance, Senator Hassan Omar has been at the forefront of political transformation in Kenya. He is known for his eloquence, strategic thinking, and commitment to democratic principles.',
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.6,
                      color: context.textStrong,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Personal Details Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'PERSONAL DETAILS',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A5C2A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 40,
                    height: 3,
                    color: const Color(0xFFFFCC00),
                  ),
                  const SizedBox(height: 12),
                  _buildPersonalInfoItem(
                    context,
                    Icons.person,
                    'Full Name',
                    'Hon. Sen. Hassan Omar',
                  ),
                  _buildPersonalInfoItem(
                    context,
                    Icons.work,
                    'Position',
                    'Secretary General, UDA',
                  ),
                  _buildPersonalInfoItem(
                    context,
                    Icons.location_city,
                    'Constituency',
                    'National',
                  ),
                  _buildPersonalInfoItem(
                    context,
                    Icons.location_on,
                    'County',
                    'Nairobi',
                  ),
                  _buildPersonalInfoItem(
                    context,
                    Icons.email,
                    'Email',
                    'hassan.omar@uda.go.ke',
                  ),
                  _buildPersonalInfoItem(
                    context,
                    Icons.phone,
                    'Phone',
                    '+254 700 000 005',
                  ),
                  _buildPersonalInfoItem(
                    context,
                    Icons.calendar_today,
                    'Active Since',
                    '2021',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Social Media Links Card
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'FOLLOW THE GENERAL SECRETARY',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A5C2A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 40,
                    height: 3,
                    color: const Color(0xFFFFCC00),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSocialMediaButton(
                        context: context,
                        icon: Icons.facebook,
                        label: 'Facebook',
                        color: Colors.blue[700]!,
                        onTap: () {
                          // Open Facebook
                        },
                      ),
                      _buildSocialMediaButton(
                        context: context,
                        icon: Icons.cabin,
                        label: 'Twitter/X',
                        color: Colors.black,
                        onTap: () {
                          // Open Twitter
                        },
                      ),
                      _buildSocialMediaButton(
                        context: context,
                        icon: Icons.yard,
                        label: 'Instagram',
                        color: const Color(0xFFE4405F),
                        onTap: () {
                          // Open Instagram
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSocialMediaButton(
                        context: context,
                        icon: Icons.youtube_searched_for,
                        label: 'YouTube',
                        color: const Color(0xFFFF0000),
                        onTap: () {
                          // Open YouTube
                        },
                      ),
                      _buildSocialMediaButton(
                        context: context,
                        icon: Icons.telegram,
                        label: 'Telegram',
                        color: const Color(0xFF0088CC),
                        onTap: () {
                          // Open Telegram
                        },
                      ),
                      _buildSocialMediaButton(
                        context: context,
                        icon: Icons.youtube_searched_for,
                        label: 'WhatsApp',
                        color: const Color(0xFF25D366),
                        onTap: () {
                          // Open WhatsApp
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Footer
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(color: const Color(0xFF1A5C2A)),
              child: const Center(
                child: Text(
                  'UDA - KAZI NI KAZI',
                  style: TextStyle(
                    color: Color(0xFFFFCC00),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildPersonalInfoItem(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFF1A5C2A).withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Icon(icon, color: const Color(0xFF1A5C2A), size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 14,
                    color: context.textStrong,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMediaButton({
    required BuildContext context,
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: context.surfaceAlt,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: context.hairline),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w500,
                color: context.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
