// lib/screens/president_profile_screen.dart
import 'package:flutter/material.dart';
import 'ask_president.dart';

class PresidentProfileScreen extends StatelessWidget {
  const PresidentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'PRESIDENT PROFILE',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFFFCC00),
        foregroundColor: Colors.black,
        elevation: 2,
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
                // Share functionality
              },
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // President Card - with larger image
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF1A5C2A), Color(0xFF2E7D32)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Row(
                    children: [
                      // President Image - Made BIGGER
                      Container(
                        width: 130,
                        height: 160,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFFFCC00), width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(6),
                          child: Image.network(
                            'https://via.placeholder.com/130x160/FFFFFF/1A5C2A?text=PRESIDENT',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey[200],
                                child: const Center(
                                  child: Icon(
                                    Icons.person,
                                    color: Color(0xFF1A5C2A),
                                    size: 100,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      // President Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'WILLIAM RUTO',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'PRESIDENT',
                              style: TextStyle(
                                color: Color(0xFFFFCC00),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 2,
                              ),
                            ),
                            
                          ],
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
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
                        'Biography',
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
                      
                      // Personal Details
                      _buildBioItem('Age', '58 years old (Born 21 December 1966)'),
                      _buildBioItem('Place of Birth', 'Kamagut, Uasin Gishu County, Kenya'),
                      _buildBioItem('Education', '• University of Nairobi (PhD in Plant Ecology)\n• University of Nairobi (MSc in Environmental Science)\n• University of Nairobi (BSc in Environmental Science)'),
                      _buildBioItem('Spouse', 'H.E. Rachel Ruto (Married since 1991)'),
                      _buildBioItem('Children', '6 Children (1 Boy, 5 Girls)'),
                      _buildBioItem('Religion', 'Christian (Evangelical)'),
                      _buildBioItem('Year in Power', '2022 - Present'),
                      const SizedBox(height: 12),
                      
                      const Text(
                        'H.E Dr. William Ruto is the President of the Republic of Kenya and the Party Leader of the United Democratic Alliance (UDA). He was elected in 2022 on a platform of economic transformation and inclusive governance.',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.6,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'Prior to his presidency, he served as Deputy President of Kenya from 2013 to 2022. He has been a vocal advocate for the Bottom-Up Economic Transformation Agenda (BETA), focusing on empowering ordinary citizens and creating opportunities for all Kenyans.',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.6,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'As the leader of UDA, President Ruto is committed to uniting Kenyans, promoting peace, and building a prosperous nation for future generations.',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.6,
                          color: Colors.black87,
                        ),
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
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
                        'Connect With The President',
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
                      
                      // Social Media Grid
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildSocialMediaButton(
                            icon: Icons.facebook,
                            label: 'Facebook',
                            color: Colors.blue[700]!,
                            onTap: () {
                              // Open Facebook
                            },
                          ),
                          _buildSocialMediaButton(
                            icon: Icons.wallet,
                            label: 'Twitter/X',
                            color: Colors.black,
                            onTap: () {
                              // Open Twitter
                            },
                          ),
                          _buildSocialMediaButton(
                            icon: Icons.discord,
                            label: 'Discord',
                            color: const Color(0xFF5865F2),
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
                            icon: Icons.youtube_searched_for,
                            label: 'YouTube',
                            color: const Color(0xFFFF0000),
                            onTap: () {
                              // Open YouTube
                            },
                          ),
                          _buildSocialMediaButton(
                            icon: Icons.telegram,
                            label: 'Telegram',
                            color: const Color(0xFF0088CC),
                            onTap: () {
                              // Open Telegram
                            },
                          ),
                          _buildSocialMediaButton(
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
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A5C2A),
                  ),
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
                const SizedBox(height: 80), // Space for floating button
              ],
            ),
          ),
          
          // Floating "Ask The President" Button - Navigates to the form screen
          Positioned(
            bottom: 20,
            right: 16,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AskPresidentScreen()),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFCC00), Color(0xFFFFD700)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(
                      Icons.question_answer,
                      color: Color(0xFF1A5C2A),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'ASK THE PRESIDENT',
                      style: TextStyle(
                        color: Color(0xFF1A5C2A),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward,
                      color: Color(0xFF1A5C2A),
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBioItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 16,
            color: const Color(0xFFFFCC00),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A5C2A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 13,
                    height: 1.4,
                    color: Colors.black87,
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
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade200),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 9,
                fontWeight: FontWeight.w500,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
