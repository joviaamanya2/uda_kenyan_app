// lib/screens/executive_committee_screen.dart
import 'package:flutter/material.dart';
import 'elects_details.dart';
import '../services/api_service.dart';

class ExecutiveCommitteeScreen extends StatefulWidget {
  const ExecutiveCommitteeScreen({super.key});

  @override
  State<ExecutiveCommitteeScreen> createState() =>
      _ExecutiveCommitteeScreenState();
}

class _ExecutiveCommitteeScreenState extends State<ExecutiveCommitteeScreen> {
  // Bundled offline fallback; _loadCommittee() replaces it with live data
  // from the backend (leaders with category=executive).
  List<Map<String, dynamic>> committeeMembers = [
    {
      'name': 'H.E Dr. William Ruto',
      'position': 'National Chairman',
      'image': 'assets/images/William Ruto.PNG',
      'bio':
          'H.E Dr. William Ruto is the President of Kenya and the National Chairman of UDA. He is committed to transforming Kenya through the Bottom-Up Economic Transformation Agenda.',
      'email': 'william.ruto@uda.go.ke',
      'phone': '+254 700 000 000',
      'office': 'State House, Nairobi',
    },
    {
      'name': 'H.E Cecily Mbarire',
      'position': 'CHAIRPERSON, Governor, Embu County',
      'image': 'assets/images/H.E Cecily Mbarire.PNG',
      'bio':
          'H.E Cecily Mbarire is the Governor of Embu County and the Chairperson of UDA. She is dedicated to the development and welfare of her constituents.',
      'email': 'cecily.mbarire@uda.go.ke',
      'phone': '+254 700 000 001',
      'office': 'Embu County Office',
    },
    {
      'name': 'Mr. Kelvin Lunani',
      'position': 'DEPUTY CHAIRPERSON',
      'image': 'assets/images/Mr. Kelvin Lunani.PNG',
      'bio':
          'Mr. Kelvin Lunani is the Deputy Chairperson of UDA. He is committed to the development and welfare of his constituents.',
      'email': 'kelvin.lunani@uda.go.ke',
      'phone': '+254 700 000 002',
      'office': 'Nairobi, Kenya',
    },
    {
      'name': 'H.E. Prof. Kithure Kindiki',
      'position': 'Deputy President of Kenya',
      'image': 'assets/images/H.E Prof. Kithure Kindiki.PNG',
      'bio':
          'H.E. Prof. Kithure Kindiki is the Deputy President of Kenyal of UDA. He is committed to the development and welfare of his constituents.',
      'email': 'cleophas.malala@uda.go.ke',
      'phone': '+254 700 000 003',
      'office': 'Nairobi, Kenya',
    },
    {
      'name': 'Hon. Hassan Omar',
      'position': 'Secretary General',
      'image': 'assets/images/Hon. Sen. Hassan Omar.PNG',
      'bio':
          'Hon. Hassan Omar is the Secretary General of UDA. He is committed to the development and welfare of his constituents.',
      'email': 'hassan.omar@uda.go.ke',
      'phone': '+254 700 000 004',
      'office': 'Mombasa, Kenya',
    },
    {
      'name': 'H.E. Issa Timamy',
      'position': 'Governor, Lamu County',
      'image': 'assets/images/H.E Issa Timamy.png',
      'bio':
          'H.E. Issa Timamy is the Governor of Lamu County and a member of the UDA Executive Committee. He is committed to the development and welfare of his constituents.',
      'email': 'issa.timamy@uda.go.ke',
      'phone': '+254 700 000 005',
      'office': 'Nyeri, Kenya',
    },
    {
      'name': 'Mr. Nicodemus Bore',
      'position': 'EXECUTIVE DIRECTOR',
      'image': 'assets/images/Mr. Nicodemus Bore.PNG',
      'bio':
          'Mr. Nicodemus Bore is the Executive Director of UDA. He is committed to the development and welfare of his constituents.',
      'email': 'nicodemus.bore@uda.go.ke',
      'phone': '+254 700 000 006',
      'office': 'Nairobi, Kenya',
    },
    {
      'name': 'Hon. Omboko Milemba',
      'position': 'DEPUTY SECRETARY GENERAL - MP Emuhaya Constituency',
      'image': 'assets/images/Omboko Milemba.PNG',
      'bio':
          'Hon. Omboko Milemba is the Deputy Secretary General of UDA. He is committed to the development and welfare of his constituents.',
      'email': 'omboko.milemba@uda.go.ke',
      'phone': '+254 700 000 007',
      'office': 'Nairobi, Kenya',
    },
    {
      'name': 'Hon. Japheth Nyakundi',
      'position': 'NATIONAL TREASURER',
      'image': 'assets/images/Hon. Japheth Nyakundi.PNG',
      'bio':
          'Hon. Japheth Nyakundi is the National Treasurer of UDA. He is committed to the development and welfare of his constituents.',
      'email': 'japheth.nyakundi@uda.go.ke',
      'phone': '+254 700 000 008',
      'office': 'Nairobi, Kenya',
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadCommittee();
  }

  Future<void> _loadCommittee() async {
    try {
      final remote = await ApiService.instance.getList(
        'leaders?category=executive',
      );
      if (!mounted || remote.isEmpty) return;
      setState(() {
        committeeMembers = remote
            .map(
              (item) => {
                'name': item['name'] ?? 'UDA Leader',
                'position': item['position'] ?? '',
                'image': item['photo_path'] ?? 'assets/images/uda_logo.png',
                'bio': item['bio'] ?? '',
                'email': item['email'] ?? '',
                'phone': item['phone'] ?? '',
                'office': item['office'] ?? '',
              },
            )
            .toList();
      });
    } catch (_) {
      // Keep bundled content available when the API is offline.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'EXECUTIVE COMMITTEE',
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
            // Committee Members List
            ...committeeMembers.map(
              (member) => _buildCommitteeCard(member: member, context: context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommitteeCard({
    required Map<String, dynamic> member,
    required BuildContext context,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ElectDetailsScreen(elect: member),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: Colors.grey.shade200, width: 1),
        ),
        child: Row(
          children: [
            // Avatar with Image
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFFFCC00), width: 2),
                color: const Color(0xFF1A5C2A),
              ),
              child: ClipOval(
                child: Image.asset(
                  member['image'] as String,
                  fit: BoxFit.cover,
                  width: 60,
                  height: 60,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback to initials if image fails to load
                    return Center(
                      child: Text(
                        (member['name'] as String)
                            .split(' ')
                            .where((word) => word.isNotEmpty)
                            .map((word) => word[0])
                            .join('')
                            .substring(0, 2)
                            .toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
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
                    member['name'] as String,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A5C2A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFCC00).withOpacity(0.18),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      member['position'] as String,
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
