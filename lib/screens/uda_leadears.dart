// lib/screens/uda_leaders_screen.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../theme/theme_ext.dart';

class UDALeadersScreen extends StatefulWidget {
  const UDALeadersScreen({super.key});

  @override
  State<UDALeadersScreen> createState() => _UDALeadersScreenState();
}

class _UDALeadersScreenState extends State<UDALeadersScreen> {
  static const _sectionOrder = [
    'Party Leader',
    'Deputy Party Leader',
    'National Chairperson',
    'Secretary General',
    'National Treasurer',
  ];

  final Map<String, bool> _expandedSections = {
    'Party Leader': false,
    'Deputy Party Leader': false,
    'National Chairperson': false,
    'Secretary General': false,
    'National Treasurer': false,
  };

  // Bundled offline fallback; _loadLeaders() replaces it with live data from
  // the backend (leaders with category=party_leadership, grouped by section).
  Map<String, List<Map<String, String>>> _leadersData = {
    'Party Leader': [
      {
        'name': 'H.E Dr. William Samoei Ruto',
        'title': 'Party Leader - UDA / President of the Republic of Kenya',
        'image': '',
      },
    ],
    'Deputy Party Leader': [
      {
        'name': 'Prof. Kithure Kindiki',
        'title': 'Deputy Party Leader / Deputy President of Kenya',
        'image': '',
      },
      {
        'name': 'H.E Issa Timamy',
        'title': 'Deputy Party Leader / Governor, Lamu County',
        'image': '',
      },
    ],
    'National Chairperson': [
      {
        'name': 'H.E Cecily Mbarire',
        'title': 'National Chairperson / Governor, Embu County',
        'image': '',
      },
      {
        'name': 'Mr. Kelvin Lunani',
        'title': 'National Vice-Chairperson',
        'image': '',
      },
    ],
    'Secretary General': [
      {
        'name': 'Sen. Hassan Omar',
        'title': 'Secretary General - UDA',
        'image': '',
      },
      {
        'name': 'Hon. Omboko Milemba',
        'title': 'Deputy Secretary General / MP, Emuhaya Constituency',
        'image': '',
      },
    ],
    'National Treasurer': [
      {
        'name': 'Hon. Japheth Nyakundi',
        'title': 'National Treasurer - UDA',
        'image': '',
      },
    ],
  };

  @override
  void initState() {
    super.initState();
    _loadLeaders();
  }

  Future<void> _loadLeaders() async {
    try {
      final remote = await ApiService.instance.getList(
        'leaders?category=party_leadership',
      );
      if (!mounted || remote.isEmpty) return;

      final grouped = <String, List<Map<String, String>>>{};
      for (final section in _sectionOrder) {
        final members = remote
            .where((item) => item['section'] == section)
            .map(
              (item) => {
                'name': (item['name'] ?? '').toString(),
                'title': (item['position'] ?? '').toString(),
                'image': (item['photo_path'] ?? '').toString(),
              },
            )
            .toList();
        if (members.isNotEmpty) grouped[section] = members;
      }
      if (grouped.isEmpty) return;

      setState(() {
        _leadersData = grouped;
      });
    } catch (_) {
      // Keep bundled content available when the API is offline.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        title: const Text(
          'UDA LEADERS',
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
            // Leadership Sections with Dropdown
            ..._leadersData.keys
                .map(
                  (section) => _buildSection(
                    title: section,
                    leaders: _leadersData[section]!,
                    isExpanded: _expandedSections[section] ?? false,
                    onToggle: () {
                      setState(() {
                        _expandedSections[section] =
                            !(_expandedSections[section] ?? false);
                      });
                    },
                  ),
                )
                .toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Map<String, String>> leaders,
    required bool isExpanded,
    required VoidCallback onToggle,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
        children: [
          // Section Header (Clickable to expand/collapse)
          GestureDetector(
            onTap: onToggle,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFF1A5C2A),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isExpanded ? 0 : 16),
                  bottomRight: Radius.circular(isExpanded ? 0 : 16),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.person, color: Color(0xFFFFCC00), size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: const Color(0xFFFFCC00),
                    size: 24,
                  ),
                ],
              ),
            ),
          ),

          // Leaders List (Expandable)
          if (isExpanded)
            Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: leaders.map((leader) {
                  return _buildLeaderItem(
                    name: leader['name']!,
                    title: leader['title']!,
                    image: leader['image']!,
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLeaderItem({
    required String name,
    required String title,
    required String image,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.surfaceAlt,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.hairline, width: 1),
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF1A5C2A),
              border: Border.all(color: const Color(0xFFFFCC00), width: 2),
            ),
            child: Center(
              child: Text(
                name
                    .split(' ')
                    .map((word) => word[0])
                    .join('')
                    .substring(0, 2)
                    .toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A5C2A),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: Color(0xFFFFCC00),
            size: 14,
          ),
        ],
      ),
    );
  }
}
