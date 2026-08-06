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
            // Hero Image Card - Full width with background image
            Container(
              width: double.infinity,
              height: 320,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(24),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Background Image
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
                    
                    // Dark Overlay for text readability
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.2),
                            Colors.black.withOpacity(0.7),
                          ],
                          stops: const [0.0, 0.6],
                        ),
                      ),
                    ),
                    
                    // Content on top of image
                    Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Name
                          Text(
                            name,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  color: Colors.black45,
                                  blurRadius: 8,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          
                          // Position Badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFCC00),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              position,
                              style: const TextStyle(
                                color: Color(0xFF1A5C2A),
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          
                          // Date and Location Row
                          Row(
                            children: [
                              if (date.isNotEmpty) ...[
                                const Icon(
                                  Icons.calendar_today,
                                  color: Colors.white70,
                                  size: 14,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  date,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                              if (date.isNotEmpty && (constituency.isNotEmpty || county.isNotEmpty))
                                Container(
                                  width: 4,
                                  height: 4,
                                  margin: const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: const BoxDecoration(
                                    color: Colors.white54,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              if (constituency.isNotEmpty || county.isNotEmpty)
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      color: Colors.white70,
                                      size: 14,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      constituency.isNotEmpty ? constituency : county,
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    // Color accent strip at bottom
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      height: 4,
                      child: Container(
                        color: Color(color),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Biography Section
                  if (bio.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
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
                                width: 4,
                                height: 24,
                                color: const Color(0xFFFFCC00),
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                'Biography',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1A5C2A),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            bio,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.6,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  if (bio.isNotEmpty) const SizedBox(height: 16),

                  // Positions & Roles Section
                  if (position.isNotEmpty || constituency.isNotEmpty || county.isNotEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Positions & Roles',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1A5C2A),
                            ),
                          ),
                          const SizedBox(height: 12),
                          if (position.isNotEmpty)
                            _buildRoleItem('Position', position),
                          if (constituency.isNotEmpty)
                            _buildRoleItem('Constituency', constituency),
                          if (county.isNotEmpty)
                            _buildRoleItem('County', county),
                          if (date.isNotEmpty)
                            _buildRoleItem('Active Since', date),
                        ],
                      ),
                    ),
                  
                  if (position.isNotEmpty || constituency.isNotEmpty || county.isNotEmpty)
                    const SizedBox(height: 24),
                  
                  // Action Buttons
                  
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoleItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 4,
            height: 16,
            color: const Color(0xFFFFCC00),
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