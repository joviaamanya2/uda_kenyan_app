// lib/screens/community/tv_stations_screen.dart
import 'package:flutter/material.dart';

class TVStationsScreen extends StatelessWidget {
  const TVStationsScreen({super.key});

  final List<Map<String, String>> tvStations = const [
    {'name': 'LBC', 'slogan': ''},
    {'name': 'NV', 'slogan': ''},
    {'name': 'nbs', 'slogan': ''},
    {'name': 'bbs', 'slogan': ''},
    {'name': 'Sparken', 'slogan': "It's your time"},
    {'name': 'Urban', 'slogan': '...it starts here'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'TV STATIONS',
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const Icon(Icons.tv, color: Color(0xFF1A5C2A)),
                  const SizedBox(width: 8),
                  const Text(
                    'TV STATIONS',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF1A5C2A),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            Expanded(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.2,
                ),
                itemCount: tvStations.length,
                itemBuilder: (context, index) {
                  return _buildTVStationCard(tvStations[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTVStationCard(Map<String, String> station) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFF1A5C2A).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                station['name']!.toUpperCase(),
                style: const TextStyle(
                  color: Color(0xFF1A5C2A),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            station['name']!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color(0xFF1A5C2A),
            ),
          ),
          if (station['slogan']!.isNotEmpty)
            Text(
              station['slogan']!,
              style: TextStyle(
                fontSize: 10,
                color: Colors.grey[600],
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}
