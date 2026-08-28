// lib/screens/community/radio_stations_screen.dart
import 'package:flutter/material.dart';

class RadioStationsScreen extends StatelessWidget {
  const RadioStationsScreen({super.key});

  final List<Map<String, String>> radioStations = const [
    {'name': 'CBS', 'frequency': '88.8 FM'},
    {'name': 'XFM', 'frequency': '94.8 FM'},
    {'name': 'Community', 'frequency': '100.2 FM'},
    {'name': 'Radio One', 'frequency': '90.0 FM'},
    {'name': 'Capital FM', 'frequency': '91.3 FM'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'RADIO STATIONS',
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
                  const Icon(Icons.radio, color: Color(0xFF1A5C2A)),
                  const SizedBox(width: 8),
                  const Text(
                    'RADIO STATIONS',
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
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: radioStations.length,
                itemBuilder: (context, index) {
                  return _buildRadioStationItem(radioStations[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioStationItem(Map<String, String> station) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
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
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFFFCC00).withOpacity(0.3),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Center(
              child: Text(
                station['name']![0],
                style: const TextStyle(
                  color: Color(0xFF1A5C2A),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
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
                  station['name']!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Color(0xFF1A5C2A),
                  ),
                ),
                Text(
                  station['frequency']!,
                  style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
          Icon(
            Icons.play_circle_outline,
            color: const Color(0xFF1A5C2A),
            size: 32,
          ),
        ],
      ),
    );
  }
}
