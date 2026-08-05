// lib/screens/news_screen.dart
import 'package:flutter/material.dart';
import 'news_details.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  final List<Map<String, dynamic>> newsItems = const [
    {
      'title': 'President Ruto: UDA is the Party of the People, Delivering on Promises',
      'date': 'Sat, 27 Jul 2026',
      'image': 'https://via.placeholder.com/400x200/1A5C2A/FFCC00?text=UDA+News',
      'content': 'NAIROBI – President William Ruto has reaffirmed that the United Democratic Alliance (UDA) is the party of the people, committed to delivering on its promises and transforming Kenya.\n\nSpeaking during a UDA delegates meeting at KICC Nairobi, President Ruto highlighted the party\'s achievements in implementing the Bottom-Up Economic Transformation Agenda (BETA) and improving the lives of ordinary Kenyans.\n\n"UDA is not just a political party; it is a movement for change. We have promised Kenyans a better future, and we are delivering on that promise. From subsidizing fertilizer to creating jobs through Kazi Mtaani, we are walking the talk," President Ruto said.\n\nThe President also called on party members to remain united and focused on serving the people.\n\n"We must not lose sight of our mission. The people of Kenya have entrusted us with leadership, and we must honor that trust by working tirelessly to improve their lives."',
    },
    {
      'title': 'UDA Announces Grassroots Elections Roadmap for 2026',
      'date': 'Mon, 22 Jul 2026',
      'image': 'https://via.placeholder.com/400x200/FFCC00/1A5C2A?text=Elections',
      'content': 'NAIROBI – The United Democratic Alliance (UDA) has officially released the timetable for party grassroots elections across the country.\n\nThe roadmap, announced by the party\'s National Executive Council (NEC), outlines the schedule for elections at the village, ward, constituency, and county levels.\n\n"We are committed to strengthening our party structures from the grassroots level. These elections will ensure that every voice is heard and that our party remains truly representative of the people," said UDA Secretary General Cleophas Malala.\n\nThe elections are expected to be conducted between October and December 2026, with the National Delegates Convention scheduled for early 2027.',
    },
    {
      'title': 'UDA Youth League Launches Skills Development Program for 10,000 Young Kenyans',
      'date': 'Thu, 18 Jul 2026',
      'image': 'https://via.placeholder.com/400x200/1A5C2A/FFCC00?text=Youth',
      'content': 'NAIROBI – The UDA Youth League has launched a comprehensive skills development program targeting 10,000 young Kenyans across all 47 counties.\n\nThe program, dubbed "UDA Youth Skills for Employment," will provide training in digital skills, entrepreneurship, and vocational trades.\n\n"Youth unemployment is one of the biggest challenges facing our country. UDA is committed to empowering young people with the skills they need to secure jobs and create their own opportunities," said UDA Youth League Chairperson.\n\nThe program is part of the party\'s broader agenda to create employment opportunities and support youth entrepreneurship.',
    },
    {
      'title': 'UDA Women\'s League Launches Campaign for Affordable Maternal Healthcare',
      'date': 'Sat, 13 Jul 2026',
      'image': 'https://via.placeholder.com/400x200/FFCC00/1A5C2A?text=Women',
      'content': 'NAIROBI – The UDA Women\'s League has launched a nationwide campaign advocating for affordable and accessible maternal healthcare services.\n\nLed by UDA Women\'s League Chairperson, the campaign aims to reduce maternal mortality rates and improve healthcare outcomes for women across Kenya.\n\n"Every woman deserves access to quality healthcare. UDA is committed to ensuring that no woman dies while giving life. We are working with county governments to improve maternal health services," said the Chairperson.\n\nThe campaign includes community outreach programs, health education, and advocacy for increased healthcare funding at both national and county levels.',
    },
    {
      'title': 'UDA MPs Endorse Housing Levy, Say It Will Transform Housing Sector',
      'date': 'Sat, 6 Jul 2026',
      'image': 'https://via.placeholder.com/400x200/1A5C2A/FFCC00?text=Housing',
      'content': 'NAIROBI – UDA Members of Parliament have endorsed the Housing Levy, describing it as a transformative initiative that will revolutionize the housing sector in Kenya.\n\nThe MPs emphasized that the levy will enable the government to construct affordable housing units for Kenyans, addressing the housing deficit in the country.\n\n"This is a game-changer for the housing sector. The Housing Levy will enable us to build affordable homes for millions of Kenyans, creating jobs and improving lives," said the MPs.\n\nThey also called on Kenyans to support the initiative, saying it is part of UDA\'s commitment to improving the lives of all citizens.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'UDA NEWS',
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
              icon: const Icon(Icons.search, color: Colors.black),
              onPressed: () {
                print('🔍 Search tapped');
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // News Categories
            Container(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildCategoryChip('All', true),
                    const SizedBox(width: 8),
                    _buildCategoryChip('Politics', false),
                    const SizedBox(width: 8),
                    _buildCategoryChip('Economy', false),
                    const SizedBox(width: 8),
                    _buildCategoryChip('Youth', false),
                    const SizedBox(width: 8),
                    _buildCategoryChip('Women', false),
                    const SizedBox(width: 8),
                    _buildCategoryChip('Development', false),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Featured News - Passing context
            _buildFeaturedNews(context),
            const SizedBox(height: 16),

            // News Cards - Passing context
            ...newsItems.map((news) => _buildNewsCard(
              context: context,
              title: news['title'] as String,
              date: news['date'] as String,
              image: news['image'] as String,
              content: news['content'] as String,
            )).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFFFCC00) : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? const Color(0xFFFFCC00) : Colors.grey.shade300,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? const Color(0xFF1A5C2A) : Colors.grey[600],
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildFeaturedNews(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailsScreen(
              title: 'UDA: Building a Better Kenya Through Bottom-Up Approach',
              date: 'Sun, 28 Jul 2026',
              image: 'https://via.placeholder.com/400x200/FFCC00/1A5C2A?text=UDA+Featured',
              content: 'NAIROBI – The United Democratic Alliance (UDA) is transforming Kenya through the Bottom-Up Economic Transformation Agenda (BETA), focusing on empowering ordinary citizens and creating opportunities for all.\n\nSince taking office, UDA has implemented various programs aimed at reducing the cost of living, creating jobs, and improving access to essential services for all Kenyans.\n\n"We are committed to building a Kenya where every citizen has an opportunity to thrive. UDA is the party of the people, and we will continue to deliver on our promises," said President William Ruto.\n\nThe party has also emphasized the importance of unity and working together to achieve national development goals.',
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF1A5C2A), Color(0xFF2E7D32)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                'https://via.placeholder.com/400x200/FFCC00/1A5C2A?text=UDA+Featured',
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    color: Colors.grey[800],
                    child: const Center(
                      child: Icon(Icons.newspaper, color: Colors.white54, size: 64),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFCC00),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'FEATURED',
                      style: TextStyle(
                        color: Color(0xFF1A5C2A),
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'UDA: Building a Better Kenya Through Bottom-Up Approach',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 14, color: Colors.white70),
                      const SizedBox(width: 6),
                      const Text(
                        'Sun, 28 Jul 2026',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsCard({
    required BuildContext context,
    required String title,
    required String date,
    required String image,
    required String content,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailsScreen(
              title: title,
              date: date,
              image: image,
              content: content,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
              child: Image.network(
                image,
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 180,
                    width: double.infinity,
                    color: const Color(0xFF1A5C2A),
                    child: const Center(
                      child: Icon(
                        Icons.newspaper,
                        color: Colors.white54,
                        size: 48,
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A5C2A),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Text(
                        'Read More...',
                        style: TextStyle(
                          color: Color(0xFFFFCC00),
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_forward,
                        color: Color(0xFFFFCC00),
                        size: 14,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 1,
              color: Colors.grey.shade300,
            ),
          ],
        ),
      ),
    );
  }
}
