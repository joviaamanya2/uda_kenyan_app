// lib/screens/resource_center/reports_screen.dart
import 'package:flutter/material.dart';
import '../../theme/theme_ext.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        title: const Text(
          'REPORTS',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFCC00),
        foregroundColor: Colors.black,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
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
                color: const Color(0xFFFFCC00).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFFFCC00)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.insert_chart, color: Color(0xFF1A5C2A)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Annual reports, activity reports, and more',
                      style: TextStyle(fontSize: 13, color: context.textMuted),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildReportItem(
                    context: context,
                    title: 'Annual Activity Report 2023',
                    date: 'January 2024',
                    type: 'Annual',
                  ),
                  _buildReportItem(
                    context: context,
                    title: 'Election Monitoring Report',
                    date: 'December 2023',
                    type: 'Special',
                  ),
                  _buildReportItem(
                    context: context,
                    title: 'Membership Growth Report',
                    date: 'November 2023',
                    type: 'Quarterly',
                  ),
                  _buildReportItem(
                    context: context,
                    title: 'County Performance Report',
                    date: 'October 2023',
                    type: 'Quarterly',
                  ),
                  _buildReportItem(
                    context: context,
                    title: 'Youth Engagement Report',
                    date: 'September 2023',
                    type: 'Special',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReportItem({
    required BuildContext context,
    required String title,
    required String date,
    required String type,
  }) {
    Color typeColor;
    if (type == 'Annual') {
      typeColor = Colors.green;
    } else if (type == 'Quarterly') {
      typeColor = Colors.blue;
    } else {
      typeColor = Colors.orange;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.surface,
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
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: typeColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.insert_chart, color: typeColor, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF1A5C2A),
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: typeColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        type,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: typeColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      date,
                      style: TextStyle(fontSize: 12, color: context.textMuted),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFF1A5C2A),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Row(
              children: [
                Icon(Icons.remove_red_eye, color: Colors.white, size: 16),
                SizedBox(width: 4),
                Text(
                  'View',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
