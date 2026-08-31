// lib/screens/community/community_screen.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/api_service.dart';
import 'community_feed_tab.dart';
import 'community_groups_screen.dart';
import '../../theme/theme_ext.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen>
    with SingleTickerProviderStateMixin {
  static const _green = Color(0xFF1A5C2A);
  static const _yellow = Color(0xFFFFCC00);

  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            Container(
              height: 32,
              width: 32,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: _green,
              ),
              child: const Center(
                child: Text(
                  'U',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'UDA Community',
              style: TextStyle(
                color: _green,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        backgroundColor: context.surface,
        foregroundColor: _green,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: Border(bottom: BorderSide(color: context.hairline)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: _green),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: _green,
          unselectedLabelColor: Colors.grey,
          indicatorColor: _yellow,
          indicatorWeight: 3,
          labelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
          tabs: const [
            Tab(icon: Icon(Icons.forum), text: 'Feed'),
            Tab(icon: Icon(Icons.groups), text: 'Groups'),
            Tab(icon: Icon(Icons.live_tv), text: 'Media'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          CommunityFeedTab(),
          CommunityGroupsScreen(),
          _MediaTab(),
        ],
      ),
    );
  }
}

// ============================ MEDIA TAB ============================

class _MediaTab extends StatefulWidget {
  const _MediaTab();

  @override
  State<_MediaTab> createState() => _MediaTabState();
}

class _Station {
  final String name;
  final String type; // 'TV' | 'Radio'
  final String frequency; // channel or FM frequency
  final String description;
  final String streamUrl;

  const _Station({
    required this.name,
    required this.type,
    required this.frequency,
    required this.description,
    required this.streamUrl,
  });

  Color get color {
    // Deterministic brand-ish colour from the name.
    const palette = [
      Color(0xFF1A5C2A),
      Color(0xFFC62828),
      Color(0xFF1565C0),
      Color(0xFF6A1B9A),
      Color(0xFFEF6C00),
      Color(0xFF00838F),
      Color(0xFF283593),
    ];
    return palette[name.codeUnits.fold(0, (a, b) => a + b) % palette.length];
  }
}

class _MediaTabState extends State<_MediaTab> {
  static const _green = Color(0xFF1A5C2A);

  bool _loading = true;
  String _filter = 'All';
  List<_Station> _stations = const [];

  // Bundled fallback — real Kenyan stations, used when the API is unreachable.
  static const _fallback = <_Station>[
    _Station(
      name: 'Citizen TV',
      type: 'TV',
      frequency: 'TV',
      description: "Kenya's most watched TV station.",
      streamUrl: 'https://www.youtube.com/@citizentvkenya/live',
    ),
    _Station(
      name: 'NTV Kenya',
      type: 'TV',
      frequency: 'TV',
      description: 'Nation Media Group news and entertainment.',
      streamUrl: 'https://www.youtube.com/@NTVKenya/live',
    ),
    _Station(
      name: 'KTN News',
      type: 'TV',
      frequency: 'TV',
      description: 'Standard Group 24-hour news channel.',
      streamUrl: 'https://www.youtube.com/@KTNNewsKenya/live',
    ),
    _Station(
      name: 'K24 TV',
      type: 'TV',
      frequency: 'TV',
      description: 'Mediamax news and lifestyle.',
      streamUrl: 'https://www.youtube.com/@K24TV/live',
    ),
    _Station(
      name: 'KBC Channel 1',
      type: 'TV',
      frequency: 'TV',
      description: 'Kenya Broadcasting Corporation.',
      streamUrl: 'https://www.youtube.com/@kbcchannel1/live',
    ),
    _Station(
      name: 'TV47',
      type: 'TV',
      frequency: 'TV',
      description: 'Cape Media news and entertainment.',
      streamUrl: 'https://www.youtube.com/@tv47ke/live',
    ),
    _Station(
      name: 'Radio Citizen',
      type: 'Radio',
      frequency: '106.7 FM',
      description: 'Royal Media Kiswahili radio.',
      streamUrl: 'https://www.youtube.com/@radiocitizen/live',
    ),
    _Station(
      name: 'Radio Jambo',
      type: 'Radio',
      frequency: '97.5 FM',
      description: 'Radio Africa Kiswahili radio.',
      streamUrl: 'https://www.youtube.com/@radiojambo/live',
    ),
    _Station(
      name: 'Kiss FM',
      type: 'Radio',
      frequency: '100.3 FM',
      description: 'English-language hits.',
      streamUrl: 'https://www.youtube.com/@KissFmKe/live',
    ),
    _Station(
      name: 'Radio Maisha',
      type: 'Radio',
      frequency: '104.7 FM',
      description: 'Standard Group Kiswahili radio.',
      streamUrl: 'https://www.youtube.com/@RadioMaisha/live',
    ),
    _Station(
      name: 'KBC Radio Taifa',
      type: 'Radio',
      frequency: '89.1 FM',
      description: 'KBC national service.',
      streamUrl: 'https://www.youtube.com/@kbcchannel1/live',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    List<_Station> tv = const [];
    List<_Station> radio = const [];
    try {
      final tvRows = await ApiService.instance.getList('tv-stations');
      tv = tvRows
          .map(
            (r) => _Station(
              name: (r['name'] ?? 'Station').toString(),
              type: 'TV',
              frequency: 'TV',
              description: (r['description'] ?? '').toString(),
              streamUrl: (r['stream_url'] ?? '').toString(),
            ),
          )
          .toList();
    } catch (_) {}
    try {
      final radioRows = await ApiService.instance.getList('radio-stations');
      radio = radioRows
          .map(
            (r) => _Station(
              name: (r['name'] ?? 'Station').toString(),
              type: 'Radio',
              frequency: (r['frequency'] ?? 'FM').toString(),
              description: (r['description'] ?? '').toString(),
              streamUrl: (r['stream_url'] ?? '').toString(),
            ),
          )
          .toList();
    } catch (_) {}

    final combined = [...tv, ...radio];
    if (mounted) {
      setState(() {
        _stations = combined.isNotEmpty ? combined : _fallback;
        _loading = false;
      });
    }
  }

  List<_Station> get _visible => _filter == 'All'
      ? _stations
      : _stations.where((s) => s.type == _filter).toList();

  Future<void> _open(_Station s) async {
    if (s.streamUrl.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No stream link set for ${s.name} yet.')),
      );
      return;
    }
    final uri = Uri.tryParse(s.streamUrl);
    if (uri == null) return;
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open the stream.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator(color: _green));
    }

    final tvCount = _stations.where((s) => s.type == 'TV').length;
    final radioCount = _stations.where((s) => s.type == 'Radio').length;

    return Column(
      children: [
        // Stats + filter
        Container(
          color: context.surface,
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _stat('$tvCount', 'TV stations'),
                  const SizedBox(width: 24),
                  _stat('$radioCount', 'Radio stations'),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  for (final f in const ['All', 'TV', 'Radio']) ...[
                    _chip(f),
                    const SizedBox(width: 8),
                  ],
                ],
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(12),
            itemCount: _visible.length,
            itemBuilder: (context, i) => _stationCard(_visible[i]),
          ),
        ),
      ],
    );
  }

  Widget _stat(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: _green,
          ),
        ),
        Text(label, style: TextStyle(fontSize: 11, color: context.textMuted)),
      ],
    );
  }

  Widget _chip(String label) {
    final selected = _filter == label;
    return GestureDetector(
      onTap: () => setState(() => _filter = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? _green : context.surfaceAlt,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: selected ? _green : context.hairline),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : context.textMuted,
            fontWeight: selected ? FontWeight.bold : FontWeight.normal,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  Widget _stationCard(_Station s) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.hairline),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: s.color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text(
                s.name.isNotEmpty ? s.name[0].toUpperCase() : '?',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        s.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: _green,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: s.type == 'TV'
                            ? const Color(0xFF1565C0).withOpacity(0.12)
                            : const Color(0xFF2E7D32).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        s.type == 'TV' ? 'TV' : s.frequency,
                        style: TextStyle(
                          color: s.type == 'TV'
                              ? const Color(0xFF0D47A1)
                              : const Color(0xFF1B5E20),
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                if (s.description.isNotEmpty) ...[
                  const SizedBox(height: 3),
                  Text(
                    s.description,
                    style: TextStyle(fontSize: 11, color: context.textMuted),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () => _open(s),
            icon: Icon(
              s.type == 'TV'
                  ? Icons.play_circle_fill
                  : Icons.headphones_rounded,
              color: const Color(0xFFFFCC00),
              size: 30,
            ),
            tooltip: s.type == 'TV' ? 'Watch live' : 'Listen live',
          ),
        ],
      ),
    );
  }
}
