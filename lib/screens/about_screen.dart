// lib/screens/about_uda_screen.dart
import 'package:flutter/material.dart';
import 'join_uda.dart';
import 'videos_screen.dart';
import 'news_room.dart';
import 'gallery.dart';
import 'fundraise_screen.dart';

class AboutUDAScreen extends StatelessWidget {
  const AboutUDAScreen({super.key});

  final List<Map<String, dynamic>> menuItems = const [
    {'title': 'How To Join UDA', 'icon': Icons.person_add},
    {'title': 'About Us', 'icon': Icons.info},
    {'title': 'Our Constitution', 'icon': Icons.description},
    {'title': 'Party Structure', 'icon': Icons.account_tree},
    {'title': 'Our Documents', 'icon': Icons.folder_open},
    {'title': 'Our History', 'icon': Icons.history},
    {'title': 'UDA Gallery', 'icon': Icons.photo_library},
    {'title': 'Fundraising', 'icon': Icons.attach_money},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'ABOUT UDA',
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
                      border: Border.all(color: const Color(0xFFFFCC00), width: 3),
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

            // Navigation Tabs
            
            const SizedBox(height: 16),

            // Menu Items List
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  ...menuItems.map((item) => _buildMenuItem(
                    context: context,
                    title: item['title'] as String,
                    icon: item['icon'] as IconData,
                  )).toList(),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Footer Section - Support Center & Chat
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildFooterButton(
                        icon: Icons.support_agent,
                        label: 'SUPPORT CENTER',
                        color: const Color(0xFF1A5C2A),
                        onTap: () {
                          print('🆘 Support Center tapped');
                        },
                      ),
                      _buildFooterButton(
                        icon: Icons.chat,
                        label: 'CHAT',
                        color: const Color(0xFFFFCC00),
                        onTap: () {
                          print('💬 Chat tapped');
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'UDA - KAZI NI KAZI',
                    style: TextStyle(
                      color: Color(0xFF1A5C2A),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 1,
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

  Widget _buildTabItem(String title, IconData icon, VoidCallback onTap) {
    final isActive = title == 'ABOUT';
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Icon(
              icon,
              color: isActive ? const Color(0xFFFFCC00) : const Color(0xFF1A5C2A),
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              title,
              style: TextStyle(
                color: isActive ? const Color(0xFFFFCC00) : const Color(0xFF1A5C2A),
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required String title,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: () {
        print('📱 $title tapped');
        _navigateToMenuItem(context, title);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade100),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFFFCC00),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: const Color(0xFF1A5C2A),
                size: 20,
              ),
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
          borderRadius: BorderRadius.circular(8),
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
              color: color == const Color(0xFF1A5C2A) ? Colors.white : Colors.black,
              size: 18,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: color == const Color(0xFF1A5C2A) ? Colors.white : Colors.black,
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
        // Show about us dialog or navigate
        _showAboutDialog(context);
        break;
      case 'Our Constitution':
        _showDocumentDialog(context, 'UDA Constitution');
        break;
      case 'Party Structure':
        _showDocumentDialog(context, 'UDA Party Structure');
        break;
      case 'Our Documents':
        _showDocumentDialog(context, 'UDA Documents');
        break;
      case 'Our History':
        _showDocumentDialog(context, 'UDA History');
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
      default:
        print('📱 $title tapped');
    }
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'About UDA',
          style: TextStyle(
            color: Color(0xFF1A5C2A),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'The United Democratic Alliance (UDA) is a political party in Kenya.',
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
            SizedBox(height: 8),
            Text(
              'Our mission is to unite Kenyans, promote economic empowerment, '
              'and build a better future for all citizens through the '
              'Bottom-Up Economic Transformation Agenda (BETA).',
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
            SizedBox(height: 8),
            Text(
              'KAZI NI KAZI',
              style: TextStyle(
                color: Color(0xFFFFCC00),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFCC00),
              foregroundColor: const Color(0xFF1A5C2A),
            ),
            child: const Text('CLOSE'),
          ),
        ],
      ),
    );
  }

  void _showDocumentDialog(BuildContext context, String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            color: Color(0xFF1A5C2A),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          '$title document is currently being prepared. Please check back later.',
          style: const TextStyle(fontSize: 14, height: 1.5),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFCC00),
              foregroundColor: const Color(0xFF1A5C2A),
            ),
            child: const Text('CLOSE'),
          ),
        ],
      ),
    );
  }
}
