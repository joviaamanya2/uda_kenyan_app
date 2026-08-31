// lib/screens/achievements_screen.dart
import 'package:flutter/material.dart';
import 'achievements_details.dart';
import '../services/api_service.dart';
import '../theme/theme_ext.dart';

class AchievementsScreen extends StatefulWidget {
  final bool embedded;
  const AchievementsScreen({super.key, this.embedded = false});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  static const _monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  // Bundled offline fallback; _loadAchievements() replaces it with live data
  // from the backend (achievements managed in the admin dashboard).
  List<Map<String, dynamic>> _achievements = [
    {
      'title': 'Water and Sanitation',
      'description':
          'Improving waste management and access to clean water for all Kenyans.',
      'color': 0xFF1A5C2A,
      'image': 'assets/images/water.jpg',
      'sections': const [
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
    },
    {
      'title': 'Youth Empowerment',
      'description':
          'Creating jobs and opportunities for Kenya\'s young population.',
      'color': 0xFFFFCC00,
      'image': 'assets/images/youth.jpg',
      'sections': const [
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
    },
    {
      'title': 'Economic Growth',
      'description': 'Building a stronger economy through the BETA agenda.',
      'color': 0xFF1A5C2A,
      'image': 'assets/images/economy.jpg',
      'sections': const [
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
    },
    {
      'title': 'Healthcare Access',
      'description': 'Ensuring quality healthcare for every Kenyan.',
      'color': 0xFFFFCC00,
      'image': 'assets/images/healthcare.jpg',
      'sections': const [
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
    },
    {
      'title': 'Education Reforms',
      'description': 'Transforming education for a better future.',
      'color': 0xFF1A5C2A,
      'image': 'assets/images/education.jpg',
      'sections': const [
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
    },
    {
      'title': 'Infrastructure Development',
      'description': 'Building the infrastructure for a modern Kenya.',
      'color': 0xFFFFCC00,
      'image': 'assets/images/infrastructure.jpg',
      'sections': const [
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
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadAchievements();
  }

  Future<void> _loadAchievements() async {
    try {
      final remote = await ApiService.instance.getList('achievements');
      if (!mounted || remote.isEmpty) return;
      setState(() {
        _achievements = remote.asMap().entries.map((entry) {
          final item = entry.value;
          return {
            'title': (item['title'] ?? 'Achievement').toString(),
            'description': (item['description'] ?? '').toString(),
            'color': entry.key.isEven ? 0xFF1A5C2A : 0xFFFFCC00,
            'image': (item['image_path'] ?? '').toString(),
            'date': _formatDate(item['date']),
            'sections': const <AchievementSection>[],
          };
        }).toList();
      });
    } catch (_) {
      // Keep the bundled content when the API is offline.
    }
  }

  String _formatDate(dynamic raw) {
    if (raw == null) return '';
    final parsed = DateTime.tryParse(raw.toString());
    if (parsed == null) return raw.toString();
    return '${parsed.day} ${_monthNames[parsed.month - 1]} ${parsed.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: widget.embedded
          ? null
          : AppBar(
              title: const Text(
                'ACHIEVEMENTS',
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
                onPressed: () => Navigator.pop(context),
              ),
            ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_achievements.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 48),
                child: Center(
                  child: Text(
                    'No achievements yet.',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ..._achievements.map(_buildAchievementCard),
            if (_achievements.isNotEmpty) ...[
              const SizedBox(height: 4),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: context.hairline),
                    bottom: BorderSide(color: context.hairline),
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
          ],
        ),
      ),
    );
  }

  Widget _buildAchievementCard(Map<String, dynamic> item) {
    final title = item['title'] as String;
    final description = (item['description'] as String?) ?? '';
    final image = (item['image'] as String?) ?? '';
    final color = item['color'] as int;
    final sections =
        (item['sections'] as List?)?.cast<AchievementSection>() ?? const [];

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AchievementDetailsScreen(
                title: title,
                sections: sections,
                description: description,
                imagePath: image,
                date: item['date'] as String?,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: context.surface,
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
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      _cardImage(image, color),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.45),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 16,
                        left: 16,
                        right: 16,
                        child: Row(
                          children: [
                            Expanded(
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
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.arrow_forward,
                                color: Color(0xFF1A5C2A),
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(height: 1, color: context.hairline),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  description.isEmpty
                      ? 'Read more about this achievement.'
                      : description,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 12),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Learn more',
                      style: TextStyle(
                        color: Color(0xFFFFCC00),
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    Icon(
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
      ),
    );
  }

  Widget _cardImage(String path, int color) {
    if (path.startsWith('http')) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(color: Color(color)),
      );
    }
    if (path.isNotEmpty) {
      return Image.asset(
        path,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(color: Color(color)),
      );
    }
    return Container(color: Color(color));
  }
}
