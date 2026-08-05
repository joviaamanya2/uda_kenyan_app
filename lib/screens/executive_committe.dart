// lib/screens/executive_committee_screen.dart
import 'package:flutter/material.dart';

class ExecutiveCommitteeScreen extends StatelessWidget {
  const ExecutiveCommitteeScreen({super.key});

  final List<Map<String, String>> committeeMembers = const [
    {
      'name': 'H.E Dr. William Ruto',
      'title': 'National Chairman',
      'image': 'https://via.placeholder.com/80x80/1A5C2A/FFCC00?text=WR',
    },
    {
      'name': 'Hon. Rigathi Gachagua',
      'title': '1st National Vice Chairman',
      'image': 'https://via.placeholder.com/80x80/FFCC00/1A5C2A?text=RG',
    },
    {
      'name': 'Hon. Musalia Mudavadi',
      'title': '2nd National Vice Chairperson',
      'image': 'https://via.placeholder.com/80x80/1A5C2A/FFCC00?text=MM',
    },
    {
      'name': 'Hon. Cleophas Malala',
      'title': 'Secretary General',
      'image': 'https://via.placeholder.com/80x80/FFCC00/1A5C2A?text=CM',
    },
    {
      'name': 'Hon. Hassan Omar',
      'title': 'Vice Chairperson - Coast',
      'image': 'https://via.placeholder.com/80x80/1A5C2A/FFCC00?text=HO',
    },
    {
      'name': 'Hon. Githinji Njoroge',
      'title': 'Vice Chairperson - Central',
      'image': 'https://via.placeholder.com/80x80/FFCC00/1A5C2A?text=GN',
    },
    {
      'name': 'Hon. Mary Kiguru',
      'title': 'Vice Chairperson - Women',
      'image': 'https://via.placeholder.com/80x80/1A5C2A/FFCC00?text=MK',
    },
    {
      'name': 'Hon. Julius Kipyegon',
      'title': 'Vice Chairperson - Youth',
      'image': 'https://via.placeholder.com/80x80/FFCC00/1A5C2A?text=JK',
    },
    {
      'name': 'Hon. Esther Mwangi',
      'title': 'Treasurer',
      'image': 'https://via.placeholder.com/80x80/1A5C2A/FFCC00?text=EM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'EXECUTIVE COMMITTEE',
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
                print('🔍 Search committee members');
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
            // Header Section
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
                    'UDA EXECUTIVE COMMITTEE',
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

            // Committee Members List
            ...committeeMembers.map((member) => _buildCommitteeCard(
              name: member['name']!,
              title: member['title']!,
              image: member['image']!,
            )).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildCommitteeCard({
    required String name,
    required String title,
    required String image,
  }) {
    return GestureDetector(
      onTap: () {
        print('👤 $name tapped');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
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
          border: Border.all(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Avatar
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFFFFCC00),
                  width: 2,
                ),
                color: const Color(0xFF1A5C2A),
              ),
              child: Center(
                child: Text(
                  name.split(' ').map((word) => word[0]).join('').substring(0, 2).toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A5C2A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFCC00),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A5C2A),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFFFFCC00),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
