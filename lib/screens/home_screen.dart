// lib/screens/home_screen.dart
import 'package:flutter/material.dart';

class UDAHomeScreen extends StatelessWidget {
  const UDAHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Column(
        children: [
          // Custom Header
          _buildHeader(),
          // Custom Navigation Bar
          _buildNavTabs(),
          // Scrollable Body
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(), // ✅ Added for smoother scrolling
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero Banner Image
                  _buildHeroBanner(),
                  const SizedBox(height: 16),
                  
                  // Quick Action Grid (Officials & Candidates)
                  _buildQuickActions(),
                  const SizedBox(height: 16),
                  
                  // News Update Card
                  _buildNewsUpdateCard(),
                  const SizedBox(height: 16),
                  
                  // UDA Chairman Section
                  _buildChairmanSection(),
                  const SizedBox(height: 16),
                  
                  // Near You & Roadmap Grid
                  _buildResourceGrid(),
                  const SizedBox(height: 16),
                  
                  // Contact Us Section
                  _buildContactUs(),
                  const SizedBox(height: 16), // ✅ Reduced from 24
                  
                  // Bottom Action Buttons
                  _buildBottomActions(),
                  const SizedBox(height: 24),
                  
                  // Footer with Logo
                  _buildFooter(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: const Color(0xFFFFCC00), // UDA Yellow
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 12),
      child: Row(
        children: [
          // Updated to use the actual logo asset
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF1A5C2A), width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Text(
                      'UDA',
                      style: TextStyle(
                        color: Color(0xFF1A5C2A),
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'UDA',
                style: TextStyle(
                  color: Color(0xFF1A5C2A),
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                'United Democratic Alliance',
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          const Icon(Icons.notifications_none, color: Color(0xFF1A5C2A), size: 28),
        ],
      ),
    );
  }

  Widget _buildNavTabs() {
    final tabs = ['HOME', 'ACHIEVEMENTS', 'GALLERY', 'NEWS', 'ABOUT'];
    return Container(
      color: Colors.white,
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        itemCount: tabs.length,
        itemBuilder: (context, index) {
          final isActive = index == 0;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: isActive ? const Color(0xFFFFCC00) : Colors.transparent,
                  width: 3,
                ),
              ),
            ),
            child: Center(
              child: Text(
                tabs[index],
                style: TextStyle(
                  color: isActive ? const Color(0xFF1A5C2A) : Colors.grey,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  fontSize: 13,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeroBanner() {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.black,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Placeholder for rally image - ✅ Updated with better placeholder
          Container(
            color: const Color(0xFF2E7D32),
            child: const Icon(Icons.groups, size: 100, color: Colors.white24),
          ),
          // Bottom gradient overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  color: const Color(0xFFFFCC00),
                  child: const Text(
                    'UDA ELECTS 2027',
                    style: TextStyle(
                      color: Color(0xFF1A5C2A),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'KAZI NI KAZI',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _actionCard(
              title: 'UDA Officials',
              bgColor: const Color(0xFF1A5C2A),
              icon: Icons.people,
              onTap: () {
                // ✅ Added navigation placeholder
                print('🔵 Navigate to UDA Officials');
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _actionCard(
              title: 'UDA Candidates',
              bgColor: const Color(0xFFFFCC00),
              icon: Icons.how_to_reg,
              textColor: const Color(0xFF1A5C2A),
              onTap: () {
                // ✅ Added navigation placeholder
                print('🟡 Navigate to UDA Candidates');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionCard({
    required String title,
    required Color bgColor,
    required IconData icon,
    Color textColor = Colors.white,
    VoidCallback? onTap, // ✅ Added onTap parameter
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 90,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: textColor),
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsUpdateCard() {
    return GestureDetector(
      onTap: () {
        print('📰 News card tapped');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFFFCC00), width: 2),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Icon(Icons.article, color: Color(0xFF1A5C2A), size: 20),
                SizedBox(width: 8),
                Text(
                  'NEWS UPDATE',
                  style: TextStyle(
                    color: Color(0xFF1A5C2A),
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const Divider(height: 16, thickness: 1),
            const Text(
              'Roadmap for UDA grassroots elections and National Delegates Convention',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: const [
                Icon(Icons.calendar_today, size: 12, color: Colors.grey),
                SizedBox(width: 4),
                Text(
                  'Wed, 10 Aug 2024',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'The United Democratic Alliance has officially released the timetable for party grassroots elections...',
              style: TextStyle(color: Colors.black54, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChairmanSection() {
    return GestureDetector(
      onTap: () {
        print('👤 Chairman profile tapped');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            )
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFFFCC00), width: 3),
                // ✅ Better placeholder image
                image: const DecorationImage(
                  image: NetworkImage('https://via.placeholder.com/150/1A5C2A/FFCC00?text=W.R'),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Icon(Icons.person, size: 40, color: Colors.grey),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'UDA CHAIRMAN',
                    style: TextStyle(
                      color: Color(0xFFFFCC00),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'H.E Dr. William Ruto',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1A5C2A),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Party Leader & President of Kenya',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResourceGrid() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: _resourceCard(
              title: 'UDA Near You',
              subtitle: 'Find your local office',
              icon: Icons.location_on,
              onTap: () {
                print('📍 UDA Near You tapped');
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _resourceCard(
              title: 'Political Road Map',
              subtitle: '2024 - 2027 Plan',
              icon: Icons.map,
              onTap: () {
                print('🗺️ Roadmap tapped');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _resourceCard({
    required String title,
    required String subtitle,
    required IconData icon,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: const Color(0xFF1A5C2A)),
            const Spacer(),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: const TextStyle(fontSize: 11, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactUs() {
    return GestureDetector(
      onTap: () {
        print('📞 Contact Us tapped');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A5C2A),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'CONTACT US',
                    style: TextStyle(
                      color: Color(0xFFFFCC00),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Got any queries or issues about UDA? Call +254 720 000 000',
                    style: TextStyle(color: Colors.white, fontSize: 13),
                  ),
                ],
              ),
            ),
            const Icon(Icons.phone, color: Color(0xFFFFCC00)),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A5C2A),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.support_agent),
              label: const Text(
                'SUPPORT CENTER',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                print('🆘 Support Center tapped');
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFCC00),
                foregroundColor: const Color(0xFF1A5C2A),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(Icons.chat),
              label: const Text(
                'CHAT',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                print('💬 Chat tapped');
              },
            ),
          ),
        ],
      ),
    );
  }

  // Added footer to match NRM App layout and show logo at the bottom too
  Widget _buildFooter() {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFFFCC00), width: 3),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Text(
                      'UDA',
                      style: TextStyle(
                        color: Color(0xFF1A5C2A),
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'UNITED DEMOCRATIC ALLIANCE',
          style: TextStyle(
            color: Color(0xFF1A5C2A),
            fontWeight: FontWeight.w900,
            fontSize: 14,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 4),
        const Text(
          'KAZI NI KAZI',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}