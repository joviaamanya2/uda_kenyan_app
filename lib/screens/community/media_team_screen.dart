// lib/screens/community/media_team_screen.dart
import 'package:flutter/material.dart';
import 'bloggers_screen.dart';
import 'tv_stations_screen.dart';
import 'radio_stations_screen.dart';

class MediaTeamScreen extends StatefulWidget {
  const MediaTeamScreen({super.key});

  @override
  State<MediaTeamScreen> createState() => _MediaTeamScreenState();
}

class _MediaTeamScreenState extends State<MediaTeamScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedCategory = 'All';

  final List<Map<String, dynamic>> _mediaItems = [
    {
      'id': 1,
      'name': 'NTV Uganda',
      'type': 'TV',
      'frequency': 'Channel 5',
      'tagline': 'Uganda\'s Leading News Channel',
      'color': Color(0xFFE74C3C),
      'isVerified': true,
      'followers': '2.5M',
      'isLive': true,
    },
    {
      'id': 2,
      'name': 'CBS FM',
      'type': 'Radio',
      'frequency': '88.8 FM',
      'tagline': 'Omukwano Gwaffe',
      'color': Color(0xFF1A5C2A),
      'isVerified': true,
      'followers': '1.8M',
      'isLive': true,
    },
    {
      'id': 3,
      'name': 'NBS Television',
      'type': 'TV',
      'frequency': 'Channel 3',
      'tagline': 'Uganda\'s Biggest Entertainment Station',
      'color': Color(0xFFF39C12),
      'isVerified': true,
      'followers': '3.2M',
      'isLive': false,
    },
    {
      'id': 4,
      'name': 'Sanyu FM',
      'type': 'Radio',
      'frequency': '98.6 FM',
      'tagline': 'The Voice of the People',
      'color': Color(0xFF27AE60),
      'isVerified': false,
      'followers': '1.2M',
      'isLive': true,
    },
    {
      'id': 5,
      'name': 'KBC Channel 1',
      'type': 'TV',
      'frequency': 'Channel 1',
      'tagline': 'Kenya Broadcasting Corporation',
      'color': Color(0xFF8E44AD),
      'isVerified': true,
      'followers': '4.1M',
      'isLive': true,
    },
    {
      'id': 6,
      'name': 'Capital FM',
      'type': 'Radio',
      'frequency': '91.3 FM',
      'tagline': 'Today\'s Hit Music',
      'color': Color(0xFFE67E22),
      'isVerified': false,
      'followers': '987K',
      'isLive': false,
    },
    {
      'id': 7,
      'name': 'Uganda Broadcasting Corporation',
      'type': 'TV',
      'frequency': 'Channel 1 & 2',
      'tagline': 'Uganda\'s National Broadcaster',
      'color': Color(0xFF2C3E50),
      'isVerified': true,
      'followers': '1.5M',
      'isLive': true,
    },
    {
      'id': 9,
      'name': 'Citizen TV Kenya',
      'type': 'TV',
      'frequency': 'Channel 2',
      'tagline': 'Inspiring a Nation',
      'color': Color(0xFF1A5C2A),
      'isVerified': true,
      'followers': '5.7M',
      'isLive': true,
    },
    {
      'id': 10,
      'name': 'Radio One',
      'type': 'Radio',
      'frequency': '90.1 FM',
      'tagline': 'Uganda\'s Most Trusted Radio',
      'color': Color(0xFF16A085),
      'isVerified': true,
      'followers': '2.3M',
      'isLive': true,
    },
    {
      'id': 11,
      'name': 'K24 TV Kenya',
      'type': 'TV',
      'frequency': 'Channel 4',
      'tagline': 'News You Can Trust',
      'color': Color(0xFF1A5C2A),
      'isVerified': false,
      'followers': '1.9M',
      'isLive': false,
    },
    {
      'id': 12,
      'name': 'Simba FM',
      'type': 'Radio',
      'frequency': '101.7 FM',
      'tagline': 'The King of the Jungle',
      'color': Color(0xFFE74C3C),
      'isVerified': false,
      'followers': '876K',
      'isLive': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        switch (_tabController.index) {
          case 0:
            _selectedCategory = 'All';
            break;
          case 1:
            _selectedCategory = 'TV';
            break;
          case 2:
            _selectedCategory = 'Radio';
            break;
          case 3:
            _selectedCategory = 'Bloggers';
            break;
        }
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> get _filteredMedia {
    if (_selectedCategory == 'All') {
      return _mediaItems;
    } else if (_selectedCategory == 'Bloggers') {
      return [];
    } else {
      return _mediaItems
          .where((item) => item['type'] == _selectedCategory)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              height: 32,
              width: 32,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF1A5C2A),
              ),
              child: const Center(
                child: Text(
                  'M',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'UDA Media Team',
              style: TextStyle(
                color: Color(0xFF1A5C2A),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF1A5C2A)),
            onPressed: () {
              _showSearchDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Stats Banner
          Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF1A5C2A),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('TV', 'TV Stations', '12'),
                _buildStatItem('Radio', 'Radio Stations', '8'),
                _buildStatItem('Blog', 'Bloggers', '15'),
                _buildStatItem('Live', 'Live Now', '6'),
              ],
            ),
          ),

          // Filter Tabs
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: TabBar(
              controller: _tabController,
              labelColor: const Color(0xFF1A5C2A),
              unselectedLabelColor: Colors.grey,
              indicatorColor: const Color(0xFFFFD700),
              indicatorWeight: 3,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
              unselectedLabelStyle: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 13,
              ),
              tabs: const [
                Tab(text: 'All'),
                Tab(text: 'TV'),
                Tab(text: 'Radio'),
                Tab(text: 'Bloggers'),
              ],
            ),
          ),

          // Media List
          Expanded(
            child: _selectedCategory == 'Bloggers'
                ? const BloggersScreen()
                : ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(12),
                    itemCount: _filteredMedia.length,
                    itemBuilder: (context, index) {
                      return _buildMediaCard(_filteredMedia[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String icon, String label, String count) {
    return Column(
      children: [
        Text(
          icon,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          count,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildMediaCard(Map<String, dynamic> media) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Media Icon
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: media['color'] as Color,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Text(
                media['name'][0],
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 14),

          // Media Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Text(
                            media['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(0xFF1A5C2A),
                            ),
                          ),
                          if (media['isVerified'] == true) ...[
                            const SizedBox(width: 4),
                            const Icon(
                              Icons.verified,
                              color: Color(0xFFFFD700),
                              size: 16,
                            ),
                          ],
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: media['type'] == 'TV'
                            ? Colors.blue.withOpacity(0.1)
                            : Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        media['type'],
                        style: TextStyle(
                          color: media['type'] == 'TV'
                              ? Colors.blue[800]
                              : Colors.green[800],
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.wifi_tethering,
                      color: Colors.grey[400],
                      size: 12,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      media['frequency'],
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      Icons.people_outline,
                      color: Colors.grey[400],
                      size: 12,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      media['followers'],
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  media['tagline'],
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey[500],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),

          // Live Badge & Action
          Column(
            children: [
              if (media['isLive'] == true)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text(
                        'LIVE',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                )
              else
                const SizedBox(height: 20),
              const SizedBox(height: 8),
              Icon(
                Icons.play_circle_outline,
                color: const Color(0xFFFFD700),
                size: 28,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Search Media',
          style: TextStyle(color: Color(0xFF1A5C2A)),
        ),
        content: TextField(
          decoration: InputDecoration(
            hintText: 'Search by name or type...',
            prefixIcon: const Icon(Icons.search, color: Color(0xFF1A5C2A)),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onChanged: (value) {
            // Implement search functionality
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFD700),
              foregroundColor: const Color(0xFF1A5C2A),
            ),
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }
}
