// lib/screens/resource_center/downloads_screen.dart
import 'package:flutter/material.dart';
import '../../theme/theme_ext.dart';

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({super.key});

  final List<Map<String, dynamic>> documents = const [
    {
      'title': 'THE SCORECARD: DELIVERING THE PLAN',
      'type': 'PDF',
      'size': '2.4 MB',
      'color': Colors.red,
    },
    {
      'title': 'SEPTEMBER 2025 PARTY NOMINATION LOCATIONS',
      'type': 'PDF',
      'size': '1.8 MB',
      'color': Colors.blue,
    },
    {
      'title': 'Party Manifesto',
      'type': 'PDF',
      'size': '3.2 MB',
      'color': Colors.green,
    },
    {
      'title': 'Party Constitution March 2026',
      'type': 'PDF',
      'size': '4.1 MB',
      'color': Colors.orange,
    },
    {
      'title': 'EXTENSION OF ONLINE REGISTRATION DEADLINE',
      'type': 'PDF',
      'size': '0.9 MB',
      'color': Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        title: const Text(
          'DOWNLOADS',
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and count
          Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Party Related Documents',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A5C2A),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFCC00),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${documents.length} Documents',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A5C2A),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Document List
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  final doc = documents[index];
                  return _buildDocumentItem(
                    context: context, // Pass context here
                    title: doc['title'] as String,
                    type: doc['type'] as String,
                    size: doc['size'] as String,
                    color: doc['color'] as Color,
                    index: index,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentItem({
    required BuildContext context, // Add context parameter
    required String title,
    required String type,
    required String size,
    required Color color,
    required int index,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: context.hairline, width: 1),
      ),
      child: Row(
        children: [
          // Document Icon
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.picture_as_pdf, color: color, size: 28),
          ),
          const SizedBox(width: 14),

          // Document Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xFF1A5C2A),
                    height: 1.2,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        type,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      size,
                      style: TextStyle(fontSize: 11, color: context.textMuted),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Download Button
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Downloading: $title'),
                  backgroundColor: const Color(0xFF1A5C2A),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF1A5C2A),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.download, color: Colors.white, size: 16),
                  SizedBox(width: 4),
                  Text(
                    'Download',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
