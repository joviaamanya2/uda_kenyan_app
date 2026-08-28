// lib/screens/about_uda_screen.dart
import 'package:flutter/material.dart';
import 'join_uda.dart';
import 'gallery.dart';
import 'fundraise_screen.dart';
import 'contact_screen.dart';
import 'ask_president.dart';
import 'uda_leadears.dart';
import 'executive_committe.dart';
import 'rdcs_and_drdcs.dart';
import 'uda_candidates.dart';
import 'achievements_screen.dart';
import 'events.dart';
import 'news_room.dart';
import 'our_location.dart';
import 'about_us.dart';
import './Resource_center/resource_center.dart';
import 'grassroots_elections.dart';

class AboutUDAScreen extends StatelessWidget {
  const AboutUDAScreen({super.key});

  final List<Map<String, dynamic>> menuItems = const [
    {'title': 'How To Join UDA', 'icon': Icons.person_add},
    {'title': 'About Us', 'icon': Icons.info},
    {'title': 'Our Team', 'icon': Icons.people},
    {'title': 'Our Location', 'icon': Icons.location_on}, // Fixed icon
    {'title': 'Resource Center', 'icon': Icons.folder_open},
    {'title': 'Grassroots Elections', 'icon': Icons.how_to_vote},
    {'title': 'UDA Gallery', 'icon': Icons.photo_library},
    {'title': 'Fundraising', 'icon': Icons.attach_money},
    {'title': 'Contact Us', 'icon': Icons.contact_mail},
    {'title': 'Achievements', 'icon': Icons.emoji_events},
    {'title': 'Privacy Policy', 'icon': Icons.privacy_tip},
    {'title': 'Terms & Conditions', 'icon': Icons.description},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'ABOUT UDA',
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
              icon: const Icon(Icons.search, color: Colors.black),
              onPressed: () {
                print('🔍 Search in About UDA');
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
            // Header Section with Logo
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1A5C2A), Color(0xFF2E7D32)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
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
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Text(
                              'UDA',
                              style: TextStyle(
                                color: Color(0xFF1A5C2A),
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'UNITED DEMOCRATIC ALLIANCE',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'KAZI NI KAZI',
                    style: TextStyle(
                      color: Color(0xFFFFCC00),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),

            // Quick Stats Section
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: _buildStatItem('Members', '12M+', Icons.people),
                  ),
                  Expanded(
                    child: _buildStatItem(
                      'Branches',
                      '290+',
                      Icons.location_city,
                    ),
                  ),
                  Expanded(child: _buildStatItem('Counties', '47', Icons.map)),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Menu Items List
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  ...menuItems
                      .map(
                        (item) => _buildMenuItem(
                          context: context,
                          title: item['title'] as String,
                          icon: item['icon'] as IconData,
                        ),
                      )
                      .toList(),
                ],
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: const Color(0xFF1A5C2A), size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color(0xFF1A5C2A),
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          label,
          style: TextStyle(color: Colors.grey[600], fontSize: 12),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required String title,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: () {
        _navigateToMenuItem(context, title);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFFFCC00),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: const Color(0xFF1A5C2A), size: 20),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1A5C2A),
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFFFFCC00),
              size: 14,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: color == const Color(0xFF1A5C2A)
                  ? Colors.white
                  : Colors.black,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: color == const Color(0xFF1A5C2A)
                    ? Colors.white
                    : Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToMenuItem(BuildContext context, String title) {
    switch (title) {
      case 'How To Join UDA':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const JoinUDAScreen()),
        );
        break;

      case 'About Us':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AboutScreen()),
        );
        break;

      case 'Our Team':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const UDALeadersScreen()),
        );
        break;

      case 'Our Location':
        // FIXED: Navigates to LocationsScreen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LocationsScreen()),
        );
        break;

      case 'Resource Center':
        // Navigate to Resource Center
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ResourceCenterScreen()),
        );
        break;

      case 'Grassroots Elections':
        // Navigate to Grassroots Elections
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const GrassrootsElectionsScreen(),
          ),
        );
        break;

      case 'UDA Gallery':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const GalleryScreen()),
        );
        break;

      case 'Fundraising':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FundraiseScreen()),
        );
        break;

      case 'Contact Us':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ContactScreen()),
        );
        break;

      case 'Achievements':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AchievementsScreen()),
        );
        break;

      case 'Privacy Policy':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EventsScreen()),
        );
        break;

      case 'Terms & Conditions':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NewsScreen()),
        );
        break;

      default:
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$title section coming soon!'),
            backgroundColor: const Color(0xFF1A5C2A),
            duration: const Duration(seconds: 2),
          ),
        );
    }
  }
}
