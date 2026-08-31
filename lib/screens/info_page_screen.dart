// lib/screens/info_page_screen.dart
import 'package:flutter/material.dart';
import '../theme/theme_ext.dart';

/// A simple, reusable screen for static informational content such as the
/// Privacy Policy and Terms & Conditions.
class InfoPageScreen extends StatelessWidget {
  const InfoPageScreen({
    super.key,
    required this.title,
    required this.sections,
    this.lastUpdated,
  });

  final String title;
  final String? lastUpdated;

  /// Ordered list of `(heading, body)` pairs.
  final List<({String heading, String body})> sections;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        title: Text(
          title.toUpperCase(),
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
            if (lastUpdated != null) ...[
              Text(
                'Last updated: $lastUpdated',
                style: TextStyle(fontSize: 12, color: context.textMuted),
              ),
              const SizedBox(height: 16),
            ],
            for (final section in sections) ...[
              Text(
                section.heading,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A5C2A),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                section.body,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: context.textStrong,
                ),
              ),
              const SizedBox(height: 18),
            ],
          ],
        ),
      ),
    );
  }
}

/// Content for the UDA political & economic roadmap.
const List<({String heading, String body})> udaRoadmapSections = [
  (
    heading: 'The Vision',
    body:
        'An equitably empowered Kenyan society living in a peaceful and united '
        'country. UDA\'s roadmap turns that vision into concrete action through '
        'the Bottom-Up Economic Transformation Agenda (BETA).',
  ),
  (
    heading: 'Bottom-Up Economic Transformation',
    body:
        'Growth is driven from the base of the pyramid upward — investing in '
        'the hustlers, small traders, farmers and workers who form the majority '
        'of Kenyans, rather than relying on wealth to trickle down.',
  ),
  (
    heading: 'Agriculture & Food Security',
    body:
        'Subsidised fertiliser and inputs, stronger cooperatives, better '
        'markets and value addition so farmers earn more and food prices are '
        'stabilised.',
  ),
  (
    heading: 'Micro, Small & Medium Enterprises',
    body:
        'Affordable credit through the Hustler Fund, county aggregation and '
        'industrial parks, and simpler licensing to help small businesses grow '
        'and create jobs.',
  ),
  (
    heading: 'Housing & Settlement',
    body:
        'The Affordable Housing Programme to deliver decent homes, formalise '
        'informal settlements and create construction jobs for young people.',
  ),
  (
    heading: 'Universal Health Coverage',
    body:
        'Primary healthcare closer to communities, a reformed social health '
        'insurance model and more community health promoters.',
  ),
  (
    heading: 'Digital Superhighway & Creative Economy',
    body:
        'Nationwide fibre connectivity, digital jobs and government services '
        'online, plus support for Kenya\'s creative and sports talent.',
  ),
  (
    heading: 'Grassroots Democracy',
    body:
        'Regular party elections at ward, constituency and county level so '
        'members choose their own leaders and the party stays accountable.',
  ),
];

/// Content for the UDA app Privacy Policy.
const List<({String heading, String body})> udaPrivacyPolicySections = [
  (
    heading: 'Introduction',
    body:
        'The United Democratic Alliance (UDA) respects your privacy. This policy '
        'explains what information the UDA mobile app collects, how it is used, '
        'and the choices you have.',
  ),
  (
    heading: 'Information We Collect',
    body:
        'When you create an account we collect your name, email address and '
        'phone number. If you join the party or make a contribution through the '
        'app, we collect the details you submit on those forms. With your '
        'permission the app may access your location to show the nearest UDA '
        'offices, and your camera or photo library when you post to the '
        'community feed or upload a profile picture.',
  ),
  (
    heading: 'How We Use Your Information',
    body:
        'We use your information to operate the app, respond to your messages '
        'and requests, process membership and contributions, and keep you '
        'informed about party news and events. We do not sell your personal '
        'information.',
  ),
  (
    heading: 'Data Sharing',
    body:
        'Information is shared only with UDA staff and service providers who '
        'help us run the app, or where required by Kenyan law.',
  ),
  (
    heading: 'Your Rights',
    body:
        'You may review or update your profile at any time in the app, and you '
        'may request that we delete your account by contacting us.',
  ),
  (
    heading: 'Contact',
    body:
        'For any privacy question, contact the UDA Secretariat at Hustler '
        'Plaza, Ngong Road, Nairobi, telephone 020 2020405, or email '
        'hello@uda.ke.',
  ),
];

/// Content for the UDA app Terms & Conditions.
const List<({String heading, String body})> udaTermsSections = [
  (
    heading: 'Acceptance of Terms',
    body:
        'By downloading or using the UDA mobile app you agree to these terms. '
        'If you do not agree, please do not use the app.',
  ),
  (
    heading: 'Use of the App',
    body:
        'The app is provided for lawful, personal use to access UDA news, '
        'events, resources and community features. You agree not to misuse the '
        'app, attempt to disrupt it, or use it to post unlawful, abusive or '
        'misleading content.',
  ),
  (
    heading: 'Your Account',
    body:
        'You are responsible for keeping your login details secure and for '
        'activity that happens under your account. Provide accurate information '
        'when you register or submit forms.',
  ),
  (
    heading: 'User Content',
    body:
        'You retain ownership of photos, videos and messages you post, but you '
        'grant UDA permission to display them within the app. UDA may remove '
        'content that breaches these terms.',
  ),
  (
    heading: 'Contributions',
    body:
        'Any contribution made through the app is voluntary and is used to '
        'support party activities in line with Kenyan law.',
  ),
  (
    heading: 'Changes',
    body:
        'UDA may update these terms from time to time. Continued use of the app '
        'after an update means you accept the revised terms.',
  ),
  (
    heading: 'Contact',
    body:
        'Questions about these terms can be sent to the UDA Secretariat at '
        'Hustler Plaza, Ngong Road, Nairobi, telephone 020 2020405, or email '
        'hello@uda.ke.',
  ),
];
