// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
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
import 'achievements_details.dart';
import 'videos_screen.dart';
import 'president_profile.dart';
import 'general_secretary.dart';
import 'executive_committe.dart';
import 'rdcs_and_drdcs.dart';
import 'uda_leadears.dart';
import 'uda_candidates.dart';

class UDAHomeScreen extends StatefulWidget {
  const UDAHomeScreen({super.key});

  @override
  State<UDAHomeScreen> createState() => _UDAHomeScreenState();
}

class _UDAHomeScreenState extends State<UDAHomeScreen> {
  int _currentImageIndex = 0;
  final List<String> _carouselImages = [
    'assets/images/main.PNG',
    'assets/images/main2.PNG',
    'assets/images/Ruto.png',
  ];
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
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
                  // FULL WIDTH Carousel Card (no margins)
                  _buildCarouselCard(),
                  const SizedBox(height: 16),

                  _buildUDAElectsSection(),
                  const SizedBox(height: 16),

                  // FULL WIDTH Feature Bar (touches edges)
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

                  // CENTERED Footer
                  _buildFooter(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _buildFloatingButtons(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  // ========== HEADER ==========
  Widget _buildHeader(BuildContext context) {
    return Container(
      color: const Color(0xFFFFCC00),
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 12),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF1A5C2A), width: 2),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
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
                        fontSize: 12,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 5),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                  color: Colors.black87,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              print('🌐 Language selection tapped');
            },
            child: const Icon(
              Icons.language,
              color: Color(0xFF1A5C2A),
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              print('👤 Profile tapped');
            },
            child: const Icon(
              Icons.person_outline,
              color: Color(0xFF1A5C2A),
              size: 28,
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () {
              print('⋮ Menu tapped');
              _showMenuDialog(context);
            },
            child: const Icon(
              Icons.more_vert,
              color: Color(0xFF1A5C2A),
              size: 28,
            ),
          ),
        ],
      ),
    );
  }

  // ========== FULL WIDTH CAROUSEL CARD ==========
  Widget _buildCarouselCard() {
    return Container(
      height: 200,
      width: double.infinity, // Full width
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
          // Carousel Image (horizontal sliding PageView)
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
          // Dark overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
              ),
            ),
          ),
          // Carousel Indicators
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
          // Bottom: Join UDA and Fundrise Buttons
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
    final elects = [
      {
        'name': 'William Ruto',
        'position': 'President',
        'color': 0xFF1A5C2A,
        'constituency': 'National',
        'county': 'KENYA',
        'bio':
            'H.E Dr. William Ruto is the President of Kenya and the Party Leader of UDA. He is committed to transforming Kenya through the Bottom-Up Economic Transformation Agenda.',
        'email': 'william.ruto@uda.go.ke',
        'phone': '+254 700 000 000',
        'office': 'State House, Nairobi',
      },
      {
        'name': 'H.E Pro.Kithure Kindiki',
        'position': 'Deputy President',
        'color': 0xFFFFCC00,
        'constituency': 'National',
        'county': 'KENYA',
        'bio':
            'H.E Pro.Kithure Kindikiis the Deputy President of Kenya. He is a dedicated leader focused on economic empowerment and grassroots development.',
        'email': 'kithure.kindiki@uda.go.ke',
        'phone': '+254 700 000 001',
        'office': 'State House, Nairobi',
      },
      {
        'name': 'H.E Issa Timamy',
        'position': 'Governor, Lamu County',
        'color': 0xFF1A5C2A,
        'constituency': 'National',
        'county': 'KENYA',
        'bio':
            'H.E Issa Timamy is the Governor of Lamu County. He is committed to the development and welfare of his constituents.',
        'email': 'issa.timamy@uda.go.ke',
        'phone': '+254 700 000 002',
        'office': 'Nairobi, Kenya',
      },
      {
        'name': 'H.E Cecily Mbarire',
        'position': 'Governor, Embu County',
        'color': 0xFFFFCC00,
        'constituency': 'National',
        'county': 'KENYA',
        'bio':
            'H.E Cecily Mbarire is the Governor of Embu County. She is dedicated to the development and welfare of her constituents.',
        'email': 'cecily.mbarire@uda.go.ke',
        'phone': '+254 700 000 003',
        'office': 'Nairobi, Kenya',
      },
      {
        'name': 'Mr. Kelvin Lunani',
        'position': 'DEPUTY CHAIRPERSON',
        'color': 0xFFFFCC00,
        'constituency': 'National',
        'county': 'KENYA',
        'bio':
            'Mr. Kelvin Lunani is the Deputy Chairperson of UDA. He is committed to the development and welfare of his constituents.',
        'email': 'kelvin.lunani@uda.go.ke',
        'phone': '+254 700 000 004',
        'office': 'Nairobi, Kenya',
      },
      {
        'name': 'Hon. Sen. Hassan Omar',
        'position': 'SECRETARY GENERAL,MP EALA',
        'color': 0xFFFFCC00,
        'constituency': 'National',
        'county': 'KENYA',
        'bio':
            'Hon. Sen. Hassan Omar is the Secretary General of UDA. He is committed to the development and welfare of his constituents.',
        'email': 'hassan.omar@uda.go.ke',
        'phone': '+254 700 000 005',
        'office': 'Nairobi, Kenya',
      },
      {
        'name': 'Hon. Omboko Milemba',
        'position': 'DEPUTY SECRETARY GENERAL,MP Emuhaya Constituency',
        'color': 0xFFFFCC00,
        'constituency': 'National',
        'county': 'KENYA',
        'bio':
            'Hon. Omboko Milemba is the Deputy Secretary General of UDA. He is committed to the development and welfare of his constituents.',
        'email': 'omboko.milemba@uda.go.ke',
        'phone': '+254 700 000 006',
        'office': 'Nairobi, Kenya',
      },
      {
        'name': 'Hon. Japheth Nyakundi',
        'position': 'NATIONAL TREASURER,MP Kitutu Chache North Constituency',
        'color': 0xFFFFCC00,
        'constituency': 'National',
        'county': 'KENYA',
        'bio':
            'Hon. Japheth Nyakundi is the National Treasurer of UDA. He is committed to the development and welfare of his constituents.',
        'email': 'japheth.nyakundi@uda.go.ke',
        'phone': '+254 700 000 007',
        'office': 'Nairobi, Kenya',
      },
      {
        'name': 'Mr. Nicodemus Bore',
        'position': 'EXECUTIVE DIRECTOR',
        'color': 0xFFFFCC00,
        'constituency': 'National',
        'county': 'KENYA',
        'bio':
            'Mr. Nicodemus Bore is the Executive Director of UDA. He is committed to the development and welfare of his constituents.',
        'email': 'nicodemus.bore@uda.go.ke',
        'phone': '+254 700 000 008',
        'office': 'Nairobi, Kenya',
      },
    ];

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
                      builder: (context) => const AllElectsScreen(),
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
                          child: Builder(
                            builder: (context) {
                              final imagePath =
                                  (elect['image'] as String?) ??
                                  findImage(elect['name'] as String);
                              if (imagePath != null) {
                                return Image.asset(
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
                                );
                              }

                              return Container(
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
                              );
                            },
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
                      ),
                      Text(
                        elect['position'] as String,
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
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

  // ========== FULL WIDTH FEATURE BAR (Scrollable, touches edges) ==========
  Widget _buildFeatureBar() {
    final features = [
      {'title': 'HOME', 'icon': Icons.home},
      {'title': 'ACHIEVEMENTS', 'icon': Icons.emoji_events},
      {'title': 'EVENTS', 'icon': Icons.event},
      {'title': 'LIVE TV', 'icon': Icons.live_tv},
      {'title': 'GALLERY', 'icon': Icons.photo_library},
      {'title': 'VIDEOS', 'icon': Icons.photo_library},
      {'title': 'NEWS', 'icon': Icons.article},
      {'title': 'ABOUT UDA', 'icon': Icons.info},
      {'title': 'CONTACT', 'icon': Icons.contact_mail},
    ];

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 8),
      width: double.infinity, // Full width
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: features.map((feature) {
            return GestureDetector(
              onTap: () {
                _navigateToFeature(context, feature['title'] as String);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    Icon(
                      feature['icon'] as IconData,
                      color: const Color(0xFF1A5C2A),
                      size: 24,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      feature['title'] as String,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A5C2A),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  // Navigation helper method
  void _navigateToFeature(BuildContext context, String feature) {
    switch (feature) {
      case 'HOME':
        // Already on home screen
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
        'title': 'Roadmap for grassroots elections',
        'date': 'Wed, 10 Aug 2024',
        'color': 0xFFFFCC00,
      },
      {
        'title': 'National Delegates Convention',
        'date': 'Mon, 15 Aug 2024',
        'color': 0xFF1A5C2A,
      },
      {
        'title': 'UDA Party Registration Drive',
        'date': 'Fri, 20 Aug 2024',
        'color': 0xFFFFCC00,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'LATEST UPDATES',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1A5C2A),
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: updates.length,
            itemBuilder: (context, index) {
              final update = updates[index];
              return GestureDetector(
                onTap: () {
                  print('📰 Update ${index + 1} tapped');
                },
                child: Container(
                  width: 280,
                  margin: const EdgeInsets.only(right: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Color(update['color'] as int),
                      width: 2,
                    ),
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
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.article,
                            color: Color(update['color'] as int),
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              update['title'] as String,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            size: 12,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            update['date'] as String,
                            style: const TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
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
                border: Border.all(color: Color(0xFFFFCC00), width: 3),
                image: DecorationImage(
                  image: NetworkImage(
                    'https://via.placeholder.com/150/1A5C2A/FFCC00?text=W.R',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: const Icon(Icons.person, size: 40, color: Colors.grey),
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
        'icon': Icons.people,
        'color': 0xFF1A5C2A,
        'screen': const ExecutiveCommitteeScreen(),
      },
      {
        'title': 'General Secretary',
        'icon': Icons.how_to_reg,
        'color': 0xFFFFCC00,
        'screen': const GeneralSecretaryProfileScreen(),
      },
      {
        'title': 'Party Manifesto',
        'icon': Icons.description,
        'color': 0xFF1A5C2A,
        'screen': const AboutUDAScreen(),
      },
      {
        'title': 'UDA Leaders',
        'icon': Icons.gavel,
        'color': 0xFFFFCC00,
        'screen': const UDALeadersScreen(),
      },
      {
        'title': 'RDCS & DRDCS',
        'icon': Icons.account_balance,
        'color': 0xFF1A5C2A,
        'screen': const RDCSDRDCSScreen(),
      },
      {
        'title': 'UDA Candidates',
        'icon': Icons.verified_user,
        'color': 0xFFFFCC00,
        'screen': const UDACandidatesScreen(),
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
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Color(card['color'] as int),
                  width: 2,
                ),
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
                  Icon(
                    card['icon'] as IconData,
                    color: Color(card['color'] as int),
                    size: 36,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    card['title'] as String,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ========== UDA NEAR YOU ==========
  Widget _buildUDANearYou() {
    return GestureDetector(
      onTap: () {
        print('📍 UDA Near You map tapped');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[300],
              ),
              child: const Icon(Icons.map, size: 80, color: Colors.grey),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
                ),
              ),
            ),
            const Positioned(
              bottom: 16,
              left: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'UDA NEAR YOU',
                    style: TextStyle(
                      color: Color(0xFFFFCC00),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Find your nearest UDA office',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
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
                print('📞 Contact Us tapped');
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          heroTag: 'support',
          onPressed: () {
            print('🆘 Support Center tapped');
          },
          backgroundColor: const Color(0xFF1A5C2A),
          child: const Icon(Icons.support_agent, color: Colors.white),
        ),
        const SizedBox(height: 12),
        FloatingActionButton(
          heroTag: 'chat',
          onPressed: () {
            print('💬 Chat tapped');
          },
          backgroundColor: const Color(0xFFFFCC00),
          child: const Icon(Icons.chat, color: Color(0xFF1A5C2A)),
        ),
      ],
    );
  }

  // ========== CENTERED FOOTER ==========
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
              ListTile(
                leading: const Icon(Icons.person, color: Color(0xFF1A5C2A)),
                title: const Text('Profile'),
                onTap: () {
                  Navigator.pop(context);
                  print('👤 Profile tapped');
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings, color: Color(0xFF1A5C2A)),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                  print('⚙️ Settings tapped');
                },
              ),
              ListTile(
                leading: const Icon(Icons.help, color: Color(0xFF1A5C2A)),
                title: const Text('Help & Support'),
                onTap: () {
                  Navigator.pop(context);
                  print('❓ Help & Support tapped');
                },
              ),
              ListTile(
                leading: const Icon(Icons.info, color: Color(0xFF1A5C2A)),
                title: const Text('About UDA'),
                onTap: () {
                  Navigator.pop(context);
                  print('ℹ️ About UDA tapped');
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
