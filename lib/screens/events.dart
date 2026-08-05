// lib/screens/events_screen.dart
import 'package:flutter/material.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'EVENTS',
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEventCard(
              title: 'UDA Grassroots Elections 2026',
              date: 'August 15, 2026',
              location: 'Nationwide',
              description: 'Grassroots elections for all UDA party positions across the country.',
              icon: Icons.how_to_vote,
            ),
            const SizedBox(height: 16),
            _buildEventCard(
              title: 'National Delegates Convention 2026',
              date: 'September 20, 2026',
              location: 'KICC, Nairobi',
              description: 'Annual National Delegates Convention to review party progress and plan for the future.',
              icon: Icons.groups,
            ),
            const SizedBox(height: 16),
            _buildEventCard(
              title: 'UDA Youth Summit 2026',
              date: 'October 10, 2026',
              location: 'Nairobi',
              description: 'Empowering the youth through political participation and leadership development.',
              icon: Icons.people,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEventCard({
    required String title,
    required String date,
    required String location,
    required String description,
    required IconData icon,
  }) {
    return Container(
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
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFCC00),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(icon, color: const Color(0xFF1A5C2A)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A5C2A),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
              const SizedBox(width: 6),
              Text(date, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(width: 16),
              const Icon(Icons.location_on, size: 14, color: Colors.grey),
              const SizedBox(width: 6),
              Text(location, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: const TextStyle(fontSize: 14, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
