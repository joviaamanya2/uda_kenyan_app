// lib/screens/achievement_details_screen.dart
import 'package:flutter/material.dart';
import '../theme/theme_ext.dart';

class AchievementSection {
  final String title;
  final String content;

  const AchievementSection({required this.title, required this.content});
}

class AchievementDetailsScreen extends StatelessWidget {
  final String title;

  /// Structured sections (used by the bundled achievements).
  final List<AchievementSection> sections;

  /// Free-text body (used by achievements added from the dashboard).
  final String? description;

  /// Header image: a bundled asset path or a network URL.
  final String? imagePath;

  final String? date;

  const AchievementDetailsScreen({
    super.key,
    required this.title,
    this.sections = const [],
    this.description,
    this.imagePath,
    this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Image
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                height: 200,
                width: double.infinity,
                child: _headerImage(),
              ),
            ),
            const SizedBox(height: 20),

            // Section Title
            Row(
              children: [
                Container(width: 4, height: 18, color: const Color(0xFFFFCC00)),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A5C2A),
                    ),
                  ),
                ),
              ],
            ),
            if (date != null && date!.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(
                date!,
                style: TextStyle(fontSize: 12, color: context.textMuted),
              ),
            ],
            const SizedBox(height: 8),
            Container(height: 3, width: 50, color: const Color(0xFFFFCC00)),
            const SizedBox(height: 16),

            if (sections.isNotEmpty)
              ...sections.map((s) => _buildDetailSection(context, s))
            else
              Text(
                (description == null || description!.isEmpty)
                    ? 'More details coming soon.'
                    : description!,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: context.textStrong,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _headerImage() {
    final path = imagePath ?? '';
    if (path.startsWith('http')) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(color: const Color(0xFF1A5C2A)),
      );
    }
    if (path.isNotEmpty) {
      return Image.asset(
        path,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(color: const Color(0xFF1A5C2A)),
      );
    }
    return Container(color: const Color(0xFF1A5C2A));
  }

  Widget _buildDetailSection(BuildContext context, AchievementSection section) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 6),
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: Color(0xFFFFCC00),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                section.title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A5C2A),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Text(
            section.content,
            style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: context.textStrong,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Container(height: 1, color: context.hairline),
        const SizedBox(height: 16),
      ],
    );
  }
}
