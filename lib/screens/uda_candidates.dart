// lib/screens/uda_candidates.dart
import 'package:flutter/material.dart';
import '../theme/theme_ext.dart';

class UDACandidatesScreen extends StatelessWidget {
  const UDACandidatesScreen({super.key});

  static const List<Map<String, dynamic>> _positions = [
    {
      'title': 'President',
      'icon': Icons.how_to_vote,
      'count': '1',
      'note': 'Head of State and Government',
    },
    {
      'title': 'Governors',
      'icon': Icons.account_balance,
      'count': '47',
      'note': 'One for each county',
    },
    {
      'title': 'Senators',
      'icon': Icons.groups,
      'count': '47',
      'note': 'Represent counties in the Senate',
    },
    {
      'title': 'Woman Representatives',
      'icon': Icons.woman,
      'count': '47',
      'note': 'Elected county woman members of the National Assembly',
    },
    {
      'title': 'Members of Parliament',
      'icon': Icons.gavel,
      'count': '290',
      'note': 'Elected constituency representatives',
    },
    {
      'title': 'Members of County Assembly',
      'icon': Icons.person_pin,
      'count': '1,450',
      'note': 'Elected ward representatives',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        title: const Text(
          'UDA CANDIDATES',
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
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Elective seats in Kenya',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A5C2A),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'UDA fields candidates for every elective position in the country, '
              'from the presidency to the county assemblies.',
              style: TextStyle(fontSize: 13, color: context.textMuted),
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.95,
              ),
              itemCount: _positions.length,
              itemBuilder: (context, index) {
                final p = _positions[index];
                return _PositionCard(
                  title: p['title'] as String,
                  icon: p['icon'] as IconData,
                  count: p['count'] as String,
                  note: p['note'] as String,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _PositionCard extends StatelessWidget {
  const _PositionCard({
    required this.title,
    required this.icon,
    required this.count,
    required this.note,
  });

  final String title;
  final IconData icon;
  final String count;
  final String note;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.hairline),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFFFFCC00).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF1A5C2A), size: 24),
          ),
          const SizedBox(height: 10),
          Text(
            count,
            style: const TextStyle(
              color: Color(0xFF1A5C2A),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: context.textStrong,
            ),
          ),
          const SizedBox(height: 4),
          Text(note, style: TextStyle(fontSize: 11, color: context.textMuted)),
        ],
      ),
    );
  }
}
