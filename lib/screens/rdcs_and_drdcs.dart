// lib/screens/rdcs_drdcs_screen.dart
import 'package:flutter/material.dart';

class RDCSDRDCSScreen extends StatefulWidget {
  const RDCSDRDCSScreen({super.key});

  @override
  State<RDCSDRDCSScreen> createState() => _RDCSDRDCSScreenState();
}

class _RDCSDRDCSScreenState extends State<RDCSDRDCSScreen> {
  String _searchQuery = '';

  final List<Map<String, String>> _rdcsLeaders = const [
    {
      'name': 'Hon. Githinji Njoroge',
      'title': 'Team Member, RDC\'S SEC',
      'station': 'RDC SECRETARIAT',
      'tel': '0712345678',
      'region': 'Central',
      'type': 'RDC',
    },
    {
      'name': 'Hon. John Mwangi',
      'title': 'Team Leader, RDC SEC',
      'station': 'RDC ANTI CORRUPTION UNIT',
      'tel': '0712345680',
      'region': 'Central',
      'type': 'RDC',
    },
    {
      'name': 'Hon. Grace Akinyi',
      'title': 'RDC',
      'station': 'Nairobi',
      'tel': '0712345681',
      'region': 'Nairobi',
      'type': 'RDC',
    },
    {
      'name': 'Hon. Hassan Omar',
      'title': 'Team Member, RDC\'S SEC',
      'station': 'RDC SECRETARIAT',
      'tel': '0712345682',
      'region': 'Coast',
      'type': 'RDC',
    },
    {
      'name': 'Hon. David Were',
      'title': 'Team Leader, RDC SEC',
      'station': 'RDC ANTI CORRUPTION UNIT',
      'tel': '0712345684',
      'region': 'Western',
      'type': 'RDC',
    },
    {
      'name': 'Hon. Mohammed Hassan',
      'title': 'Team Member, RDC\'S SEC',
      'station': 'RDC SECRETARIAT',
      'tel': '0712345686',
      'region': 'Northern',
      'type': 'RDC',
    },
    {
      'name': 'Hon. Julius Kipyegon',
      'title': 'Team Leader, RDC SEC',
      'station': 'RDC YOUTH UNIT',
      'tel': '0712345688',
      'region': 'Rift Valley',
      'type': 'RDC',
    },
  ];

  final List<Map<String, String>> _drdcsLeaders = const [
    {
      'name': 'Hon. Mary Wanjiru',
      'title': 'Team Member, RDC\'S SEC',
      'station': 'RDC SECRETARIAT',
      'tel': '0712345679',
      'region': 'Central',
      'type': 'DRDC',
    },
    {
      'name': 'Hon. Fatuma Ali',
      'title': 'RDC',
      'station': 'Mombasa',
      'tel': '0712345683',
      'region': 'Coast',
      'type': 'DRDC',
    },
    {
      'name': 'Hon. Caroline Omondi',
      'title': 'RDC',
      'station': 'Kisumu',
      'tel': '0712345685',
      'region': 'Western',
      'type': 'DRDC',
    },
    {
      'name': 'Hon. Sarah Lokenyo',
      'title': 'RDC',
      'station': 'Nakuru',
      'tel': '0712345687',
      'region': 'Rift Valley',
      'type': 'DRDC',
    },
    {
      'name': 'Hon. Esther Mwangi',
      'title': 'RDC',
      'station': 'Kisii',
      'tel': '0712345689',
      'region': 'Nyanza',
      'type': 'DRDC',
    },
  ];

  List<Map<String, String>> get _filteredRDCs {
    if (_searchQuery.isEmpty) {
      return _rdcsLeaders;
    }
    return _rdcsLeaders.where((leader) {
      final name = (leader['name'] ?? '').toLowerCase();
      final station = (leader['station'] ?? '').toLowerCase();
      final region = (leader['region'] ?? '').toLowerCase();
      final query = _searchQuery.toLowerCase();
      return name.contains(query) ||
          station.contains(query) ||
          region.contains(query);
    }).toList();
  }

  List<Map<String, String>> get _filteredDRDCs {
    if (_searchQuery.isEmpty) {
      return _drdcsLeaders;
    }
    return _drdcsLeaders.where((leader) {
      final name = (leader['name'] ?? '').toLowerCase();
      final station = (leader['station'] ?? '').toLowerCase();
      final region = (leader['region'] ?? '').toLowerCase();
      final query = _searchQuery.toLowerCase();
      return name.contains(query) ||
          station.contains(query) ||
          region.contains(query);
    }).toList();
  }

  bool get _hasResults {
    return _filteredRDCs.isNotEmpty || _filteredDRDCs.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'RDCS & DRDCS',
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
                  hintText: 'Search by station or name...',
                  prefixIcon: Icon(Icons.search, color: Color(0xFF1A5C2A)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: !_hasResults
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No leaders found',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // RDC Section
                if (_filteredRDCs.isNotEmpty) ...[
                  _buildSectionHeader('RDCS'),
                  const SizedBox(height: 8),
                  ..._filteredRDCs
                      .map(
                        (leader) => _buildLeaderCard(
                          name: leader['name']!,
                          title: leader['title']!,
                          station: leader['station']!,
                          tel: leader['tel']!,
                          isRDC: true,
                        ),
                      )
                      .toList(),
                ],

                // DRDC Section
                if (_filteredDRDCs.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  _buildSectionHeader('DRDCS'),
                  const SizedBox(height: 8),
                  ..._filteredDRDCs
                      .map(
                        (leader) => _buildLeaderCard(
                          name: leader['name']!,
                          title: leader['title']!,
                          station: leader['station']!,
                          tel: leader['tel']!,
                          isRDC: false,
                        ),
                      )
                      .toList(),
                ],
              ],
            ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A5C2A), Color(0xFF2E7D32)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }

  Widget _buildLeaderCard({
    required String name,
    required String title,
    required String station,
    required String tel,
    required bool isRDC,
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
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: isRDC ? const Color(0xFF1A5C2A) : const Color(0xFFFFCC00),
            width: isRDC ? 2 : 2,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with name and badge
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isRDC
                        ? const Color(0xFF1A5C2A)
                        : const Color(0xFFFFCC00),
                  ),
                  child: Center(
                    child: Text(
                      name
                          .split(' ')
                          .map((word) => word[0])
                          .join('')
                          .substring(0, 2)
                          .toUpperCase(),
                      style: TextStyle(
                        color: isRDC ? Colors.white : const Color(0xFF1A5C2A),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
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
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: isRDC
                              ? const Color(0xFF1A5C2A)
                              : const Color(0xFFFFCC00),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          isRDC ? 'RDC' : 'DRDC',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: isRDC
                                ? Colors.white
                                : const Color(0xFF1A5C2A),
                          ),
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
            const SizedBox(height: 12),

            // Details
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200, width: 1),
              ),
              child: Column(
                children: [
                  _buildDetailRow('Title', title),
                  _buildDetailRow('Station', station),
                  _buildDetailRow('Tel', tel),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 60,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A5C2A),
              ),
            ),
          ),
          const Text(
            ': ',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A5C2A),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 12, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
