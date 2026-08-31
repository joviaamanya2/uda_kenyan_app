// lib/screens/executive_committee_screen.dart
import 'package:flutter/material.dart';
import 'elects_details.dart';
import '../services/api_service.dart';
import '../theme/theme_ext.dart';

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
      'name': 'H.E Dr. William Samoei Ruto',
      'position': 'Party Leader',
      'image': 'assets/images/William Ruto.PNG',
      'bio':
          'H.E Dr. William Samoei Ruto is the President of the Republic of Kenya and the Party Leader of UDA. He is committed to transforming Kenya through the Bottom-Up Economic Transformation Agenda (BETA).',
      'email': 'hello@uda.ke',
      'phone': '020 2020405',
      'office': 'UDA National Office, Hustler Plaza, Ngong Road, Nairobi',
    },
    {
      'name': 'H.E Cecily Mbarire',
      'position': 'National Chairperson / Governor, Embu County',
      'image': 'assets/images/H.E Cecily Mbarire.PNG',
      'bio':
          'H.E Cecily Mbarire is the Governor of Embu County and the National Chairperson of UDA. She is dedicated to the development and welfare of her constituents.',
      'email': 'hello@uda.ke',
      'phone': '020 2020405',
      'office': 'UDA National Office, Hustler Plaza, Ngong Road, Nairobi',
    },
    {
      'name': 'Mr. Kelvin Lunani',
      'position': 'National Vice-Chairperson',
      'image': 'assets/images/Mr. Kelvin Lunani.PNG',
      'bio':
          'Mr. Kelvin Lunani is the National Vice-Chairperson of UDA. He previously served as national chairman of ANC before its merger into UDA in January 2025.',
      'email': 'hello@uda.ke',
      'phone': '020 2020405',
      'office': 'UDA National Office, Hustler Plaza, Ngong Road, Nairobi',
    },
    {
      'name': 'H.E. Prof. Kithure Kindiki',
      'position': 'Deputy Party Leader / Deputy President of Kenya',
      'image': 'assets/images/H.E Prof. Kithure Kindiki.PNG',
      'bio':
          'H.E. Prof. Kithure Kindiki is the Deputy President of the Republic of Kenya and a Deputy Party Leader of UDA. He previously served as Cabinet Secretary for Interior and National Administration.',
      'email': 'hello@uda.ke',
      'phone': '020 2020405',
      'office': 'UDA National Office, Hustler Plaza, Ngong Road, Nairobi',
    },
    {
      'name': 'Sen. Hassan Omar',
      'position': 'Secretary General',
      'image': 'assets/images/Hon. Sen. Hassan Omar.PNG',
      'bio':
          'Sen. Hassan Omar is the Secretary General of UDA, responsible for the day-to-day running of the party secretariat.',
      'email': 'hello@uda.ke',
      'phone': '020 2020405',
      'office': 'UDA National Office, Hustler Plaza, Ngong Road, Nairobi',
    },
    {
      'name': 'H.E. Issa Timamy',
      'position': 'Deputy Party Leader / Governor, Lamu County',
      'image': 'assets/images/H.E Issa Timamy.png',
      'bio':
          'H.E. Issa Timamy is the Governor of Lamu County and a Deputy Party Leader of UDA. He was the party leader of ANC before it merged into UDA in January 2025.',
      'email': 'hello@uda.ke',
      'phone': '020 2020405',
      'office': 'UDA National Office, Hustler Plaza, Ngong Road, Nairobi',
    },
    {
      'name': 'Mr. Nicodemus Bore',
      'position': 'Executive Director',
      'image': 'assets/images/Mr. Nicodemus Bore.PNG',
      'bio':
          'Mr. Nicodemus Bore is the Executive Director of UDA, overseeing the party secretariat and administration.',
      'email': 'hello@uda.ke',
      'phone': '020 2020405',
      'office': 'UDA National Office, Hustler Plaza, Ngong Road, Nairobi',
    },
    {
      'name': 'Hon. Omboko Milemba',
      'position': 'Deputy Secretary General / MP, Emuhaya Constituency',
      'image': 'assets/images/Omboko Milemba.PNG',
      'bio':
          'Hon. Omboko Milemba is the Deputy Secretary General of UDA and Member of Parliament for Emuhaya Constituency. He was ANC secretary-general before the merger into UDA.',
      'email': 'hello@uda.ke',
      'phone': '020 2020405',
      'office': 'UDA National Office, Hustler Plaza, Ngong Road, Nairobi',
    },
    {
      'name': 'Hon. Japheth Nyakundi',
      'position': 'National Treasurer',
      'image': 'assets/images/Hon. Japheth Nyakundi.PNG',
      'bio':
          'Hon. Japheth Nyakundi is the National Treasurer of UDA, responsible for the party\'s finances.',
      'email': 'hello@uda.ke',
      'phone': '020 2020405',
      'office': 'UDA National Office, Hustler Plaza, Ngong Road, Nairobi',
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
      backgroundColor: context.pageBg,
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
          color: context.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(color: context.hairline, width: 1),
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
