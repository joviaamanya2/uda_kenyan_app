// lib/screens/all_elects_screen.dart
import 'package:flutter/material.dart';
import './elects_details.dart';
import '../theme/theme_ext.dart';

class AllElectsScreen extends StatefulWidget {
  final List<Map<String, dynamic>> elects;

  const AllElectsScreen({super.key, required this.elects});

  @override
  State<AllElectsScreen> createState() => _AllElectsScreenState();
}

class _AllElectsScreenState extends State<AllElectsScreen> {
  String _searchQuery = '';

  /// Elect photo: bundled asset path or a network URL (uploaded from the admin
  /// dashboard); falls back to the name's initial.
  Widget _electImage(String? path, int color, String name) {
    final fallback = Container(
      color: Color(color),
      child: Center(
        child: Text(
          name.isNotEmpty ? name.substring(0, 1).toUpperCase() : '?',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    if (path == null || path.trim().isEmpty) return fallback;

    return path.startsWith('http')
        ? Image.network(
            path,
            fit: BoxFit.cover,
            width: 60,
            height: 60,
            errorBuilder: (context, error, stackTrace) => fallback,
          )
        : Image.asset(
            path,
            fit: BoxFit.cover,
            width: 60,
            height: 60,
            errorBuilder: (context, error, stackTrace) => fallback,
          );
  }

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
      'assets/images/Ruto.png',
      'assets/images/William Ruto.PNG',
      'assets/images/logo.png',
      'assets/images/main.PNG',
      'assets/images/main2.PNG',
    ];

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

  List<Map<String, dynamic>> get _filteredElects {
    if (_searchQuery.isEmpty) {
      return widget.elects;
    }
    return widget.elects.where((elect) {
      final name = (elect['name'] as String).toLowerCase();
      final constituency = (elect['constituency'] as String).toLowerCase();
      final county = (elect['county'] as String).toLowerCase();
      final position = (elect['position'] as String).toLowerCase();
      final query = _searchQuery.toLowerCase();
      return name.contains(query) ||
          constituency.contains(query) ||
          county.contains(query) ||
          position.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        title: const Text(
          'UDA ELECTS 2026',
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
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            padding: const EdgeInsets.all(8),
            color: const Color(0xFFFFCC00),
            child: Container(
              decoration: BoxDecoration(
                color: context.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: context.hairline),
              ),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Search elects by name, constituency, county...',
                  prefixIcon: Icon(Icons.search, color: Color(0xFF1A5C2A)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 12,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: _filteredElects.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.search_off, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No elects found',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Try adjusting your search',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _filteredElects.length,
              itemBuilder: (context, index) {
                final elect = _filteredElects[index];
                // Get the color from the elect data or use default
                final color = elect['color'] as int? ?? 0xFF1A5C2A;
                // Get image path - check explicit image first
                String? imagePath = elect['image'] as String?;
                if (imagePath == null) {
                  imagePath = findImage(elect['name'] as String);
                }

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ElectDetailsScreen(elect: elect),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: context.surface,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                      border: Border.all(color: Color(color), width: 2),
                    ),
                    child: Row(
                      children: [
                        // Avatar
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0xFFFFCC00),
                              width: 2,
                            ),
                          ),
                          child: ClipOval(
                            child: _electImage(
                              imagePath,
                              color,
                              elect['name'] as String,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        // Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                elect['name'] as String,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1A5C2A),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(color),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  elect['position'] as String,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: color == 0xFFFFCC00
                                        ? Colors.black
                                        : Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 4),
                              if (elect['bio'] != null)
                                Text(
                                  elect['bio'] as String,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: context.textStrong,
                                  ),
                                ),
                              const SizedBox(height: 4),
                              if (elect['date'] != null)
                                Text(
                                  'Date: ${elect['date']}',
                                  style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFF1A5C2A),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              const SizedBox(height: 2),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on,
                                    size: 12,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${elect['constituency'] ?? 'N/A'} • ${elect['county'] ?? 'N/A'}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFF1A5C2A),
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
