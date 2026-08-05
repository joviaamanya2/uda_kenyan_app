// lib/screens/uda_leaders_screen.dart
import 'package:flutter/material.dart';

class UDALeadersScreen extends StatefulWidget {
  const UDALeadersScreen({super.key});

  @override
  State<UDALeadersScreen> createState() => _UDALeadersScreenState();
}

class _UDALeadersScreenState extends State<UDALeadersScreen> {
  final Map<String, bool> _expandedSections = {
    'National Chairperson': false,
    'Secretary General': false,
    'National Treasurer': false,
    'Electoral Commission': false,
    'National Secretariat Directors': false,
  };

  final Map<String, List<Map<String, String>>> _leadersData = {
    'National Chairperson': [
      {
        'name': 'H.E Dr. William Ruto',
        'title': 'Chairman - UDA',
        'image': 'https://via.placeholder.com/50x50/1A5C2A/FFCC00?text=WR',
      },
    ],
    'Secretary General': [
      {
        'name': 'Hon. Cleophas Malala',
        'title': 'Secretary General - UDA',
        'image': 'https://via.placeholder.com/50x50/FFCC00/1A5C2A?text=CM',
      },
      {
        'name': 'Hon. Mary Kiguru',
        'title': 'Deputy Secretary General',
        'image': 'https://via.placeholder.com/50x50/1A5C2A/FFCC00?text=MK',
      },
    ],
    'National Treasurer': [
      {
        'name': 'Hon. Esther Mwangi',
        'title': 'National Treasurer',
        'image': 'https://via.placeholder.com/50x50/FFCC00/1A5C2A?text=EM',
      },
      {
        'name': 'Hon. Julius Kipyegon',
        'title': 'Deputy National Treasurer',
        'image': 'https://via.placeholder.com/50x50/1A5C2A/FFCC00?text=JK',
      },
    ],
    'Electoral Commission': [
      {
        'name': 'Hon. Githinji Njoroge',
        'title': 'Chairperson - Electoral Commission',
        'image': 'https://via.placeholder.com/50x50/FFCC00/1A5C2A?text=GN',
      },
      {
        'name': 'Hon. Grace Akinyi',
        'title': 'Vice Chairperson - Electoral Commission',
        'image': 'https://via.placeholder.com/50x50/1A5C2A/FFCC00?text=GA',
      },
      {
        'name': 'Hon. John Mwangi',
        'title': 'Commissioner - Electoral Commission',
        'image': 'https://via.placeholder.com/50x50/FFCC00/1A5C2A?text=JM',
      },
    ],
    'National Secretariat Directors': [
      {
        'name': 'Hon. David Were',
        'title': 'Director - Administration',
        'image': 'https://via.placeholder.com/50x50/1A5C2A/FFCC00?text=DW',
      },
      {
        'name': 'Hon. Caroline Omondi',
        'title': 'Director - Finance',
        'image': 'https://via.placeholder.com/50x50/FFCC00/1A5C2A?text=CO',
      },
      {
        'name': 'Hon. Mohammed Hassan',
        'title': 'Director - Communications',
        'image': 'https://via.placeholder.com/50x50/1A5C2A/FFCC00?text=MH',
      },
      {
        'name': 'Hon. Sarah Lokenyo',
        'title': 'Director - Research & Policy',
        'image': 'https://via.placeholder.com/50x50/FFCC00/1A5C2A?text=SL',
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'UDA LEADERS',
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
                print('🔍 Search leaders');
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1A5C2A), Color(0xFF2E7D32)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.groups,
                    color: Color(0xFFFFCC00),
                    size: 48,
                  ),
                  SizedBox(height: 12),
                  Text(
                    'UDA LEADERSHIP',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
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
            const SizedBox(height: 20),

            // Leadership Sections with Dropdown
            ..._leadersData.keys.map((section) => _buildSection(
              title: section,
              leaders: _leadersData[section]!,
              isExpanded: _expandedSections[section] ?? false,
              onToggle: () {
                setState(() {
                  _expandedSections[section] = !(_expandedSections[section] ?? false);
                });
              },
            )).toList(),
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
        children: [
          // Section Header (Clickable to expand/collapse)
          GestureDetector(
            onTap: onToggle,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: BoxDecoration(
                color: const Color(0xFF1A5C2A),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(isExpanded ? 12 : 12),
                  topRight: Radius.circular(isExpanded ? 12 : 12),
                  bottomLeft: Radius.circular(isExpanded ? 0 : 12),
                  bottomRight: Radius.circular(isExpanded ? 0 : 12),
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.person,
                    color: Color(0xFFFFCC00),
                    size: 20,
                  ),
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
    return GestureDetector(
      onTap: () {
        print('👤 $name tapped');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey.shade200,
            width: 1,
          ),
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
                border: Border.all(
                  color: const Color(0xFFFFCC00),
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  name.split(' ').map((word) => word[0]).join('').substring(0, 2).toUpperCase(),
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
                    style: const TextStyle(
                      fontSize: 11,
                      color: Colors.grey,
                    ),
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
      ),
    );
  }
}
