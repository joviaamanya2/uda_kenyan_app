// lib/screens/community/community_groups_screen.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../services/api_service.dart';
import '../../theme/theme_ext.dart';

class CommunityGroupsScreen extends StatefulWidget {
  const CommunityGroupsScreen({super.key});

  @override
  State<CommunityGroupsScreen> createState() => _CommunityGroupsScreenState();
}

class _CommunityGroupsScreenState extends State<CommunityGroupsScreen> {
  static const _green = Color(0xFF1A5C2A);
  static const _whatsapp = Color(0xFF25D366);

  bool _loading = true;

  // Bundled offline fallback; replaced by _load() with dashboard-managed groups.
  List<Map<String, dynamic>> _groups = const [
    {'name': 'UDA Party Members', 'description': '', 'whatsapp': ''},
    {'name': 'UDA Youth League', 'description': '', 'whatsapp': ''},
    {'name': 'UDA Women Congress', 'description': '', 'whatsapp': ''},
    {'name': 'UDA Bloggers & Digital Team', 'description': '', 'whatsapp': ''},
    {
      'name': 'UDA Persons with Disabilities Caucus',
      'description': '',
      'whatsapp': '',
    },
    {'name': 'UDA Diaspora Network', 'description': '', 'whatsapp': ''},
  ];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final rows = await ApiService.instance.getList('community-groups');
      if (mounted && rows.isNotEmpty) {
        setState(() {
          _groups = rows.map((g) {
            return {
              'name': (g['name'] ?? 'Group').toString(),
              'description': (g['description'] ?? '').toString(),
              'whatsapp': (g['whatsapp'] ?? '').toString(),
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

  String _iconFor(String name) {
    final n = name.toLowerCase();
    if (n.contains('youth')) return '🧑';
    if (n.contains('women')) return '👩';
    if (n.contains('blogger') || n.contains('digital') || n.contains('media')) {
      return '💻';
    }
    if (n.contains('disab')) return '♿';
    if (n.contains('diaspora')) return '🌍';
    if (n.contains('sport')) return '⚽';
    if (n.contains('elder')) return '👴';
    if (n.contains('artist')) return '🎭';
    return '🔵';
  }

  Uri? _joinUri(String whatsapp) {
    final w = whatsapp.trim();
    if (w.isEmpty) return null;
    if (w.startsWith('http')) return Uri.tryParse(w);
    // Treat as a phone number → open a WhatsApp chat.
    final digits = w.replaceAll(RegExp(r'[^0-9]'), '');
    if (digits.isEmpty) return null;
    return Uri.parse(
      'https://wa.me/$digits?text=${Uri.encodeComponent('Hi, I would like to join this UDA group.')}',
    );
  }

  Future<void> _join(Map<String, dynamic> group) async {
    final uri = _joinUri(group['whatsapp'] as String);
    if (uri == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'The WhatsApp link for "${group['name']}" is not set yet.',
          ),
        ),
      );
      return;
    }
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not open WhatsApp. Is it installed?'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: _green))
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: _whatsapp.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.chat_bubble, color: _whatsapp, size: 20),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Tap "Join" to open the group on WhatsApp.',
                            style: TextStyle(
                              fontSize: 12,
                              color: context.textStrong,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'UDA Groups',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: _green,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: _groups.isEmpty
                        ? const Center(
                            child: Text(
                              'No groups yet.',
                              style: TextStyle(color: Colors.grey),
                            ),
                          )
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: _groups.length,
                            itemBuilder: (context, i) => _groupItem(_groups[i]),
                          ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _groupItem(Map<String, dynamic> group) {
    final name = group['name'] as String;
    final description = group['description'] as String;
    final hasLink = (group['whatsapp'] as String).trim().isNotEmpty;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
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
        children: [
          Text(_iconFor(name), style: const TextStyle(fontSize: 26)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _green,
                  ),
                ),
                if (description.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: TextStyle(fontSize: 11, color: context.textMuted),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          ElevatedButton.icon(
            onPressed: () => _join(group),
            icon: const Icon(Icons.chat, size: 15),
            label: const Text('Join'),
            style: ElevatedButton.styleFrom(
              backgroundColor: hasLink ? _whatsapp : context.hairline,
              foregroundColor: hasLink ? Colors.white : context.textMuted,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              textStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
