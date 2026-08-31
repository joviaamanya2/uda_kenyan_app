// lib/screens/about_uda_screen.dart
import 'package:flutter/material.dart';
import 'join_uda.dart';
import 'fundraise_screen.dart';
import 'contact_screen.dart';
import 'uda_leadears.dart';
import 'achievements_screen.dart';
import 'info_page_screen.dart';
import 'our_location.dart';
import 'about_us.dart';
import './Resource_center/resource_center.dart';
import 'grassroots_elections.dart';
import '../theme/theme_ext.dart';

class AboutUDAScreen extends StatelessWidget {
  final bool embedded;
  const AboutUDAScreen({super.key, this.embedded = false});

  final List<Map<String, dynamic>> menuItems = const [
    {'title': 'How To Join UDA', 'icon': Icons.person_add},
    {'title': 'About Us', 'icon': Icons.info},
    {'title': 'Our Team', 'icon': Icons.people},
    {'title': 'Our Location', 'icon': Icons.location_on}, // Fixed icon
    {'title': 'Resource Center', 'icon': Icons.folder_open},
    {'title': 'Grassroots Elections', 'icon': Icons.how_to_vote},
    {'title': 'Fundraising', 'icon': Icons.attach_money},
    {'title': 'Contact Us', 'icon': Icons.contact_mail},
    {'title': 'Achievements', 'icon': Icons.emoji_events},
    {'title': 'Privacy Policy', 'icon': Icons.privacy_tip},
    {'title': 'Terms & Conditions', 'icon': Icons.description},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: embedded
          ? null
          : AppBar(
              title: const Text(
                'ABOUT UDA',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
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
            ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quick Stats Section
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.surface,
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
                    child: _buildStatItem(
                      context,
                      'Members',
                      '12M+',
                      Icons.people,
                    ),
                  ),
                  Expanded(
                    child: _buildStatItem(
                      context,
                      'Branches',
                      '290+',
                      Icons.location_city,
                    ),
                  ),
                  Expanded(
                    child: _buildStatItem(context, 'Counties', '47', Icons.map),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // Menu Items List
            Container(
              color: context.surface,
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

  Widget _buildStatItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
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
          style: TextStyle(color: context.textMuted, fontSize: 12),
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
          border: Border(bottom: BorderSide(color: context.surfaceAlt)),
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
          MaterialPageRoute(
            builder: (context) => const InfoPageScreen(
              title: 'Privacy Policy',
              lastUpdated: 'August 2026',
              sections: udaPrivacyPolicySections,
            ),
          ),
        );
        break;

      case 'Terms & Conditions':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const InfoPageScreen(
              title: 'Terms & Conditions',
              lastUpdated: 'August 2026',
              sections: udaTermsSections,
            ),
          ),
        );
        break;
    }
  }
}
