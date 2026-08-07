// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:uda_app/utils/web_utils.dart';
import 'package:uda_app/screens/uda_candidates.dart';
import 'join_uda.dart';
import 'fundraise_screen.dart';
import 'all_elects_screen.dart';
import 'elects_details.dart';
import 'achievements_screen.dart';
import 'Live_tv.dart';
import 'events.dart';
import 'gallery.dart';
import 'news_room.dart';
import 'about_screen.dart';
import 'contact_screen.dart';
import 'ask_president.dart';
import 'achievements_details.dart';
import 'videos_screen.dart';
import 'president_profile.dart';
import 'general_secretary.dart';
import 'executive_committe.dart';
import 'rdcs_and_drdcs.dart';
import 'uda_leadears.dart';
import 'uda_candidates.dart';
import 'language_selection_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// ========== CUSTOM FEATURE ITEM WIDGET ==========
class _FeatureItem extends StatefulWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _FeatureItem({
    required this.title,
    required this.icon,
    required this.onTap,
    super.key,
  });

  @override
  State<_FeatureItem> createState() => _FeatureItemState();
}

class _FeatureItemState extends State<_FeatureItem> {
  bool _isTapped = false;

  @override
  Widget build(BuildContext context) {
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
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: _isTapped 
              ? const Color(0xFF1A5C2A) // Green when tapped
              : Colors.black, // Black normally
          borderRadius: BorderRadius.circular(12),
          boxShadow: _isTapped
              ? [
                  BoxShadow(
                    color: const Color(0xFF1A5C2A).withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              color: _isTapped 
                  ? const Color(0xFFFFCC00) // Gold when tapped
                  : Colors.white, // White normally
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              widget.title,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: _isTapped 
                    ? const Color(0xFFFFCC00) // Gold when tapped
                    : Colors.white, // White normally
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

  // Define elects data at class level to reuse
  final List<Map<String, dynamic>> elects = [
    {
      'name': 'William Ruto',
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

  @override
  void initState() {
    super.initState();
    _registerMapView();
    _pageController = PageController(initialPage: _currentImageIndex);
    Future.delayed(const Duration(seconds: 3), _nextImage);
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
      'assets/images/logo.png',
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
      backgroundColor: const Color(0xFFF5F5F5),
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
                  const SizedBox(height: 16),
                  _buildLatestUpdatesSection(),
                  const SizedBox(height: 16),
                  _buildChairmanSection(),
                  const SizedBox(height: 16),
                  _buildFourCardsGrid(),
                  const SizedBox(height: 16),
                  _buildUDANearYou(),
                  const SizedBox(height: 16),
                  _buildRoadmapAndContact(),
                  const SizedBox(height: 16),
                  _buildFooter(),
                  const SizedBox(height: 24),
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
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: const Color(0xFF1A5C2A), width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.asset(
                'assets/images/logo.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(
                    child: Text(
                      'UDA',
                      style: TextStyle(
                        color: Color(0xFF1A5C2A),
                        fontWeight: FontWeight.w900,
                        fontSize: 10,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 4),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'UDA',
                style: TextStyle(
                  color: Color(0xFF1A5C2A),
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text(
                'United Democratic Alliance',
                style: TextStyle(
                  color: Colors.black87,
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
            child: const Icon(
              Icons.language,
              color: Colors.black,
              size: 22,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              print('👤 Profile tapped');
            },
            child: const Icon(
              Icons.person_outline,
              color: Colors.black,
              size: 24,
            ),
          ),
          const SizedBox(width: 8),
          GestureDetector(
            onTap: () {
              print('⋮ Menu tapped');
              _showMenuDialog(context);
            },
            child: const Icon(
              Icons.more_vert,
              color: Colors.black,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  // ========== CAROUSEL CARD ==========
  Widget _buildCarouselCard() {
    return Container(
      height: 200,
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
                        color: Colors.white,
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
          height: 120,
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
                  width: 140,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Color(elect['color'] as int),
                            width: 2,
                          ),
                        ),
                        child: ClipOval(
                          child: imagePath != null
                              ? Image.asset(
                                  imagePath,
                                  fit: BoxFit.cover,
                                  width: 80,
                                  height: 80,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Color(elect['color'] as int),
                                      child: Center(
                                        child: Text(
                                          (elect['name'] as String).substring(
                                            0,
                                            1,
                                          ),
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Container(
                                  color: Color(elect['color'] as int),
                                  child: Center(
                                    child: Text(
                                      (elect['name'] as String).substring(0, 1),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        elect['name'] as String,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        elect['position'] as String,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
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
      {'title': 'GALLERY', 'icon': Icons.photo_library},
      {'title': 'VIDEOS', 'icon': Icons.video_library},
      {'title': 'NEWS', 'icon': Icons.article},
      {'title': 'ABOUT UDA', 'icon': Icons.info},
      {'title': 'CONTACT', 'icon': Icons.contact_mail},
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: features.map((feature) {
            return _FeatureItem(
              title: feature['title'] as String,
              icon: feature['icon'] as IconData,
              onTap: () {
                _navigateToFeature(context, feature['title'] as String);
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  // ========== NAVIGATION HELPER ==========
  void _navigateToFeature(BuildContext context, String feature) {
    switch (feature) {
      case 'HOME':
        break;
      case 'ACHIEVEMENTS':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AchievementsScreen()),
        );
        break;
      case 'EVENTS':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EventsScreen()),
        );
        break;
      case 'LIVE TV':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LiveTVScreen()),
        );
        break;
      case 'GALLERY':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const GalleryScreen()),
        );
        break;
      case 'NEWS':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NewsScreen()),
        );
        break;
      case 'ABOUT UDA':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AboutUDAScreen()),
        );
        break;
      case 'VIDEOS':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const VideosScreen()),
        );
        break;
      case 'CONTACT':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ContactScreen()),
        );
        break;
      default:
        break;
    }
  }

 // ========== LATEST UPDATES SECTION ==========
Widget _buildLatestUpdatesSection() {
  final updates = [
    {
      'title': 'UDA Secretary General, Sen. Hassan Omar Hassan paid a courtesy call to the Embassy of the Republic of Kenya in Juba, South Sudan',
      'date': 'July 23, 2026',
      'color': 0xFFFFCC00,
      'image': 'assets/images/news images/pic6.PNG',
    },
    {
      'title': 'UDA Party Leader, President William Ruto presided over the party\'s National Executive Committee (NEC) meeting',
      'date': 'January 14, 2026',
      'color': 0xFF1A5C2A,
      'image': 'assets/images/news images/15.PNG',
    },
    {
      'title': 'UDA establish \'2027 Aspirants Forum\'',
      'date': 'January 21, 2026',
      'color': 0xFFFFCC00,
      'image': 'assets/images/news images/pic1.PNG',
    },
    {
      'title': 'UDA Grassroots Sensitization Training in Kiambu County',
      'date': 'December 15, 2025',
      'color': 0xFF1A5C2A,
      'image': 'assets/images/news images/17.PNG',
    },
    {
      'title': 'UDA Grassroots Sensitization Training in Uasin Gishu county',
      'date': 'December 17, 2025',
      'color': 0xFFFFCC00,
      'image': 'assets/images/news images/18.PNG',
    },
    {
      'title': 'Hassan Omar Leads Delegation in Courtesy Call on South Sudan President Salva Kiir',
      'date': 'July 21, 2026',
      'color': 0xFF1A5C2A,
      'image': 'assets/images/news images/pic9.PNG',
    },
  ];

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'LATEST UPDATES',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Color(0xFF1A5C2A),
              ),
            ),
            Text(
              'View All',
              style: TextStyle(
                color: Color(0xFFFFCC00),
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 8),
      SizedBox(
        height: 200, // Increased height to accommodate description
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
                print('📰 Update ${index + 1} tapped: ${update['title']}');
              },
              child: Container(
                width: 300, // Slightly wider for better text display
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
                      // Background Image
                      if (imagePath != null)
                        Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[200],
                              child: Center(
                                child: Icon(
                                  Icons.image_not_supported,
                                  color: Colors.grey[400],
                                  size: 40,
                                ),
                              ),
                            );
                          },
                        )
                      else
                        Container(
                          color: Colors.white,
                        ),
                      
                      // Dark Gradient Overlay - stronger at bottom
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.1),
                              Colors.black.withOpacity(0.5),
                              Colors.black.withOpacity(0.85),
                            ],
                            stops: const [0.0, 0.5, 1.0],
                          ),
                        ),
                      ),
                      
