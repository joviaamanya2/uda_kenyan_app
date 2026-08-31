// lib/screens/live_tv_screen.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/api_service.dart';
import '../theme/theme_ext.dart';

class LiveTVScreen extends StatefulWidget {
  final bool embedded;
  const LiveTVScreen({super.key, this.embedded = false});

  @override
  State<LiveTVScreen> createState() => _LiveTVScreenState();
}

class _LiveTVScreenState extends State<LiveTVScreen> {
  static const _green = Color(0xFF1A5C2A);

  bool _loading = true;
  String _title = 'UDA TV';
  String _url = '';
  String _note = 'Live broadcasts are coming soon. Stay tuned.';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final s = await ApiService.instance.getSettings();
    if (!mounted) return;
    setState(() {
      _title = (s['livetv_title'] ?? '').isNotEmpty
          ? s['livetv_title']!
          : _title;
      _url = s['livetv_url'] ?? '';
      _note = (s['livetv_note'] ?? '').isNotEmpty ? s['livetv_note']! : _note;
      _loading = false;
    });
  }

  Future<void> _watch() async {
    final uri = Uri.tryParse(_url);
    if (uri == null) return;
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open the live stream.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasStream = _url.trim().isNotEmpty;

    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: widget.embedded
          ? null
          : AppBar(
              title: const Text(
                'LIVE TV',
                style: TextStyle(
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
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: _green))
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 300,
                      height: 190,
                      decoration: BoxDecoration(
                        color: _green,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        hasStream
                            ? Icons.play_circle_filled
                            : Icons.live_tv_outlined,
                        size: 64,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      _title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _green,
                      ),
                    ),
                    const SizedBox(height: 8),
                    if (hasStream) ...[
                      const Text(
                        'Watch the UDA live broadcast now.',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton.icon(
                        onPressed: _watch,
                        icon: const Icon(Icons.play_arrow),
                        label: const Text('WATCH LIVE'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFCC00),
                          foregroundColor: _green,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 28,
                            vertical: 14,
                          ),
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ] else
                      Text(
                        _note,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                  ],
                ),
              ),
            ),
    );
  }
}
