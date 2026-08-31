// lib/screens/about_screen.dart
import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../theme/theme_ext.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  // Editable from the admin dashboard (Site settings). Defaults below.
  String _intro =
      'The United Democratic Alliance (UDA) is a Kenyan political party led by H.E Dr. William Samoei Ruto, President of the Republic of Kenya. It is the largest party in the Kenya Kwanza coalition government.';
  String _vision =
      'An equitably empowered Kenyan society living in a peaceful and united country.';
  String _mission =
      'The leadership of the party shall ensure a just and prosperous nation through good governance, nurturing the right political atmosphere for businesses and industries to thrive, development of human resource, foster political stability and welfare of the people of Kenya.';
  String _values =
      'The party is founded on the principles of good governance including equity, diversity, love, unity, freedom, justice, accountability, transparency and peace.';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final s = await ApiService.instance.getSettings();
    if (!mounted || s.isEmpty) return;
    String pick(String key, String fallback) =>
        (s[key]?.trim().isNotEmpty ?? false) ? s[key]!.trim() : fallback;
    setState(() {
      _intro = pick('about_intro', _intro);
      _vision = pick('about_vision', _vision);
      _mission = pick('about_mission', _mission);
      _values = pick('about_values', _values);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        title: const Text(
          'ABOUT UDA',
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
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section - History & Values
            _buildHeroSection(),

            // About Us Section
            _buildAboutUsSection(),

            // Our Values Section

            // Who We Are Section
            _buildWhoWeAreSection(),

            // Party Symbol Section
            _buildPartySymbolSection(),

            // Party Colors Section
            _buildPartyColorsSection(),

            // Our Manifesto & Contact Section
            _buildManifestoContactSection(),

            // Focus Areas
            _buildFocusAreasSection(),

            // Party History Timeline
            _buildPartyHistorySection(),

            // Foundation Details
            _buildFoundationDetailsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1A5C2A),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'History & Values',
            style: TextStyle(
              color: Color(0xFFFFCC00),
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          const SizedBox(height: 8),
          Container(width: 60, height: 4, color: const Color(0xFFFFCC00)),
          const SizedBox(height: 16),
          const Text(
            'About Us',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutUsSection() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Our Values',
            style: TextStyle(
              color: Color(0xFF1A5C2A),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Container(width: 50, height: 3, color: const Color(0xFFFFCC00)),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: context.surface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                _buildValueItem(
                  icon: Icons.gavel,
                  title: 'Good Governance',
                  description:
                      'The party is founded on the principles of good governance including equity, diversity, love, unity, freedom, justice, accountability, transparency and peace.',
                ),
                const Divider(height: 24),
                _buildValueItem(
                  icon: Icons.business_center,
                  title: 'Economic Prosperity',
                  description:
                      'The leadership of the party shall ensure a just and prosperous nation through good governance, nurturing the right political atmosphere for businesses and industries to thrive.',
                ),
                const Divider(height: 24),
                _buildValueItem(
                  icon: Icons.people,
                  title: 'Human Resource Development',
                  description:
                      'Development of human resource, foster political stability and welfare of the people of Kenya.',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildValueItem({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFFFCC00),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: const Color(0xFF1A5C2A), size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color(0xFF1A5C2A),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: 13,
                  color: context.textStrong,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWhoWeAreSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Who We Are',
              style: TextStyle(
                color: Color(0xFF1A5C2A),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              _intro,
              style: TextStyle(
                fontSize: 14,
                color: context.textStrong,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Our Vision',
              style: TextStyle(
                color: Color(0xFF1A5C2A),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _vision,
              style: TextStyle(
                fontSize: 14,
                color: context.textStrong,
                height: 1.6,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Our Mission',
              style: TextStyle(
                color: Color(0xFF1A5C2A),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _mission,
              style: TextStyle(
                fontSize: 14,
                color: context.textStrong,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Our Values',
              style: TextStyle(
                color: Color(0xFF1A5C2A),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _values,
              style: TextStyle(
                fontSize: 14,
                color: context.textStrong,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPartySymbolSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFF1A5C2A),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(
                  Icons.wheelchair_pickup,
                  color: Color(0xFFFFCC00),
                  size: 40,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Party Symbol',
                    style: TextStyle(
                      color: Color(0xFF1A5C2A),
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'The party symbol is a Wheelbarrow, symbolizing "the value, dignity and respect of work in pursuit of an equitable society".',
                    style: TextStyle(
                      fontSize: 13,
                      color: context.textMuted,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPartyColorsSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Party Colors',
              style: TextStyle(
                color: Color(0xFF1A5C2A),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildColorChip(const Color(0xFFFFCC00), 'Yellow'),
                const SizedBox(width: 12),
                _buildColorChip(Colors.black, 'Black'),
                const SizedBox(width: 12),
                _buildColorChip(const Color(0xFF1A5C2A), 'Green'),
                const SizedBox(width: 12),
                _buildColorChip(Colors.white, 'White', textColor: Colors.black),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorChip(
    Color color,
    String label, {
    Color textColor = Colors.white,
  }) {
    return Column(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: context.hairline, width: 1),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildManifestoContactSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Navigate to manifesto
              },
              child: Container(
                height: 80,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFCC00),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.description, color: Color(0xFF1A5C2A), size: 24),
                    SizedBox(height: 4),
                    Text(
                      'OUR MANIFESTO',
                      style: TextStyle(
                        color: Color(0xFF1A5C2A),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: () {
                // Navigate to contact
              },
              child: Container(
                height: 80,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A5C2A),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.phone, color: Color(0xFFFFCC00), size: 24),
                    SizedBox(height: 4),
                    Text(
                      'CONTACT US',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFocusAreasSection() {
    final focusAreas = <Map<String, dynamic>>[
      {'icon': Icons.agriculture, 'label': 'Agricultural Transformation'},
      {'icon': Icons.local_hospital, 'label': 'Healthcare & Education'},
      {'icon': Icons.house, 'label': 'Housing & Infrastructure'},
      {'icon': Icons.wifi, 'label': 'Digital Superhighway & ICT'},
      {'icon': Icons.factory, 'label': 'Manufacturing & Service Economy'},
      {'icon': Icons.storefront, 'label': 'Micro, Small & Medium Enterprises'},
      {
        'icon': Icons.volunteer_activism,
        'label': "Women's Agenda & Social Protection",
      },
      {'icon': Icons.eco, 'label': 'Environment, Sports & Governance'},
    ];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Our Focus Areas',
              style: TextStyle(
                color: Color(0xFF1A5C2A),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'UDA is anchored on the Bottom-Up Economic Transformation Agenda (BETA), which prioritises:',
              style: TextStyle(
                fontSize: 13,
                color: context.textStrong,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            ...focusAreas.map(
              (area) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFCC00),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        area['icon'] as IconData,
                        color: const Color(0xFF1A5C2A),
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        area['label'] as String,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF1A5C2A),
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
    );
  }

  Widget _buildPartyHistorySection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Party History',
              style: TextStyle(
                color: Color(0xFF1A5C2A),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            _buildTimelineItem(
              date: '2012',
              title: 'Registered as the Party of Action (POA)',
            ),
            _buildTimelineItem(
              date: 'Before 2017',
              title: 'Renamed Party of Development and Reforms (PDR)',
            ),
            _buildTimelineItem(
              date: 'December 2020',
              title: 'Rebranded to the United Democratic Alliance (UDA)',
            ),
            _buildTimelineItem(
              date: '8 January 2021',
              title: 'Official launch of UDA',
            ),
            _buildTimelineItem(
              date: '9 May 2022',
              title: 'Kenya Kwanza Coalition formed with ANC and FORD-Kenya',
            ),
            _buildTimelineItem(
              date: '9 August 2022',
              title:
                  'H.E William Ruto elected 5th President of Kenya on the UDA ticket',
            ),
            _buildTimelineItem(
              date: '17 January 2025',
              title: 'ANC merges into UDA, integrating its leadership',
              isFirst: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineItem({
    required String date,
    required String title,
    bool isFirst = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: const Color(0xFFFFCC00),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF1A5C2A), width: 2),
              ),
            ),
            if (!isFirst)
              Container(width: 2, height: 40, color: const Color(0xFFFFCC00)),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style: TextStyle(
                  color: context.textMuted,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF1A5C2A),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFoundationDetailsSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Foundation of the Party',
              style: TextStyle(
                color: Color(0xFF1A5C2A),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'The United Democratic Alliance was rebranded from the Party of Development and Reforms in December 2020 and officially launched on 8 January 2021 - a decision motivated by the need to transform the course of Kenyan politics and governance.',
              style: TextStyle(
                fontSize: 14,
                color: context.textStrong,
                height: 1.6,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFCC00).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFFFCC00), width: 1),
              ),
              child: Row(
                children: [
                  const Icon(Icons.info_outline, color: Color(0xFF1A5C2A)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'The formation of UDA marks a new chapter in Kenyan politics, focused on transformative leadership and good governance.',
                      style: TextStyle(
                        fontSize: 13,
                        color: context.textMuted,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