                      // Content - Now with description and date at bottom
                      Padding(
                        padding: const EdgeInsets.all(14),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Description/Title at bottom
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
                            
                            // Date and arrow row
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
                                // Small indicator arrow
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
                      
                      // Color accent strip at bottom
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
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
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
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFFFCC00), width: 3),
                image: const DecorationImage(
                  image: AssetImage('assets/images/William Ruto.PNG'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'UDA CHAIRMAN',
                    style: TextStyle(
                      color: Color(0xFFFFCC00),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    'H.E Dr. William Ruto',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1A5C2A),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Party Leader & President of Kenya',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
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
      },
      {
        'title': 'General Secretary',
        'color': 0xFFFFCC00,
        'screen': const GeneralSecretaryProfileScreen(),
        'image': 'assets/images/Hon. Sen. Hassan Omar.PNG',
        'isGeneralSecretary': true,
      },
      {
        'title': 'Party Manifesto',
        'color': 0xFF1A5C2A,
        'screen': const AboutUDAScreen(),
        'image': 'assets/images/logo.png',
        'isLogoCard': true,
      },
      {
        'title': 'UDA Leaders',
        'color': 0xFFFFCC00,
        'screen': const UDALeadersScreen(),
        'image': 'assets/images/news images/pic3.PNG',
      },
      {
        'title': 'RDCS & DRDCS',
        'color': 0xFF1A5C2A,
        'screen': const RDCSDRDCSScreen(),
        'image': 'assets/images/news images/pic6.PNG',
      },
      {
        'title': 'UDA Candidates',
        'color': 0xFFFFCC00,
        'screen': const UDACandidatesScreen(),
        'image': 'assets/images/news images/pic3.PNG',
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
                color: const Color(0xFF161B17), // Dark charcoal base
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Color(card['color'] as int),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.20),
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
                      // Party Manifesto: Faded UDA Logo background
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Opacity(
                            opacity: 0.35,
                            child: Image.asset(
                              'assets/images/logo.png',
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                            ),
                          ),
                        ),
                      ),
                      // Dark gradient overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.20),
                              Colors.black.withOpacity(0.85),
                            ],
                          ),
                        ),
                      ),
                    ] else if (imagePath != null) ...[
                      // Faded Dark Photo Background
                      Opacity(
                        opacity: 0.40,
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: const Color(0xFF1A5C2A),
                          ),
                        ),
                      ),
                      // Dark gradient overlay for rich contrast
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.20),
                              Colors.black.withOpacity(0.60),
                              Colors.black.withOpacity(0.90),
                            ],
                            stops: const [0.0, 0.5, 1.0],
                          ),
                        ),
                      ),
                    ],

                    // Card Content (Words positioned LOWER at bottom in WHITE for high contrast)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (isGenSec) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFCC00),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Text(
                                'OFFICE',
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF1A5C2A),
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                          ],
                          Text(
                            card['title'] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 13,
                              color: Colors.white,
                              height: 1.25,
                              letterSpacing: 0.2,
                              shadows: [
                                Shadow(
                                  color: Colors.black87,
                                  blurRadius: 4,
                                  offset: Offset(0, 1),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
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

  // ========== UDA NEAR YOU ==========
  Widget _buildUDANearYou() {
    // Show different UI based on platform
    if (!kIsWeb) {
      // Mobile fallback UI
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.12),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                color: Color(0xFF1A5C2A),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Row(
                children: [
                  const Icon(Icons.location_on, color: Color(0xFFFFCC00), size: 20),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'UDA NEAR YOU',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Find your nearest UDA office',
                          style: TextStyle(color: Colors.white70, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey[200],
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.location_on, size: 48, color: Color(0xFF1A5C2A)),
                    SizedBox(height: 8),
                    Text(
                      'UDA Head Office',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A5C2A),
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Nairobi, Kenya',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    // Web platform - show Google Maps
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with title and "Open Map" button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: Color(0xFF1A5C2A),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.location_on, color: Color(0xFFFFCC00), size: 20),
                const SizedBox(width: 8),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'UDA NEAR YOU',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Find your nearest UDA office',
                        style: TextStyle(color: Colors.white70, fontSize: 11),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Only open on web
                    if (kIsWeb) {
                      WebUtils.openMapUrl('https://www.google.com/maps');
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFCC00),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Open Map',
                          style: TextStyle(
                            color: Color(0xFF1A5C2A),
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.open_in_new, color: Color(0xFF1A5C2A), size: 14),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Embedded Google Map - only works on web
          ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
            child: SizedBox(
              height: 220,
              width: double.infinity,
              child: kIsWeb 
                  ? const HtmlElementView(viewType: 'google-maps-uda')
                  : const SizedBox.shrink(),
            ),
          ),
        ],
      ),
    );
  }

  // ========== ROADMAP AND CONTACT US ==========
  Widget _buildRoadmapAndContact() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                print('🗺️ Political Roadmap tapped');
              },
              child: Container(
                height: 100,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A5C2A),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(Icons.map, color: Color(0xFFFFCC00)),
                    Text(
                      'POLITICAL ROADMAP',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '2024 - 2027 Plan',
                      style: TextStyle(color: Colors.white70, fontSize: 10),
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
                    builder: (context) => const ContactScreen(),
                  ),
                );
              },
              child: Container(
                height: 100,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFCC00),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(Icons.phone, color: Color(0xFF1A5C2A)),
                    Text(
                      'CONTACT US',
                      style: TextStyle(
                        color: Color(0xFF1A5C2A),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Call +254 720 000 000',
                      style: TextStyle(color: Color(0xFF1A5C2A), fontSize: 10),
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

  // ========== FLOATING BUTTONS ==========
  Widget _buildFloatingButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Support Center Button on the Left
          FloatingActionButton(
            heroTag: 'support',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ContactScreen(),
                ),
              );
            },
            backgroundColor: const Color(0xFF1A5C2A),
            child: const Icon(Icons.support_agent, color: Colors.white),
          ),
          // Chat Button on the Right
          FloatingActionButton(
            heroTag: 'chat',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AskPresidentScreen(),
                ),
              );
            },
            backgroundColor: const Color(0xFFFFCC00),
            child: const Icon(Icons.chat, color: Color(0xFF1A5C2A)),
          ),
        ],
      ),
    );
  }

  // ========== FOOTER ==========
  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFFFCC00), width: 3),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(35),
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Text(
                        'UDA',
                        style: TextStyle(
                          color: Color(0xFF1A5C2A),
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'UNITED DEMOCRATIC ALLIANCE',
            style: TextStyle(
              color: Color(0xFF1A5C2A),
              fontWeight: FontWeight.w900,
              fontSize: 14,
              letterSpacing: 1,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          const Text(
            'KAZI NI KAZI',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            '© 2024 UDA Party. All Rights Reserved.',
            style: TextStyle(color: Colors.grey, fontSize: 10),
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
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 16),
              // Fixed: Wrapped ListTiles in Material to fix decoration conflict
              Material(
                color: Colors.transparent,
                child: ListTile(
                  leading: const Icon(Icons.person, color: Color(0xFF1A5C2A)),
                  title: const Text('Profile'),
                  onTap: () {
                    Navigator.pop(context);
                    print('👤 Profile tapped');
                  },
                ),
              ),
              Material(
                color: Colors.transparent,
                child: ListTile(
                  leading: const Icon(Icons.settings, color: Color(0xFF1A5C2A)),
                  title: const Text('Settings'),
                  onTap: () {
                    Navigator.pop(context);
                    print('⚙️ Settings tapped');
                  },
                ),
              ),
              Material(
                color: Colors.transparent,
                child: ListTile(
                  leading: const Icon(Icons.help, color: Color(0xFF1A5C2A)),
                  title: const Text('Help & Support'),
                  onTap: () {
                    Navigator.pop(context);
                    print('❓ Help & Support tapped');
                  },
                ),
              ),
              Material(
                color: Colors.transparent,
                child: ListTile(
                  leading: const Icon(Icons.info, color: Color(0xFF1A5C2A)),
                  title: const Text('About UDA'),
                  onTap: () {
                    Navigator.pop(context);
                    print('ℹ️ About UDA tapped');
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}