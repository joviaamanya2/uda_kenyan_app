// lib/screens/community/community_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:share_plus/share_plus.dart';
import 'community_groups_screen.dart';
import 'media_team_screen.dart';

/// Widget that plays a locally-picked or network video, working on both
/// native platforms (File) and web (blob/network URL) since XFile.path is a
/// blob URL on web and a real file path elsewhere.
class _VideoPreview extends StatefulWidget {
  final String path;

  const _VideoPreview({required this.path});

  @override
  State<_VideoPreview> createState() => _VideoPreviewState();
}

class _VideoPreviewState extends State<_VideoPreview> {
  late final VideoPlayerController _controller;
  bool _initialized = false;
  bool _failed = false;

  @override
  void initState() {
    super.initState();
    _controller = kIsWeb
        ? VideoPlayerController.networkUrl(Uri.parse(widget.path))
        : VideoPlayerController.file(File(widget.path));
    _controller
        .initialize()
        .then((_) {
          if (mounted) setState(() => _initialized = true);
        })
        .catchError((_) {
          if (mounted) setState(() => _failed = true);
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlay() {
    setState(() {
      _controller.value.isPlaying ? _controller.pause() : _controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_failed) {
      return Container(
        height: 200,
        color: Colors.grey[200],
        child: const Center(
          child: Icon(Icons.videocam_off, color: Colors.grey, size: 40),
        ),
      );
    }
    if (!_initialized) {
      return Container(
        height: 200,
        color: Colors.black12,
        child: const Center(
          child: CircularProgressIndicator(color: Color(0xFF1A5C2A)),
        ),
      );
    }
    final aspectRatio = _controller.value.aspectRatio == 0
        ? 16 / 9
        : _controller.value.aspectRatio;
    return GestureDetector(
      onTap: _togglePlay,
      child: AspectRatio(
        aspectRatio: aspectRatio,
        child: Stack(
          alignment: Alignment.center,
          fit: StackFit.expand,
          children: [
            VideoPlayer(_controller),
            AnimatedOpacity(
              opacity: _controller.value.isPlaying ? 0 : 1,
              duration: const Duration(milliseconds: 200),
              child: Container(
                color: Colors.black26,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: const BoxDecoration(
                      color: Colors.black45,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 34,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Renders a locally-picked image the same way on web (blob URL via
/// Image.network) and native (dart:io File via Image.file).
class _PickedImage extends StatelessWidget {
  final String path;
  final double height;

  const _PickedImage({required this.path, this.height = 200});

  @override
  Widget build(BuildContext context) {
    final errorBuilder =
        (BuildContext context, Object error, StackTrace? stackTrace) =>
            Container(
              height: height,
              color: Colors.grey[200],
              child: const Center(
                child: Icon(
                  Icons.image_not_supported,
                  color: Colors.grey,
                  size: 40,
                ),
              ),
            );
    if (kIsWeb) {
      return Image.network(
        path,
        width: double.infinity,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: errorBuilder,
      );
    }
    return Image.file(
      File(path),
      width: double.infinity,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: errorBuilder,
    );
  }
}

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> _posts = [
    {
      'id': 1,
      'username': 'Hon. Raila Odinga',
      'date': 'Wed, 12 Aug 2026',
      'content':
          'Baba is back! The journey to transform Kenya continues. Together we shall build the Kenya we deserve. #Baba2026 #AzimioLaUmoja',
      'likes': 56,
      'comments': 23,
      'isLiked': false,
      'imageUrl': null,
      'isVerified': true,
    },
    {
      'id': 2,
      'username': 'Martha Karua',
      'date': 'Wed, 12 Aug 2026',
      'content':
          'Justice and accountability for all Kenyans. The fight against corruption continues unabated. #TeamKenya #Integrity',
      'likes': 42,
      'comments': 15,
      'isLiked': false,
      'imageUrl': null,
      'isVerified': true,
    },
    {
      'id': 3,
      'username': 'Hon. Kalonzo Musyoka',
      'date': 'Wed, 12 Aug 2026',
      'content':
          'Unity is our strength. From Mombasa to Malaba, Turkana to Taita Taveta, we stand together for a better Kenya!',
      'likes': 28,
      'comments': 9,
      'isLiked': false,
      'imageUrl': null,
      'isVerified': true,
    },
    {
      'id': 4,
      'username': 'Muthoni Wanjiru',
      'date': 'Tue, 11 Aug 2026',
      'content':
          'Join us this Saturday at Uhuru Park for the Azimio mega rally. Let\'s show our strength in numbers! Karibu Sote!',
      'likes': 67,
      'comments': 31,
      'isLiked': false,
      'imageUrl': null,
      'isVerified': true,
      'isAnnouncement': true,
    },
    {
      'id': 5,
      'username': 'Omar Boraafya',
      'date': 'Tue, 11 Aug 2026',
      'content':
          'We need to mobilize more youth to join the movement. Our future is in our hands. Every vote counts! #YouthForChange',
      'likes': 34,
      'comments': 12,
      'isLiked': false,
      'imageUrl': null,
      'isVerified': false,
    },
    {
      'id': 6,
      'username': 'Dr. Winnie Odinga',
      'date': 'Mon, 10 Aug 2026',
      'content':
          'Azimio is committed to building a Kenya where every citizen has access to quality education, healthcare, and economic opportunities. #KaziYaWananchi',
      'likes': 45,
      'comments': 18,
      'isLiked': false,
      'imageUrl': null,
      'isVerified': true,
    },
    {
      'id': 7,
      'username': 'Junet Mohammed',
      'date': 'Mon, 10 Aug 2026',
      'content':
          'The Azimio government will prioritize the cost of living crisis. We shall lower Unga prices and create jobs for our youth! #LowerCostOfLiving',
      'likes': 51,
      'comments': 19,
      'isLiked': false,
      'imageUrl': null,
      'isVerified': true,
    },
  ];

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    for (final post in _posts) {
      post.putIfAbsent('commentList', () => <Map<String, dynamic>>[]);
      post.putIfAbsent('shares', () => 0);
      post.putIfAbsent('mediaPath', () => null);
      post.putIfAbsent('mediaType', () => null);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
                  'A',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Azimio Community',
              style: TextStyle(
                color: Color(0xFF1A5C2A),
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        shape: Border(bottom: BorderSide(color: Colors.grey.shade200)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF1A5C2A)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              color: Color(0xFF1A5C2A),
            ),
            onPressed: () {
              print('🔔 Notifications');
            },
          ),
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF1A5C2A)),
            onPressed: () {
              print('🔍 Search community');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Trending banner
          Container(
            color: const Color(0xFF1A5C2A),
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Row(
              children: [
                const Icon(
                  Icons.trending_up,
                  color: Color(0xFFFFD700),
                  size: 18,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '🔥 Trending: Azimio Mega Rally this Saturday at Uhuru Park!',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD700),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'NEW',
                    style: TextStyle(
                      color: Color(0xFF1A5C2A),
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Main Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Community Tab
                _buildCommunityTab(),

                // Azimio Groups Tab
                const CommunityGroupsScreen(),

                // Media Team Tab
                const MediaTeamScreen(),
              ],
            ),
          ),

          // Bottom Navigation Tabs with padding for FAB
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, -3),
                ),
              ],
            ),
            child: SafeArea(
              child: TabBar(
                controller: _tabController,
                labelColor: const Color(0xFF1A5C2A),
                unselectedLabelColor: Colors.grey,
                indicatorColor: const Color(0xFFFFD700),
                indicatorWeight: 3,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                ),
                tabs: const [
                  Tab(icon: Icon(Icons.people), text: 'Community'),
                  Tab(icon: Icon(Icons.group), text: 'Azimio Groups'),
                  Tab(icon: Icon(Icons.mic), text: 'Media Team'),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: _tabController.index == 0
          ? Padding(
              padding: const EdgeInsets.only(bottom: 80.0),
              child: FloatingActionButton.extended(
                onPressed: () {
                  _showCreatePostDialog(context);
                },
                backgroundColor: const Color(0xFFFFD700),
                foregroundColor: const Color(0xFF1A5C2A),
                elevation: 6,
                icon: const Icon(Icons.edit_note, size: 22),
                label: const Text(
                  'Post',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildCommunityTab() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(12),
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        return _buildPostCard(_posts[index]);
      },
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
        border: post['isAnnouncement'] == true
            ? Border.all(color: const Color(0xFFFFD700), width: 2)
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header - Username and date
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xFF1A5C2A),
                child: Text(
                  post['username'][0].toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          post['username'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xFF1A5C2A),
                          ),
                        ),
                        if (post['isVerified'] == true) ...[
                          const SizedBox(width: 4),
                          const Icon(
                            Icons.verified,
                            color: Color(0xFFFFD700),
                            size: 16,
                          ),
                        ],
                      ],
                    ),
                    Text(
                      post['date'],
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              if (post['isAnnouncement'] == true)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFD700),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text(
                    'ANNOUNCEMENT',
                    style: TextStyle(
                      color: Color(0xFF1A5C2A),
                      fontWeight: FontWeight.bold,
                      fontSize: 9,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),

          // Content
          Text(
            post['content'],
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Colors.black87,
            ),
          ),

          // Image or video if attached
          if (post['imageUrl'] != null || post['mediaPath'] != null)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: post['mediaType'] == 'video' && post['mediaPath'] != null
                    ? _VideoPreview(path: post['mediaPath'] as String)
                    : post['mediaPath'] != null
                    ? _PickedImage(path: post['mediaPath'] as String)
                    : Image.network(
                        post['imageUrl'],
                        width: double.infinity,
                        height: 200,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 200,
                            color: Colors.grey[200],
                            child: const Center(
                              child: Icon(
                                Icons.image_not_supported,
                                color: Colors.grey,
                                size: 50,
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),

          const SizedBox(height: 12),

          // Stats - Like, Comment, Share counts
          Row(
            children: [
              Row(
                children: [
                  Icon(
                    Icons.thumb_up_alt_outlined,
                    color: post['isLiked']
                        ? const Color(0xFF1A5C2A)
                        : Colors.grey[600],
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${post['likes']}',
                    style: TextStyle(
                      fontSize: 12,
                      color: post['isLiked']
                          ? const Color(0xFF1A5C2A)
                          : Colors.grey[600],
                      fontWeight: post['isLiked']
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Row(
                children: [
                  Icon(
                    Icons.comment_outlined,
                    color: Colors.grey[600],
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${post['comments']} Comments',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Row(
                children: [
                  Icon(
                    Icons.share_outlined,
                    color: Colors.grey[600],
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${post['shares'] ?? 0} Shares',
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Action Buttons - Like, Comment, Share
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.grey.shade200),
                bottom: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(
                  icon: post['isLiked']
                      ? Icons.thumb_up
                      : Icons.thumb_up_alt_outlined,
                  label: 'Like',
                  color: post['isLiked']
                      ? const Color(0xFF1A5C2A)
                      : Colors.grey[600]!,
                  onTap: () {
                    setState(() {
                      _toggleLike(post['id']);
                    });
                  },
                ),
                _buildActionButton(
                  icon: Icons.comment_outlined,
                  label: 'Comment',
                  color: Colors.grey[600]!,
                  onTap: () {
                    _showCommentDialog(context, post);
                  },
                ),
                _buildActionButton(
                  icon: Icons.share_outlined,
                  label: 'Share',
                  color: Colors.grey[600]!,
                  onTap: () => _sharePost(post),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _toggleLike(int postId) {
    setState(() {
      final post = _posts.firstWhere((p) => p['id'] == postId);
      if (post['isLiked']) {
        post['likes'] = post['likes'] - 1;
        post['isLiked'] = false;
      } else {
        post['likes'] = post['likes'] + 1;
        post['isLiked'] = true;
      }
    });
  }

  Future<void> _sharePost(Map<String, dynamic> post) async {
    final text =
        '${post['username']}: ${post['content']}\n\nShared from the UDA Community App';
    try {
      await SharePlus.instance.share(ShareParams(text: text));
      if (!mounted) return;
      setState(() {
        post['shares'] = (post['shares'] as int? ?? 0) + 1;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not share: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _showCreatePostDialog(BuildContext context) {
    final TextEditingController postController = TextEditingController();
    String? mediaPath;
    String? mediaType; // 'image' | 'video'

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) {
          Future<void> pickMedia(String type) async {
            try {
              final XFile? picked = type == 'video'
                  ? await _picker.pickVideo(source: ImageSource.gallery)
                  : await _picker.pickImage(
                      source: ImageSource.gallery,
                      maxWidth: 1280,
                      maxHeight: 1280,
                      imageQuality: 85,
                    );
              if (picked != null) {
                setState(() {
                  mediaPath = picked.path;
                  mediaType = type;
                });
              }
            } catch (e) {
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Error picking $type: $e'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }

          return AlertDialog(
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
                      'A',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Create Post',
                  style: TextStyle(color: Color(0xFF1A5C2A)),
                ),
              ],
            ),
            content: SizedBox(
              width: 360,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: postController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'What\'s on your mind about Azimio?',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Colors.grey[50],
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Media preview if selected
                  if (mediaPath != null)
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: mediaType == 'video'
                              ? _VideoPreview(path: mediaPath!)
                              : _PickedImage(path: mediaPath!, height: 160),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                mediaPath = null;
                                mediaType = null;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  if (mediaPath != null) const SizedBox(height: 8),

                  // Photo / Video picker buttons
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => pickMedia('image'),
                          icon: const Icon(Icons.image_outlined, size: 18),
                          label: const Text('Photo'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF1A5C2A),
                            side: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () => pickMedia('video'),
                          icon: const Icon(
                            Icons.videocam_outlined,
                            size: 18,
                          ),
                          label: const Text('Video'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: const Color(0xFF1A5C2A),
                            side: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (postController.text.isNotEmpty || mediaPath != null) {
                    this.setState(() {
                      _posts.insert(0, {
                        'id': DateTime.now().millisecondsSinceEpoch,
                        'username': 'You',
                        'date': DateTime.now().toString().substring(0, 16),
                        'content': postController.text,
                        'likes': 0,
                        'comments': 0,
                        'commentList': <Map<String, dynamic>>[],
                        'shares': 0,
                        'isLiked': false,
                        'isVerified': false,
                        'isAnnouncement': false,
                        'mediaPath': mediaPath,
                        'mediaType': mediaType,
                        'imageUrl': null,
                      });
                    });
                    Navigator.pop(dialogContext);
                    ScaffoldMessenger.of(this.context).showSnackBar(
                      const SnackBar(
                        content: Text('Post created successfully! 🇰🇪'),
                        backgroundColor: Color(0xFF1A5C2A),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFD700),
                  foregroundColor: const Color(0xFF1A5C2A),
                ),
                child: const Text('Post'),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showCommentDialog(BuildContext context, Map<String, dynamic> post) {
    final TextEditingController commentController = TextEditingController();
    final commentList = post['commentList'] as List<Map<String, dynamic>>;

    showDialog(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setState) {
          void submitComment() {
            final text = commentController.text.trim();
            if (text.isEmpty) return;
            this.setState(() {
              commentList.add({
                'username': 'You',
                'text': text,
                'date': DateTime.now().toString().substring(0, 16),
              });
              post['comments'] = (post['comments'] as int) + 1;
            });
            setState(() {}); // refresh the dialog's own comment list
            commentController.clear();
          }

          return AlertDialog(
            title: Row(
              children: [
                Icon(Icons.comment, color: const Color(0xFF1A5C2A), size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Comments on ${post['username']}\'s post',
                    style: const TextStyle(
                      color: Color(0xFF1A5C2A),
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            content: SizedBox(
              width: 360,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[200]!),
                    ),
                    child: Text(
                      post['content'],
                      style: const TextStyle(fontSize: 13),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (commentList.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        'No comments yet. Be the first to comment.',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    )
                  else
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 220),
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: commentList.length,
                        separatorBuilder: (context, index) =>
                            const Divider(height: 16),
                        itemBuilder: (context, index) {
                          final comment = commentList[index];
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 14,
                                backgroundColor: const Color(0xFF1A5C2A),
                                child: Text(
                                  (comment['username'] as String)[0]
                                      .toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      comment['username'] as String,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Color(0xFF1A5C2A),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      comment['text'] as String,
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: commentController,
                          decoration: InputDecoration(
                            hintText: 'Write a comment...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            filled: true,
                            fillColor: Colors.grey[50],
                          ),
                          onSubmitted: (_) => submitComment(),
                        ),
                      ),
                      IconButton(
                        onPressed: submitComment,
                        icon: const Icon(
                          Icons.send,
                          color: Color(0xFF1A5C2A),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Close'),
              ),
            ],
          );
        },
      ),
    );
  }
}
