// lib/screens/news_details.dart
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../theme/theme_ext.dart';

class NewsDetailsScreen extends StatelessWidget {
  final String title;
  final String date;
  final String image;
  final String content;

  const NewsDetailsScreen({
    super.key,
    required this.title,
    required this.date,
    required this.image,
    required this.content,
  });

  void _share() {
    SharePlus.instance.share(ShareParams(text: '$title\n\n$content'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        title: const Text(
          'UDA NEWS',
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
          IconButton(
            icon: const Icon(Icons.share, color: Colors.black),
            onPressed: _share,
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Featured Image
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: (image.startsWith('http') || image.startsWith('https'))
                  ? Image.network(
                      image,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 250,
                          width: double.infinity,
                          color: const Color(0xFF1A5C2A),
                          child: const Center(
                            child: Icon(
                              Icons.newspaper,
                              color: Colors.white54,
                              size: 64,
                            ),
                          ),
                        );
                      },
                    )
                  : Image.asset(
                      image,
                      height: 250,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 250,
                          width: double.infinity,
                          color: const Color(0xFF1A5C2A),
                          child: const Center(
                            child: Icon(
                              Icons.newspaper,
                              color: Colors.white54,
                              size: 64,
                            ),
                          ),
                        );
                      },
                    ),
            ),
            const SizedBox(height: 16),

            // Category tag
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFFFCC00),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'UDA NEWS',
                style: TextStyle(
                  color: Color(0xFF1A5C2A),
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Title
            Text(
              title,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A5C2A),
              ),
            ),
            const SizedBox(height: 8),

            // Date and Share
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  date,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: _share,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFCC00),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.share, color: Color(0xFF1A5C2A), size: 14),
                        SizedBox(width: 4),
                        Text(
                          'Share',
                          style: TextStyle(
                            color: Color(0xFF1A5C2A),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Divider
            Container(height: 3, color: const Color(0xFFFFCC00)),
            const SizedBox(height: 16),

            // Content
            Text(
              content,
              style: TextStyle(
                fontSize: 15,
                height: 1.8,
                color: context.textStrong,
              ),
            ),
            const SizedBox(height: 24),

            // Back button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFCC00),
                  foregroundColor: const Color(0xFF1A5C2A),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'BACK TO NEWS',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
