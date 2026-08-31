// lib/screens/news_screen.dart
import 'package:flutter/material.dart';
import 'news_details.dart';
import '../services/api_service.dart';
import '../theme/theme_ext.dart';

class NewsScreen extends StatefulWidget {
  final Map<String, dynamic>? selectedNews;
  final bool embedded;

  const NewsScreen({super.key, this.selectedNews, this.embedded = false});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  bool _didOpenSelectedNews = false;

  static const List<String> _categories = [
    'All',
    'Politics',
    'Economy',
    'Youth',
    'Women',
    'Development',
  ];
  String _selectedCategory = 'All';

  final List<Map<String, dynamic>> newsItems = [
    {
      'title':
          'UDA Secretary General, Sen. Hassan Omar Hassan paid a courtesy call to the Embassy of the Republic of Kenya in Juba, South Sudan',
      'date': 'July 23, 2026',
      'category': 'Politics',
      'color': 0xFFFFCC00,
      'image': 'assets/images/news images/pic6.PNG',
      'content':
          'Sen. Hassan Omar Hassan visited the Kenyan Embassy in Juba to strengthen diplomatic ties and discuss future cooperation with South Sudanese leadership.',
    },
    {
      'title':
          'UDA Party Leader, President William Ruto presided over the party\'s National Executive Committee (NEC) meeting',
      'date': 'January 14, 2026',
      'category': 'Politics',
      'color': 0xFF1A5C2A,
      'image': 'assets/images/news images/15.PNG',
      'content':
          'President Ruto led the NEC meeting to review UDA strategic priorities and reinforce party cohesion ahead of upcoming political engagements.',
    },
    {
      'title': 'UDA establish \'2027 Aspirants Forum\'',
      'date': 'January 21, 2026',
      'category': 'Politics',
      'color': 0xFFFFCC00,
      'image': 'assets/images/news images/pic1.PNG',
      'content':
          'UDA announced a new 2027 Aspirants Forum to support, mentor, and organize potential candidates across the country.',
    },
    {
      'title': 'UDA Grassroots Sensitization Training in Kiambu County',
      'date': 'December 15, 2025',
      'category': 'Development',
      'color': 0xFF1A5C2A,
      'image': 'assets/images/news images/17.PNG',
      'content':
          'The party hosted a training session in Kiambu County focused on grassroots engagement and voter education for local communities.',
    },
    {
      'title': 'UDA Grassroots Sensitization Training in Uasin Gishu county',
      'date': 'December 17, 2025',
      'category': 'Development',
      'color': 0xFFFFCC00,
      'image': 'assets/images/news images/18.PNG',
      'content':
          'UDA continued its grassroots outreach with training in Uasin Gishu, empowering volunteers with civic education and mobilization tools.',
    },
    {
      'title':
          'Hassan Omar Leads Delegation in Courtesy Call on South Sudan President Salva Kiir',
      'date': 'July 21, 2026',
      'category': 'Politics',
      'color': 0xFF1A5C2A,
      'image': 'assets/images/news images/pic9.PNG',
      'content':
          'A delegation led by Hassan Omar met South Sudan President Salva Kiir to discuss bilateral cooperation and regional stability.',
    },
  ];

  List<Map<String, dynamic>> get _visibleNews {
    if (_selectedCategory == 'All') return newsItems;
    return newsItems
        .where(
          (n) =>
              (n['category'] as String?)?.toLowerCase() ==
              _selectedCategory.toLowerCase(),
        )
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _loadNews();
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

  Future<void> _loadNews() async {
    try {
      final remote = await ApiService.instance.getList('news');
      if (!mounted || remote.isEmpty) return;
      setState(() {
        newsItems
          ..clear()
          ..addAll(
            remote.map(
              (item) => {
                'title': item['title'] ?? 'UDA News',
                'date': item['published_at'] ?? '',
                'category': item['category'] ?? 'General',
                'color': 0xFFFFCC00,
                'image': item['image_path'] ?? 'assets/images/uda_logo.png',
                'content': item['content'] ?? '',
              },
            ),
          );
      });
    } catch (_) {
      // Keep bundled content available when the API is offline.
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
                'UDA NEWS',
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
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
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
                    for (final category in _categories) ...[
                      _buildCategoryChip(
                        category,
                        _selectedCategory == category,
                      ),
                      const SizedBox(width: 8),
                    ],
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // News Cards - Passing context
            if (_visibleNews.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 48),
                child: Center(
                  child: Column(
                    children: [
                      Icon(
                        Icons.article_outlined,
                        size: 48,
                        color: Colors.grey.shade400,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'No $_selectedCategory news yet.',
                        style: TextStyle(color: context.textMuted),
                      ),
                    ],
                  ),
                ),
              )
            else
              ..._visibleNews.map(
                (news) => _buildNewsCard(
                  context: context,
                  title: news['title'] as String,
                  date: news['date'] as String,
                  image: news['image'] as String,
                  content:
                      news['content'] as String? ?? 'No content available.',
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, bool isSelected) {
    return GestureDetector(
      onTap: () {
        if (_selectedCategory != label) {
          setState(() => _selectedCategory = label);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFCC00) : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? const Color(0xFFFFCC00) : context.hairline,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? const Color(0xFF1A5C2A) : context.textMuted,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 13,
          ),
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
          color: context.surface,
          borderRadius: BorderRadius.circular(16),
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
                top: Radius.circular(16),
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
            Container(height: 1, color: context.hairline),
          ],
        ),
      ),
    );
  }
}
