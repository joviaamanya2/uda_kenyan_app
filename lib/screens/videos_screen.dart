// lib/screens/videos_screen.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/api_service.dart';
import '../theme/theme_ext.dart';

class VideosScreen extends StatefulWidget {
  final bool embedded;
  const VideosScreen({super.key, this.embedded = false});

  @override
  State<VideosScreen> createState() => _VideosScreenState();
}

class _VideosScreenState extends State<VideosScreen> {
  static const _green = Color(0xFF1A5C2A);
  static const _yellow = Color(0xFFFFCC00);
  static const _categories = [
    'All',
    'Speeches',
    'Interviews',
    'Rallies',
    'Highlights',
  ];
  static const _monthNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  String _selectedCategory = 'All';
  bool _loading = true;

  // Bundled offline fallback; replaced by _load() with dashboard-managed videos.
  List<Map<String, dynamic>> _videos = const [
    {
      'title':
          'Address by H.E. President Ruto at the UDA National Delegates Convention',
      'description':
          'President William Ruto addresses UDA delegates at KICC, Nairobi.',
      'url': 'https://www.youtube.com/@UDAKenya',
      'category': 'Speeches',
      'duration': '45:22',
      'date': '9 Jun 2026',
      'thumbnail': '',
    },
    {
      'title': 'UDA Party Leaders meet on the Economic Transformation Agenda',
      'description':
          'UDA leaders hold a strategic meeting on the Bottom-Up Economic Agenda.',
      'url': 'https://www.youtube.com/@UDAKenya',
      'category': 'Highlights',
      'duration': '28:15',
      'date': '22 May 2026',
      'thumbnail': '',
    },
  ];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final remote = await ApiService.instance.getList('videos');
      if (mounted && remote.isNotEmpty) {
        setState(() {
          _videos = remote.map((v) {
            return {
              'title': (v['title'] ?? 'UDA Video').toString(),
              'description': (v['description'] ?? '').toString(),
              'url': (v['url'] ?? '').toString(),
              'category': (v['category'] ?? '').toString(),
              'duration': (v['duration'] ?? '').toString(),
              'date': _formatDate(v['published_at']),
              'thumbnail': (v['thumbnail_path'] ?? '').toString(),
            };
          }).toList();
        });
      }
    } catch (_) {
      // keep bundled fallback
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  String _formatDate(dynamic raw) {
    if (raw == null) return '';
    final d = DateTime.tryParse(raw.toString());
    if (d == null) return raw.toString();
    return '${d.day} ${_monthNames[d.month - 1]} ${d.year}';
  }

  List<Map<String, dynamic>> get _visible {
    if (_selectedCategory == 'All') return _videos;
    return _videos
        .where(
          (v) =>
              (v['category'] as String).toLowerCase() ==
              _selectedCategory.toLowerCase(),
        )
        .toList();
  }

  Future<void> _play(String url) async {
    if (url.isEmpty) return;
    final uri = Uri.tryParse(url);
    if (uri == null) return;
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open the video.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: widget.embedded
          ? null
          : AppBar(
              title: const Text(
                'UDA VIDEOS',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor: _yellow,
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final c in _categories) ...[
                    _tab(c),
                    const SizedBox(width: 8),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (_loading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 48),
                child: Center(child: CircularProgressIndicator(color: _green)),
              )
            else if (_visible.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 48),
                child: Center(
                  child: Text(
                    'No $_selectedCategory videos yet.',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ),
              )
            else
              ..._visible.map(_videoCard),
          ],
        ),
      ),
    );
  }

  Widget _tab(String label) {
    final selected = _selectedCategory == label;
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? _yellow : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? _yellow : context.hairline),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? _green : context.textMuted,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _videoCard(Map<String, dynamic> v) {
    final thumb = v['thumbnail'] as String;
    final duration = v['duration'] as String;
    final date = v['date'] as String;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GestureDetector(
        onTap: () => _play(v['url'] as String),
        child: Container(
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
                child: SizedBox(
                  width: 120,
                  height: 84,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      thumb.startsWith('http')
                          ? Image.network(
                              thumb,
                              fit: BoxFit.cover,
                              errorBuilder: (_, e, s) =>
                                  Container(color: _green),
                            )
                          : Container(color: _green),
                      Center(
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: _yellow,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.play_arrow,
                            color: _green,
                            size: 18,
                          ),
                        ),
                      ),
                      if (duration.isNotEmpty)
                        Positioned(
                          bottom: 4,
                          right: 4,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: Text(
                              duration,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        v['title'] as String,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: _green,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if ((v['description'] as String).isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          v['description'] as String,
                          style: TextStyle(
                            fontSize: 11,
                            color: context.textMuted,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      if (date.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_today,
                              size: 11,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              date,
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
