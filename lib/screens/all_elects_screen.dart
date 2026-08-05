// lib/screens/all_elects_screen.dart
import 'package:flutter/material.dart';
import './elects_details.dart';

class AllElectsScreen extends StatefulWidget {
  const AllElectsScreen({super.key});

  @override
  State<AllElectsScreen> createState() => _AllElectsScreenState();
}

class _AllElectsScreenState extends State<AllElectsScreen> {
  String _searchQuery = '';

  // Sample elects data - replace with your actual data
  final List<Map<String, dynamic>> _allElects = [
    {
      'name': 'Hon. Bhoka George Didi',
      'position': 'Member of Parliament',
      'constituency': 'Obongi County',
      'county': 'OBONGI',
      'bio': 'Hon. Bhoka George Didi is a dedicated public servant committed to the development of Obongi County and the well-being of its people. He has been instrumental in various development projects in the region.',
      'email': 'bhoka.george@uda.go.ke',
      'phone': '+254 700 000 000',
      'office': 'Obongi County Office',
    },
    {
      'name': 'HaJJat Minsa Kabanda',
      'position': 'Member of Parliament',
      'constituency': 'KAMPALA CENTRAL',
      'county': 'KAMPALA',
      'bio': 'HaJJat Minsa Kabanda is a prominent political figure with extensive experience in governance and community development. She is passionate about women empowerment and education.',
      'email': 'minsa.kabanda@uda.go.ke',
      'phone': '+254 700 000 001',
      'office': 'Kampala Central Office',
    },
    {
      'name': 'Hon. Abablku Jesca',
      'position': 'District Woman Representative',
      'constituency': 'Adjumani',
      'county': 'ADJUMANI',
      'bio': 'Hon. Abablku Jesca is a strong advocate for women\'s rights and has been at the forefront of promoting gender equality in Adjumani District.',
      'email': 'abablku.jesca@uda.go.ke',
      'phone': '+254 700 000 002',
      'office': 'Adjumani District Office',
    },
    {
      'name': 'Hon. Aber Lilllan',
      'position': 'District Woman Representative',
      'constituency': 'KITGUM',
      'county': 'KITGUM',
      'bio': 'Hon. Aber Lilllan has been a vocal leader in Kitgum, championing the rights of women and children. She is committed to improving healthcare and education in the region.',
      'email': 'aber.lilllan@uda.go.ke',
      'phone': '+254 700 000 003',
      'office': 'Kitgum District Office',
    },
    {
      'name': 'Hon. Ablgaba Cuthbert Mirembe',
      'position': 'Member of Parliament',
      'constituency': 'Kibale County',
      'county': 'KAMWENGE',
      'bio': 'Hon. Ablgaba Cuthbert Mirembe is a seasoned politician with a focus on agricultural development and rural transformation in Kibale County.',
      'email': 'cuthbert.mirembe@uda.go.ke',
      'phone': '+254 700 000 004',
      'office': 'Kibale County Office',
    },
    {
      'name': 'Hon. Acan Joyce Okeny',
      'position': 'Persons With Disabilities Representative',
      'constituency': 'National',
      'county': 'KENYA',
      'bio': 'Hon. Acan Joyce Okeny is a passionate advocate for persons with disabilities, working tirelessly to ensure inclusivity and equal opportunities for all.',
      'email': 'joyce.okeny@uda.go.ke',
      'phone': '+254 700 000 005',
      'office': 'National Disability Office',
    },
  ];

  List<Map<String, dynamic>> get _filteredElects {
    if (_searchQuery.isEmpty) {
      return _allElects;
    }
    return _allElects.where((elect) {
      final name = (elect['name'] as String).toLowerCase();
      final constituency = (elect['constituency'] as String).toLowerCase();
      final county = (elect['county'] as String).toLowerCase();
      final query = _searchQuery.toLowerCase();
      return name.contains(query) || 
             constituency.contains(query) || 
             county.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'UDA ELECTS 2026',
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            padding: const EdgeInsets.all(8),
            color: const Color(0xFFFFCC00),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Search elects...',
                  prefixIcon: Icon(Icons.search, color: Color(0xFF1A5C2A)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              ),
            ),
          ),
        ),
      ),
      body: _filteredElects.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No elects found',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredElects.length,
              itemBuilder: (context, index) {
                final elect = _filteredElects[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ElectDetailsScreen(elect: elect),
                      ),
                    );
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
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xFF1A5C2A),
                          ),
                          child: Center(
                            child: Text(
                              (elect['name'] as String).substring(0, 1),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
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
                                elect['name'] as String,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1A5C2A),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                elect['position'] as String,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  const Icon(Icons.location_on, size: 12, color: Colors.grey),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${elect['constituency']} • ${elect['county']}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFF1A5C2A),
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
