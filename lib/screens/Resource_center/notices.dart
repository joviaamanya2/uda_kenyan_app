// lib/screens/resource_center/notices_screen.dart
import 'package:flutter/material.dart';
import '../../theme/theme_ext.dart';

class NoticesScreen extends StatelessWidget {
  const NoticesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        title: const Text(
          'NOTICES',
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
                  const Icon(Icons.info_outline, color: Color(0xFF1A5C2A)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Latest official notices and announcements from UDA',
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
                  _buildNoticeItem(
                    context: context,
                    title: 'Party National Delegates Conference',
                    date: '15 March 2024',
                    description:
                        'Notice for the upcoming national delegates conference to be held at KICC.',
                    isUrgent: true,
                  ),
                  _buildNoticeItem(
                    context: context,
                    title: 'Membership Registration Drive',
                    date: '10 March 2024',
                    description:
                        'Nationwide membership registration drive commencing next month.',
                    isUrgent: false,
                  ),
                  _buildNoticeItem(
                    context: context,
                    title: 'County Elections Announcement',
                    date: '5 March 2024',
                    description:
                        'Schedule for county-level party elections released.',
                    isUrgent: false,
                  ),
                  _buildNoticeItem(
                    context: context,
                    title: 'Policy Review Workshop',
                    date: '28 February 2024',
                    description:
                        'Notice for policy review workshop for all county leaders.',
                    isUrgent: false,
                  ),
                  _buildNoticeItem(
                    context: context,
                    title: 'Financial Reporting Deadline',
                    date: '20 February 2024',
                    description:
                        'Deadline for submission of financial reports for all branches.',
                    isUrgent: true,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoticeItem({
    required BuildContext context,
    required String title,
    required String date,
    required String description,
    required bool isUrgent,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isUrgent ? Colors.red.shade200 : context.hairline,
          width: isUrgent ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Color(0xFF1A5C2A),
                  ),
                ),
              ),
              if (isUrgent)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'URGENT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 12, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                date,
                style: TextStyle(fontSize: 12, color: context.textMuted),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            description,
            style: TextStyle(fontSize: 13, color: context.textMuted),
          ),
        ],
      ),
    );
  }
}
