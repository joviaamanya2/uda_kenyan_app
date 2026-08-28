// lib/screens/elect_details_screen.dart
import 'package:flutter/material.dart';

class ElectDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> elect;

  const ElectDetailsScreen({super.key, required this.elect});

  String? findImage(String name) {
    final assets = [
      'assets/images/H.E Cecily Mbarire.PNG',
      'assets/images/H.E Prof. Kithure Kindiki.PNG',
      'assets/images/Hon. Japheth Nyakundi.PNG',
      'assets/images/Hon. Sen. Hassan Omar.PNG',
      'assets/images/H.E%20Cecily%20Mbarire.PNG',
      'assets/images/Mr. Kelvin Lunani.PNG',
      'assets/images/Mr. Nicodemus Bore.PNG',
      'assets/images/Omboko Milemba.PNG',
      'assets/images/H.E Issa Timamy.png',
      'assets/images/Ruto.png',
      'assets/images/William Ruto.PNG',
      'assets/images/logo.png',
      'assets/images/main.PNG',
      'assets/images/main2.PNG',
    ];

    if (elect['image'] != null && elect['image'] is String) {
      final explicitPath = elect['image'] as String;
      if (assets.contains(explicitPath)) {
        return explicitPath;
      }
      final fileName = explicitPath.split('/').last.toLowerCase();
      for (final asset in assets) {
        if (asset.toLowerCase().contains(fileName)) {
          return asset;
        }
      }
    }

    final norm = name.toLowerCase().replaceAll(RegExp(r'[^a-z0-9 ]'), ' ');
    final words = norm.split(' ').where((w) => w.isNotEmpty).toList();

    for (final asset in assets) {
      final fname = asset
          .split('/')
          .last
          .toLowerCase()
          .replaceAll(RegExp(r'[^a-z0-9 ]'), ' ');
      final matchesAll = words.every((w) => fname.contains(w));
      if (matchesAll) return asset;
    }

    if (words.isNotEmpty) {
      final last = words.last;
      for (final asset in assets) {
        if (asset.toLowerCase().contains(last)) return asset;
      }
    }

    return null;
  }

  String _getSafeString(String key, {String defaultValue = ''}) {
    final value = elect[key];
    if (value == null) return defaultValue;
    return value.toString();
  }

  @override
  Widget build(BuildContext context) {
    final color = elect['color'] as int? ?? 0xFF1A5C2A;

    final name = _getSafeString('name', defaultValue: 'Unknown');
    final position = _getSafeString('position');
    final bio = _getSafeString('bio', defaultValue: '');
    final date = _getSafeString('date', defaultValue: '');
    final constituency = _getSafeString('constituency', defaultValue: '');
    final county = _getSafeString('county', defaultValue: '');
    final imagePath = findImage(name);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'ELECT DETAILS',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFCC00),
        foregroundColor: Colors.black,
        elevation: 0, // Removed shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: const Icon(Icons.share, color: Colors.black),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Share functionality will be implemented'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Image - CLEAN, NO SHADOWS, NO GRADIENTS
            Container(
              width: double.infinity,
              height: 350,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
                // No shadows, no gradients
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Clear Image
                    if (imagePath != null)
                      Image.asset(
                        imagePath,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Color(color),
                            child: Center(
                              child: Text(
                                name.substring(0, 1).toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 80,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          );
                        },
                      )
                    else
                      Container(
                        color: Color(color),
                        child: Center(
                          child: Text(
                            name.substring(0, 1).toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 80,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                    // Simple solid overlay for text readability
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(
                            0.5,
                          ), // Simple solid color
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(24),
                            bottomRight: Radius.circular(24),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFCC00),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                position,
                                style: const TextStyle(
                                  color: Color(0xFF1A5C2A),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Biography Section - NO SHADOWS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
                  // No boxShadow
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Biography Title
                    Row(
                      children: [
                        Container(
                          width: 4,
                          height: 28,
                          color: const Color(0xFFFFCC00),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Biography',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A5C2A),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Bio Text
                    if (bio.isNotEmpty)
                      Text(
                        bio,
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1.7,
                          color: Colors.black87,
                        ),
                      ),

                    if (bio.isNotEmpty) const SizedBox(height: 20),

                    // Divider
                    Container(height: 1, color: const Color(0xFFF0F0F0)),
                    const SizedBox(height: 16),

                    // Details Grid
                    const Text(
                      'Personal Information',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A5C2A),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Position
                    if (position.isNotEmpty)
                      _buildDetailItem(
                        icon: Icons.work,
                        label: 'Position',
                        value: position,
                      ),

                    // Constituency
                    if (constituency.isNotEmpty)
                      _buildDetailItem(
                        icon: Icons.location_city,
                        label: 'Constituency',
                        value: constituency,
                      ),

                    // County
                    if (county.isNotEmpty)
                      _buildDetailItem(
                        icon: Icons.map,
                        label: 'County',
                        value: county,
                      ),

                    // Date
                    if (date.isNotEmpty)
                      _buildDetailItem(
                        icon: Icons.calendar_today,
                        label: 'Active Since',
                        value: date,
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: const Color(0xFFFFCC00).withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF1A5C2A), size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    fontWeight: FontWeight.w500,
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
