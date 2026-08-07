// lib/screens/news_screen.dart
import 'package:flutter/material.dart';
import 'news_details.dart';

class NewsScreen extends StatefulWidget {
  final Map<String, dynamic>? selectedNews;

  const NewsScreen({super.key, this.selectedNews});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  bool _didOpenSelectedNews = false;

  final List<Map<String, dynamic>> newsItems = const [
    {
      'title':
          'UDA Secretary General, Sen. Hassan Omar Hassan paid a courtesy call to the Embassy of the Republic of Kenya in Juba, South Sudan',
      'date': 'July 23, 2026',
      'color': 0xFFFFCC00,
      'image': 'assets/images/news images/pic6.PNG',
      'content':
          'Sen. Hassan Omar Hassan visited the Kenyan Embassy in Juba to strengthen diplomatic ties and discuss future cooperation with South Sudanese leadership.',
    },
    {
      'title':
          'UDA Party Leader, President William Ruto presided over the party\'s National Executive Committee (NEC) meeting',
      'date': 'January 14, 2026',
      'color': 0xFF1A5C2A,
      'image': 'assets/images/news images/15.PNG',
      'content':
          'President Ruto led the NEC meeting to review UDA strategic priorities and reinforce party cohesion ahead of upcoming political engagements.',
    },
    {
      'title': 'UDA establish \'2027 Aspirants Forum\'',
      'date': 'January 21, 2026',
      'color': 0xFFFFCC00,
      'image': 'assets/images/news images/pic1.PNG',
      'content':
          'UDA announced a new 2027 Aspirants Forum to support, mentor, and organize potential candidates across the country.',
    },
    {
      'title': 'UDA Grassroots Sensitization Training in Kiambu County',
      'date': 'December 15, 2025',
      'color': 0xFF1A5C2A,
      'image': 'assets/images/news images/17.PNG',
      'content':
          'The party hosted a training session in Kiambu County focused on grassroots engagement and voter education for local communities.',
    },
    {
      'title': 'UDA Grassroots Sensitization Training in Uasin Gishu county',
      'date': 'December 17, 2025',
      'color': 0xFFFFCC00,
      'image': 'assets/images/news images/18.PNG',
      'content':
          'UDA continued its grassroots outreach with training in Uasin Gishu, empowering volunteers with civic education and mobilization tools.',
    },
    {
      'title':
          'Hassan Omar Leads Delegation in Courtesy Call on South Sudan President Salva Kiir',
      'date': 'July 21, 2026',
      'color': 0xFF1A5C2A,
      'image': 'assets/images/news images/pic9.PNG',
      'content':
          'A delegation led by Hassan Omar met South Sudan President Salva Kiir to discuss bilateral cooperation and regional stability.',
    },
  ];

  @override
  void initState() {
    super.initState();

    if (widget.selectedNews != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!_didOpenSelectedNews && mounted) {
          _didOpenSelectedNews = true;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsDetailsScreen(
                title: widget.selectedNews!['title'] as String,
                date: widget.selectedNews!['date'] as String,
                image: widget.selectedNews!['image'] as String,
                content:
                    widget.selectedNews!['content'] as String? ??
                    'Read more about the latest update in the news room.',
              ),
            ),
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'UDA NEWS',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
            ...newsItems
                .map(
                  (news) => _buildNewsCard(
                    context: context,
                    title: news['title'] as String,
                    date: news['date'] as String,
                    image: news['image'] as String,
                    content:
                        news['content'] as String? ?? 'No content available.',
                  ),
                )
                .toList(),
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
              image:
                  'https://via.placeholder.com/400x200/FFCC00/1A5C2A?text=UDA+Featured',
              content:
                  'NAIROBI – The United Democratic Alliance (UDA) is transforming Kenya through the Bottom-Up Economic Transformation Agenda (BETA), focusing on empowering ordinary citizens and creating opportunities for all.\n\nSince taking office, UDA has implemented various programs aimed at reducing the cost of living, creating jobs, and improving access to essential services for all Kenyans.\n\n"We are committed to building a Kenya where every citizen has an opportunity to thrive. UDA is the party of the people, and we will continue to deliver on our promises," said President William Ruto.\n\nThe party has also emphasized the importance of unity and working together to achieve national development goals.',
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
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
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
                      child: Icon(
                        Icons.newspaper,
                        color: Colors.white54,
                        size: 64,
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
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
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
                      const Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: Colors.white70,
                      ),
                      const SizedBox(width: 6),
                      const Text(
                        'Sun, 28 Jul 2026',
                        style: TextStyle(fontSize: 12, color: Colors.white70),
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
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: (image.startsWith('http') || image.startsWith('https'))
                  ? Image.network(
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
                    )
                  : Image.asset(
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
                      const Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: Colors.grey,
                      ),
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
            Container(height: 1, color: Colors.grey.shade300),
          ],
        ),
      ),
    );
  }
}
