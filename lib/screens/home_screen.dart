// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:uda_app/utils/web_utils.dart';
import '../widgets/nearby_offices_card.dart';
import 'join_uda.dart';
import 'fundraise_screen.dart';
import 'all_elects_screen.dart';
import 'elects_details.dart';
import 'achievements_screen.dart';
import 'Live_tv.dart';
import 'events.dart';
import 'news_room.dart';
import './community/community_screen.dart';
import 'about_screen.dart';
import 'info_page_screen.dart';
import 'settings_screen.dart';
import 'contact_screen.dart';
import '../l10n/app_localizations.dart';
import 'videos_screen.dart';
import 'president_profile.dart';
import 'profile_screen.dart';
import 'general_secretary.dart';
import 'executive_committe.dart';
import 'uda_leadears.dart';
import 'uda_candidates.dart';
import 'language_selection_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import '../services/api_service.dart';
import '../theme/theme_ext.dart';

// ========== CUSTOM FEATURE ITEM WIDGET ==========
class _FeatureItem extends StatefulWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _FeatureItem({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_FeatureItem> createState() => _FeatureItemState();
}

class _FeatureItemState extends State<_FeatureItem> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = widget.isSelected
        ? const Color(0xFFFFCC00)
        : _isTapped
        ? const Color(0xFF1A5C2A)
        : Colors.black;
    final Color contentColor = widget.isSelected
        ? const Color(0xFF1A5C2A)
        : _isTapped
        ? const Color(0xFFFFCC00)
        : Colors.white;
    final Color shadowColor = widget.isSelected
        ? const Color(0xFFFFCC00).withOpacity(0.35)
        : _isTapped
        ? const Color(0xFF1A5C2A).withOpacity(0.4)
        : Colors.black.withOpacity(0.2);

    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isTapped = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          _isTapped = false;
        });
        widget.onTap();
      },
      onTapCancel: () {
        setState(() {
          _isTapped = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: widget.isSelected
              ? Border.all(color: const Color(0xFFFFCC00), width: 2)
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(widget.icon, color: contentColor, size: 24),
            const SizedBox(height: 4),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: contentColor,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class UDAHomeScreen extends StatefulWidget {
  const UDAHomeScreen({super.key});

  @override
  State<UDAHomeScreen> createState() => _UDAHomeScreenState();
}

class _UDAHomeScreenState extends State<UDAHomeScreen> {
  static bool _mapViewRegistered = false;
  String _selectedFeature = 'HOME';

  void _registerMapView() {
    if (!_mapViewRegistered && kIsWeb) {
      WebUtils.registerMapView();
      _mapViewRegistered = true;
    }
  }

  int _currentImageIndex = 0;
  final List<String> _carouselImages = [
    'assets/images/main.PNG',
    'assets/images/main2.PNG',
    'assets/images/Ruto.png',
  ];
  late final PageController _pageController;

  // Define elects data at class level to reuse. Bundled here as an offline
  // fallback; _loadLeaders() replaces it with live data from the backend.
  List<Map<String, dynamic>> elects = [
    {
      'name': 'H.E Dr.William Ruto',
      'position': 'President',
      'color': 0xFF1A5C2A,
      'constituency': 'National',
      'county': 'KENYA',
      'bio':
          'H.E Dr. William Ruto is the President of Kenya and the Party Leader of UDA. He is committed to transforming Kenya through the Bottom-Up Economic Transformation Agenda.',
      'date': 'Active since 2022',
      'office': 'State House, Nairobi',
      'image': 'assets/images/William Ruto.PNG',
    },
    {
      'name': 'H.E Pro.Kithure Kindiki',
      'position': 'Deputy President',
      'color': 0xFFFFCC00,
      'constituency': 'National',
      'county': 'KENYA',
      'bio':
          'H.E Pro.Kithure Kindiki is the Deputy President of Kenya. He is a dedicated leader focused on economic empowerment and grassroots development.',
      'date': 'Active since 2022',
      'office': 'State House, Nairobi',
      'image': 'assets/images/H.E Prof. Kithure Kindiki.PNG',
    },
    {
      'name': 'H.E Issa Timamy',
      'position': 'Governor, Lamu County',
      'color': 0xFF1A5C2A,
      'constituency': 'National',
      'county': 'KENYA',
      'bio':
          'H.E Issa Timamy is the Governor of Lamu County. He is committed to the development and welfare of his constituents.',
      'date': 'Active since 2023',
      'office': 'Nairobi, Kenya',
      'image': 'assets/images/H.E Issa Timamy.png',
    },
    {
      'name': 'H.E Cecily Mbarire',
      'position': 'Governor, Embu County',
      'color': 0xFFFFCC00,
      'constituency': 'National',
      'county': 'KENYA',
      'bio':
          'H.E Cecily Mbarire is the Governor of Embu County. She is dedicated to the development and welfare of her constituents.',
      'date': 'Active since 023',
      'office': 'Nairobi, Kenya',
      'image': 'assets/images/H.E Cecily Mbarire.PNG',
    },
    {
      'name': 'Mr. Kelvin Lunani',
      'position': 'DEPUTY CHAIRPERSON',
      'color': 0xFFFFCC00,
      'constituency': 'National',
      'county': 'KENYA',
      'bio':
          'Mr. Kelvin Lunani is the Deputy Chairperson of UDA. He is committed to the development and welfare of his constituents.',
      'date': 'Active since 2022',
      'office': 'Nairobi, Kenya',
      'image': 'assets/images/Mr. Kelvin Lunani.PNG',
    },
    {
      'name': 'Hon. Sen. Hassan Omar',
      'position': 'SECRETARY GENERAL,MP EALA',
      'color': 0xFFFFCC00,
      'constituency': 'National',
      'county': 'KENYA',
      'bio':
          'Hon. Sen. Hassan Omar is the Secretary General of UDA. He is committed to the development and welfare of his constituents.',
      'date': 'Active since 2021',
      'office': 'Nairobi, Kenya',
      'image': 'assets/images/Hon. Sen. Hassan Omar.PNG',
    },
    {
      'name': 'Hon. Omboko Milemba',
      'position': 'DEPUTY SECRETARY GENERAL,MP Emuhaya Constituency',
      'color': 0xFFFFCC00,
      'constituency': 'National',
      'county': 'KENYA',
      'bio':
          'Hon. Omboko Milemba is the Deputy Secretary General of UDA. He is committed to the development and welfare of his constituents.',
      'date': 'Active since 2022',
      'office': 'Nairobi, Kenya',
      'image': 'assets/images/Omboko Milemba.PNG',
    },
    {
      'name': 'Hon. Japheth Nyakundi',
      'position': 'NATIONAL TREASURER,MP Kitutu Chache North Constituency',
      'color': 0xFFFFCC00,
      'constituency': 'National',
      'county': 'KENYA',
      'bio':
          'Hon. Japheth Nyakundi is the National Treasurer of UDA. He is committed to the development and welfare of his constituents.',
      'date': 'Active since 2021',
      'office': 'Nairobi, Kenya',
      'image': 'assets/images/Hon. Japheth Nyakundi.PNG',
    },
    {
      'name': 'Mr. Nicodemus Bore',
      'position': 'EXECUTIVE DIRECTOR',
      'color': 0xFFFFCC00,
      'constituency': 'National',
      'county': 'KENYA',
      'bio':
          'Mr. Nicodemus Bore is the Executive Director of UDA. He is committed to the development and welfare of his constituents.',
      'date': 'Active since 2023',
      'office': 'Nairobi, Kenya',
      'image': 'assets/images/Mr. Nicodemus Bore.PNG',
    },
  ];

  // Bundled offline fallback for the "Latest Updates" section; replaced by
  // _loadUpdates() with live news from the backend.
  List<Map<String, dynamic>> _updates = [
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
      'image': 'assets/images/news images/19.PNG',
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
      'image': 'assets/images/news images/pic10.PNG',
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
    _registerMapView();
    _pageController = PageController(initialPage: _currentImageIndex);
    Future.delayed(const Duration(seconds: 3), _nextImage);
    _loadLeaders();
    _loadUpdates();
  }

  Future<void> _loadUpdates() async {
    try {
      final remote = await ApiService.instance.getList('news');
      if (!mounted || remote.isEmpty) return;
      setState(() {
        _updates = remote.asMap().entries.map((entry) {
          final item = entry.value;
          return {
            'title': item['title'] ?? 'UDA News',
            'date': _formatDate(item['published_at'] as String?),
            'color': entry.key.isEven ? 0xFFFFCC00 : 0xFF1A5C2A,
            'image': item['image_path'] ?? 'assets/images/uda_logo.png',
            'content': item['content'] ?? '',
          };
        }).toList();
      });
    } catch (_) {
      // Keep bundled content available when the API is offline.
    }
  }

  static const _monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  /// Formats a backend ISO timestamp (e.g. "2026-07-23T00:00:00.000000Z")
  /// into the "Month D, YYYY" style used throughout the UI. Falls back to
  /// the raw value when it isn't a parseable date.
  String _formatDate(String? raw) {
    if (raw == null || raw.isEmpty) return '';
    final parsed = DateTime.tryParse(raw);
    if (parsed == null) return raw;
    return '${_monthNames[parsed.month - 1]} ${parsed.day}, ${parsed.year}';
  }

  Future<void> _loadLeaders() async {
    try {
      final remote = await ApiService.instance.getList('leaders');
      if (!mounted || remote.isEmpty) return;

      // Only show elects that have a photo. Photo-less entries are added later
      // from the admin dashboard and appear here once an image is uploaded.
      final withPhotos = remote.where((item) {
        final photo = (item['photo_path'] ?? '').toString().trim();
        return photo.isNotEmpty;
      }).toList();
      if (withPhotos.isEmpty) return;

      setState(() {
        elects
          ..clear()
          ..addAll(
            withPhotos.asMap().entries.map((entry) {
              final item = entry.value;
              return {
                'name': item['name'] ?? 'UDA Leader',
                'position': item['position'] ?? '',
                'color': entry.key.isEven ? 0xFF1A5C2A : 0xFFFFCC00,
                'constituency': item['constituency'] ?? 'National',
                'county': item['county'] ?? 'KENYA',
                'bio': item['bio'] ?? '',
                'date': item['term_label'] ?? '',
                'office': item['office'] ?? '',
                'image': item['photo_path'],
                'isFeatured': item['is_featured'] == true,
              };
            }),
          );
      });
    } catch (_) {
      // Keep bundled content available when the API is offline.
    }
  }

  void _nextImage() {
    if (!mounted) return;
    final next = (_currentImageIndex + 1) % _carouselImages.length;
    _pageController.animateToPage(
      next,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeInOut,
    );
    setState(() {
      _currentImageIndex = next;
    });
    Future.delayed(const Duration(seconds: 3), _nextImage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String? findImage(String name) {
    final assets = [
      'assets/images/H.E Cecily Mbarire.PNG',
      'assets/images/H.E Prof. Kithure Kindiki.PNG',
      'assets/images/Hon. Japheth Nyakundi.PNG',
      'assets/images/Hon. Sen. Hassan Omar.PNG',
      'assets/images/H.E%20Cecily%20Mbarire.PNG',
      'assets/images/Mr. Kelvin Lunani.PNG',
      'assets/images/Mr. Nicodemus Bore.PNG',
      'assets/images/Omboko Milemba.PNG',
      'assets/images/Ruto.png',
      'assets/images/William Ruto.PNG',
      'assets/images/uda_logo.png',
      'assets/images/main.PNG',
      'assets/images/main2.PNG',
    ];

    final norm = name.toLowerCase().replaceAll(RegExp(r'[^a-z0-9 ]'), ' ');
    final words = norm.split(' ').where((w) => w.isNotEmpty).toList();

    for (final a in assets) {
      final fname = a
          .split('/')
          .last
          .toLowerCase()
          .replaceAll(RegExp(r'[^a-z0-9 ]'), ' ');
      final matchesAll = words.every((w) => fname.contains(w));
      if (matchesAll) return a;
    }

    if (words.isNotEmpty) {
      final last = words.last;
      for (final a in assets) {
        if (a.toLowerCase().contains(last)) return a;
      }
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildCarouselCard(),
                  const SizedBox(height: 16),
                  _buildUDAElectsSection(),
                  const SizedBox(height: 16),
                  _buildFeatureBar(),
                  _buildFeaturePanel(),
                  const SizedBox(height: 16),
                  _buildLatestUpdatesSection(),
                  const SizedBox(height: 16),
                  _buildChairmanSection(),
                  const SizedBox(height: 16),
                  _buildFourCardsGrid(),
                  const SizedBox(height: 16),
                  const NearbyOfficesCard(),
                  const SizedBox(height: 16),
                  _buildRoadmapAndContact(),
                  const SizedBox(height: 32),
                  // Footer with background color to separate
                  Container(
                    color: const Color(0xFF1A5C2A).withOpacity(0.05),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Column(children: [_buildFooter()]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFloatingButtons(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // ========== HEADER ==========
  Widget _buildHeader(BuildContext context) {
    return Container(
      color: const Color(0xFFFFCC00),
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 8),
      child: Row(
        children: [
          // Circular Logo - Updated
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.surface,
              border: Border.all(color: const Color(0xFF1A5C2A), width: 2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/uda_logo.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Center(
                    child: Text(
                      'UDA',
                      style: TextStyle(
                        color: const Color(0xFF1A5C2A),
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'UDA',
                style: TextStyle(
                  color: Color(0xFF1A5C2A),
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                'United Democratic Alliance',
                style: TextStyle(
                  color: context.textStrong,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LanguageSelectionScreen(),
                ),
              );
            },
            child: const Icon(Icons.language, color: Colors.black, size: 22),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            child: const Icon(
              Icons.person_outline,
              color: Colors.black,
              size: 24,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () => _showMenuDialog(context),
            child: const Icon(Icons.more_vert, color: Colors.black, size: 24),
          ),
        ],
      ),
    );
  }

  // ========== CAROUSEL CARD ==========
  Widget _buildCarouselCard() {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _carouselImages.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Image.asset(
                _carouselImages[index],
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                width: double.infinity,
                height: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFF1A5C2A),
                    child: const Center(
                      child: Icon(Icons.image, color: Colors.white54, size: 80),
                    ),
                  );
                },
              );
            },
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
              ),
            ),
          ),
          Positioned(
            top: 12,
            right: 16,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                _carouselImages.length,
                (index) => Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentImageIndex == index
                        ? const Color(0xFFFFCC00)
                        : Colors.white.withOpacity(0.5),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const JoinUDAScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: context.surface,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.person_add,
                            color: Color(0xFF1A5C2A),
                            size: 18,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'JOIN UDA',
                            style: TextStyle(
                              color: Color(0xFF1A5C2A),
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FundraiseScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFCC00),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.attach_money,
                            color: Color(0xFF1A5C2A),
                            size: 18,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'FUNDRISE',
                            style: TextStyle(
                              color: Color(0xFF1A5C2A),
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ========== UDA ELECTS SECTION ==========
  /// Circular elect photo. Accepts a bundled asset path or a network URL
  /// (uploaded from the admin dashboard); falls back to the name's initial.
  Widget _electAvatar(String? path, int color, String name) {
    final initial = Container(
      color: Color(color),
      child: Center(
        child: Text(
          name.isNotEmpty ? name.substring(0, 1) : '?',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );

    if (path == null || path.trim().isEmpty) return initial;

    final isNetwork = path.startsWith('http');
    return isNetwork
        ? Image.network(
            path,
            fit: BoxFit.cover,
            width: 80,
            height: 80,
            errorBuilder: (context, error, stackTrace) => initial,
          )
        : Image.asset(
            path,
            fit: BoxFit.cover,
            width: 80,
            height: 80,
            errorBuilder: (context, error, stackTrace) => initial,
          );
  }

  Widget _buildUDAElectsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'UDA ELECTS 2026',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1A5C2A),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AllElectsScreen(elects: elects),
                    ),
                  );
                },
                child: const Text(
                  'See All',
                  style: TextStyle(
                    color: Color(0xFFFFCC00),
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 168,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const BouncingScrollPhysics(),
            itemCount: elects.length,
            itemBuilder: (context, index) {
              final elect = elects[index];
              String? imagePath = elect['image'] as String?;
              if (imagePath == null) {
                imagePath = findImage(elect['name'] as String);
              }

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ElectDetailsScreen(elect: elect),
                    ),
                  );
                },
                child: Container(
                  width: 150,
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: context.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: context.hairline),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(elect['color'] as int),
                            width: 2,
                          ),
                        ),
                        child: ClipOval(
                          child: _electAvatar(
                            imagePath,
                            elect['color'] as int,
                            elect['name'] as String,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        elect['name'] as String,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          height: 1.2,
                          color: context.textStrong,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        elect['position'] as String,
                        style: TextStyle(
                          fontSize: 11,
                          height: 1.2,
                          color: context.textMuted,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ========== FEATURE BAR (Single long black card - Scrollable) ==========
  Widget _buildFeatureBar() {
    final features = [
      {'title': 'HOME', 'icon': Icons.home},
      {'title': 'ACHIEVEMENTS', 'icon': Icons.emoji_events},
      {'title': 'EVENTS', 'icon': Icons.event},
      {'title': 'LIVE TV', 'icon': Icons.live_tv},
      {'title': 'VIDEOS', 'icon': Icons.video_library},
      {'title': 'NEWS', 'icon': Icons.article},
      {'title': 'ABOUT UDA', 'icon': Icons.info},
      {'title': 'CONTACT', 'icon': Icons.contact_mail},
    ];

    return Container(
      width: double.infinity,
      color: Colors.black,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: features.map((feature) {
            final title = feature['title'] as String;
            return _FeatureItem(
              title: title,
              icon: feature['icon'] as IconData,
              isSelected: _selectedFeature == title,
              onTap: () {
                setState(() {
                  // Tapping the open tab closes it; HOME just closes any panel.
                  _selectedFeature =
                      (_selectedFeature == title || title == 'HOME')
                      ? 'HOME'
                      : title;
                });
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  // ========== EXPANDING FEATURE PANEL ==========
  Widget _buildFeaturePanel() {
    final screen = _featureScreenFor(_selectedFeature);

    return AnimatedSize(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      alignment: Alignment.topCenter,
      child: screen == null
          ? const SizedBox(width: double.infinity)
          : Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.72,
              margin: const EdgeInsets.only(top: 12),
              decoration: BoxDecoration(
                color: context.surface,
                border: Border(
                  top: BorderSide(color: context.hairline),
                  bottom: BorderSide(color: context.hairline),
                ),
              ),
              child: ClipRect(child: screen),
            ),
    );
  }

  Widget? _featureScreenFor(String feature) {
    switch (feature) {
      case 'ACHIEVEMENTS':
        return const AchievementsScreen(embedded: true);
      case 'EVENTS':
        return const EventsScreen(embedded: true);
      case 'LIVE TV':
        return const LiveTVScreen(embedded: true);
      case 'VIDEOS':
        return const VideosScreen(embedded: true);
      case 'NEWS':
        return const NewsScreen(embedded: true);
      case 'ABOUT UDA':
        return const AboutUDAScreen(embedded: true);
      case 'CONTACT':
        return const ContactScreen(embedded: true);
      default:
        return null;
    }
  }

  /// Full-bleed news image. Accepts a bundled asset path or a network URL
  /// (uploaded from the admin dashboard).
  Widget _newsImage(String? path) {
    final fallback = Container(
      color: context.hairline,
      child: Center(
        child: Icon(
          Icons.image_not_supported,
          color: Colors.grey[400],
          size: 40,
        ),
      ),
    );

    if (path == null || path.trim().isEmpty) {
      return Container(color: Colors.white);
    }

    return path.startsWith('http')
        ? Image.network(
            path,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (context, error, stackTrace) => fallback,
          )
        : Image.asset(
            path,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (context, error, stackTrace) => fallback,
          );
  }

  // ========== LATEST UPDATES SECTION ==========
  Widget _buildLatestUpdatesSection() {
    final updates = _updates;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'LATEST UPDATES',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1A5C2A),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NewsScreen()),
                  );
                },
                child: const Text(
                  'View All',
                  style: TextStyle(
                    color: Color(0xFFFFCC00),
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            physics: const BouncingScrollPhysics(),
            itemCount: updates.length,
            itemBuilder: (context, index) {
              final update = updates[index];
              final imagePath = update['image'] as String?;

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NewsScreen(selectedNews: update),
                    ),
                  );
                },
                child: Container(
                  width: 300,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Color(update['color'] as int),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        _newsImage(imagePath),

                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                const Color.fromARGB(
                                  255,
                                  39,
                                  38,
                                  38,
                                ).withOpacity(0.1),
                                const Color.fromARGB(
                                  255,
                                  37,
                                  37,
                                  37,
                                ).withOpacity(0.5),
                                const Color.fromARGB(
                                  255,
                                  44,
                                  44,
                                  44,
                                ).withOpacity(0.85),
                              ],
                              stops: const [0.0, 0.5, 1.0],
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                update['title'] as String,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Colors.white,
                                  height: 1.3,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black45,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.calendar_today,
                                    size: 12,
                                    color: Colors.white.withOpacity(0.9),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    update['date'] as String,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.white.withOpacity(0.9),
                                      shadows: [
                                        const Shadow(
                                          color: Colors.black45,
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                      size: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          height: 4,
                          child: Container(
                            color: Color(update['color'] as int),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // ========== CHAIRMAN SECTION ==========
  Widget _buildChairmanSection() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PresidentProfileScreen(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: context.surface,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFFFCC00), width: 3),
                image: const DecorationImage(
                  image: AssetImage('assets/images/William Ruto.PNG'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'UDA CHAIRMAN',
                    style: TextStyle(
                      color: Color(0xFFFFCC00),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'H.E Dr. William Ruto',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w900,
                      color: context.isDark
                          ? const Color(0xFF6FCB8A)
                          : const Color(0xFF1A5C2A),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Party Leader & President of Kenya',
                    style: TextStyle(fontSize: 13, color: context.textMuted),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFFFFCC00),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  // ========== FOUR CARDS GRID ==========
  Widget _buildFourCardsGrid() {
    final cards = [
      {
        'title': 'Central Executive Committee',
        'color': 0xFF1A5C2A,
        'screen': const ExecutiveCommitteeScreen(),
        'image': 'assets/images/news images/15.PNG',
        'bgColor': const Color(0xFF1A5C2A),
      },
      {
        'title': 'General Secretary',
        'color': 0xFFFFCC00,
        'screen': const GeneralSecretaryProfileScreen(),
        'image': 'assets/images/Hon. Sen. Hassan Omar.PNG',
        'isGeneralSecretary': true,
        'bgColor': const Color(0xFF2C2C2C),
      },
      {
        'title': 'UDA Leaders',
        'color': 0xFFFFCC00,
        'screen': const UDALeadersScreen(),
        'image': 'assets/images/news images/pic3.PNG',
        'bgColor': const Color(0xFF2C2C2C),
      },
      {
        'title': 'UDA Candidates',
        'color': 0xFFFFCC00,
        'screen': const UDACandidatesScreen(),
        'image': 'assets/images/news images/pic3.PNG',
        'bgColor': const Color(0xFF2C2C2C),
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.2,
        ),
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];
          final isGenSec = card['isGeneralSecretary'] == true;
          final isLogoCard = card['isLogoCard'] == true;
          final imagePath = card['image'] as String?;
          final bgColor = card['bgColor'] as Color;

          // Get color with null safety
          final int colorValue = card['color'] as int;
          final Color borderColor = Color(colorValue);

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => card['screen'] as Widget,
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: borderColor, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    if (isLogoCard) ...[
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Opacity(
                            opacity: 0.2,
                            child: Image.asset(
                              'assets/images/uda_logo.png',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  const SizedBox.shrink(),
                            ),
                          ),
                        ),
                      ),
                    ] else if (imagePath != null) ...[
                      // Higher opacity for clearer images on Secretary and RDCS cards
                      Opacity(
                        opacity: 0.55,
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(color: bgColor),
                        ),
                      ),
                    ],
                    // Dark overlay for better text visibility
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.2),
                            Colors.black.withOpacity(0.6),
                          ],
                        ),
                      ),
                    ),
                    // Card Content - White text on dark background
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (isGenSec) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                            ),
                            const SizedBox(height: 6),
                          ],
                          Text(
                            card['title'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 14,
                              color: Colors.white,
                              height: 1.25,
                              letterSpacing: 0.2,
                              shadows: [
                                Shadow(
                                  color: Colors.black45,
                                  blurRadius: 4,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Container(
                            width: 30,
                            height: 3,
                            decoration: BoxDecoration(
                              color: borderColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ========== OUR ROADMAP ==========
  Widget _buildRoadmapAndContact() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const InfoPageScreen(
                title: 'Our Roadmap',
                sections: udaRoadmapSections,
              ),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFFFCC00),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: const [
              Icon(Icons.map, color: Color(0xFF1A5C2A)),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'OUR ROADMAP',
                      style: TextStyle(
                        color: Color(0xFF1A5C2A),
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      'The Bottom-Up Economic Transformation Agenda (BETA)',
                      style: TextStyle(color: Color(0xFF1A5C2A), fontSize: 11),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Color(0xFF1A5C2A), size: 14),
            ],
          ),
        ),
      ),
    );
  }

  // ========== FLOATING BUTTONS ==========
  Widget _buildFloatingButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FloatingActionButton.extended(
            heroTag: 'support',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactScreen()),
              );
            },
            backgroundColor: const Color.fromARGB(255, 2, 17, 6),
            icon: const Icon(Icons.support_agent, color: Colors.white),
            label: const Text(
              'SUPPORT CENTER',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          FloatingActionButton.extended(
            heroTag: 'chat',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CommunityScreen(),
                ),
              );
            },
            backgroundColor: const Color(0xFFFFCC00),
            icon: const Icon(Icons.chat, color: Color(0xFF1A5C2A)),
            label: const Text(
              'CHAT',
              style: TextStyle(
                color: Color(0xFF1A5C2A),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ========== FOOTER ==========
  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '© 2024 UDA Party. All Rights Reserved.',
            style: TextStyle(color: Colors.grey, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ========== MENU DIALOG ==========
  void _showMenuDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: context.hairline,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              _menuTile(
                context,
                icon: Icons.person,
                label: context.l10n('menu_profile'),
                screen: const ProfileScreen(),
              ),
              _menuTile(
                context,
                icon: Icons.settings,
                label: context.l10n('menu_settings'),
                screen: const SettingsScreen(),
              ),
              _menuTile(
                context,
                icon: Icons.help,
                label: context.l10n('menu_help'),
                screen: const ContactScreen(),
              ),
              _menuTile(
                context,
                icon: Icons.info,
                label: context.l10n('menu_about'),
                screen: const AboutUDAScreen(),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  Widget _menuTile(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Widget screen,
  }) {
    return Material(
      color: Colors.transparent,
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFF1A5C2A)),
        title: Text(label),
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
      ),
    );
  }
}
