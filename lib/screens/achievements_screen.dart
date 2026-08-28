// lib/screens/achievements_screen.dart
import 'package:flutter/material.dart';
import 'achievements_details.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'ACHIEVEMENTS',
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
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Water and Sanitation Card
            _buildAchievementCard(
              title: 'Water and Sanitation',
              imageAsset: 'assets/images/water.jpg',
              color: 0xFF1A5C2A,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AchievementDetailsScreen(
                      title: 'Water and Sanitation',
                      sections: [
                        AchievementSection(
                          title: 'Waste management',
                          content:
                              'Solid waste management in Kenya is actively done by the county governments assisted by private garbage collectors and in other towns; it\'s the responsibility of the town council.',
                        ),
                        AchievementSection(
                          title: 'Waste recycling',
                          content:
                              'Plans of constructing waste recycling plants are underway. They will produce fertilisers, generate power and a host of other materials, including job creation for those involved.',
                        ),
                        AchievementSection(
                          title: 'Increased access to safe water',
                          content:
                              'The government has increased access to safe water for all Kenyans through construction of new water treatment plants and rehabilitation of existing ones.',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            // Youth Empowerment Card
            _buildAchievementCard(
              title: 'Youth Empowerment',
              imageAsset: 'assets/images/youth.jpg',
              color: 0xFFFFCC00,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AchievementDetailsScreen(
                      title: 'Youth Empowerment',
                      sections: [
                        AchievementSection(
                          title: 'Youth employment',
                          content:
                              'Creation of youth employment opportunities through various government programs including Kazi Mtaani and Youth Enterprise Development Fund.',
                        ),
                        AchievementSection(
                          title: 'Skills development',
                          content:
                              'Training and skills development programs for young entrepreneurs to enable them to start and grow their own businesses.',
                        ),
                        AchievementSection(
                          title: 'Innovation hubs',
                          content:
                              'Establishment of youth innovation hubs across all counties to support young innovators and tech entrepreneurs.',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            // Economic Growth Card
            _buildAchievementCard(
              title: 'Economic Growth',
              imageAsset: 'assets/images/economy.jpg',
              color: 0xFF1A5C2A,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AchievementDetailsScreen(
                      title: 'Economic Growth',
                      sections: [
                        AchievementSection(
                          title: 'BETA agenda',
                          content:
                              'Implementation of the Bottom-Up Economic Transformation Agenda (BETA) to uplift the lives of ordinary Kenyans.',
                        ),
                        AchievementSection(
                          title: 'SME support',
                          content:
                              'Support for small and medium enterprises through funding, training, and market access programs.',
                        ),
                        AchievementSection(
                          title: 'Agricultural productivity',
                          content:
                              'Increased agricultural productivity through fertilizer subsidies, extension services, and market linkages.',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            // Healthcare Card
            _buildAchievementCard(
              title: 'Healthcare Access',
              imageAsset: 'assets/images/healthcare.jpg',
              color: 0xFFFFCC00,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AchievementDetailsScreen(
                      title: 'Healthcare Access',
                      sections: [
                        AchievementSection(
                          title: 'Universal healthcare',
                          content:
                              'Expansion of universal healthcare coverage to ensure all Kenyans have access to quality healthcare services.',
                        ),
                        AchievementSection(
                          title: 'New hospitals',
                          content:
                              'Construction of new hospitals and health centers across the country to improve healthcare access.',
                        ),
                        AchievementSection(
                          title: 'Maternal health',
                          content:
                              'Improved maternal and child healthcare services with reduced maternal mortality rates.',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            // Education Reforms Card
            _buildAchievementCard(
              title: 'Education Reforms',
              imageAsset: 'assets/images/education.jpg',
              color: 0xFF1A5C2A,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AchievementDetailsScreen(
                      title: 'Education Reforms',
                      sections: [
                        AchievementSection(
                          title: 'CBC implementation',
                          content:
                              'Competency-Based Curriculum (CBC) implementation to produce holistic and competent learners.',
                        ),
                        AchievementSection(
                          title: 'School infrastructure',
                          content:
                              'Construction of new schools and classrooms to accommodate the growing number of learners.',
                        ),
                        AchievementSection(
                          title: 'Digital learning',
                          content:
                              'Digital learning initiatives in rural schools to bridge the technology gap and improve learning outcomes.',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            // Infrastructure Card
            _buildAchievementCard(
              title: 'Infrastructure Development',
              imageAsset: 'assets/images/infrastructure.jpg',
              color: 0xFFFFCC00,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AchievementDetailsScreen(
                      title: 'Infrastructure Development',
                      sections: [
                        AchievementSection(
                          title: 'Road network',
                          content:
                              'Construction and rehabilitation of roads across the country to improve connectivity and trade.',
                        ),
                        AchievementSection(
                          title: 'Railway expansion',
                          content:
                              'Expansion of railway network to connect major cities and improve cargo transportation.',
                        ),
                        AchievementSection(
                          title: 'Renewable energy',
                          content:
                              'Development of renewable energy projects to increase access to clean and affordable energy.',
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            // Footer
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey.shade300),
                  bottom: BorderSide(color: Colors.grey.shade300),
                ),
              ),
              child: const Center(
                child: Text(
                  'UDA - KAZI NI KAZI',
                  style: TextStyle(
                    color: Color(0xFF1A5C2A),
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementCard({
    required String title,
    required String imageAsset,
    required int color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
              child: Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://via.placeholder.com/400x160/${color == 0xFF1A5C2A ? '1A5C2A' : 'FFCC00'}/FFFFFF?text=$title',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    // Dark overlay for better text visibility
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.3),
                          ],
                        ),
                      ),
                    ),
                    // Title on image
                    Positioned(
                      bottom: 16,
                      left: 16,
                      child: Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Colors.black45,
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Arrow icon on the right
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 4,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Color(0xFF1A5C2A),
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Dashed line under image
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(height: 1, color: Colors.grey.shade300),
            ),
            const SizedBox(height: 12),
            // Short description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                _getDescription(title),
                style: const TextStyle(fontSize: 13, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 12),
            // Read more button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Learn more',
                    style: TextStyle(
                      color: Color(0xFFFFCC00),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward,
                    color: Color(0xFFFFCC00),
                    size: 16,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  String _getDescription(String title) {
    switch (title) {
      case 'Water and Sanitation':
        return 'Improving waste management and access to clean water for all Kenyans.';
      case 'Youth Empowerment':
        return 'Creating jobs and opportunities for Kenya\'s young population.';
      case 'Economic Growth':
        return 'Building a stronger economy through the BETA agenda.';
      case 'Healthcare Access':
        return 'Ensuring quality healthcare for every Kenyan.';
      case 'Education Reforms':
        return 'Transforming education for a better future.';
      case 'Infrastructure Development':
        return 'Building the infrastructure for a modern Kenya.';
      default:
        return 'Achieving progress for all Kenyans.';
    }
  }
}
