// lib/screens/community/community_feed_tab.dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:share_plus/share_plus.dart';

import '../../services/api_service.dart';
import 'video_player_screen.dart';
import '../../theme/theme_ext.dart';

class CommunityFeedTab extends StatefulWidget {
  const CommunityFeedTab({super.key});

  @override
  State<CommunityFeedTab> createState() => _CommunityFeedTabState();
}

class _CommunityFeedTabState extends State<CommunityFeedTab> {
  static const _green = Color(0xFF1A5C2A);
  static const _yellow = Color(0xFFFFCC00);

  List<Map<String, dynamic>> _posts = [];
  bool _loading = true;
  String? _error;

  bool get _signedIn => ApiService.instance.isLoggedIn;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = _posts.isEmpty;
      _error = null;
    });
    try {
      final posts = await ApiService.instance.getPosts();
      if (mounted) setState(() => _posts = posts);
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _requireSignIn() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please sign in to join the conversation.')),
    );
  }

  Future<void> _toggleLike(Map<String, dynamic> post) async {
    if (!_signedIn) return _requireSignIn();
    final id = post['id'] as int;
    final wasLiked = post['liked'] == true;
    setState(() {
      post['liked'] = !wasLiked;
      post['likes_count'] =
          (post['likes_count'] as int? ?? 0) + (wasLiked ? -1 : 1);
    });
    try {
      final res = await ApiService.instance.togglePostLike(id);
      if (mounted) {
        setState(() {
          post['liked'] = res['liked'] == true;
          post['likes_count'] = res['likes_count'] ?? post['likes_count'];
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          post['liked'] = wasLiked;
          post['likes_count'] =
              (post['likes_count'] as int? ?? 0) + (wasLiked ? 1 : -1);
        });
      }
    }
  }

  Future<void> _share(Map<String, dynamic> post) async {
    final author = (post['author'] as Map?)?['name'] ?? 'A UDA member';
    try {
      await SharePlus.instance.share(
        ShareParams(
          text: '$author on the UDA Community:\n\n${post['content']}',
        ),
      );
      await ApiService.instance.sharePost(post['id'] as int);
      if (mounted) {
        setState(
          () => post['shares_count'] = (post['shares_count'] as int? ?? 0) + 1,
        );
      }
    } catch (_) {}
  }

  Future<void> _delete(Map<String, dynamic> post) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (c) => AlertDialog(
        title: const Text('Delete post?'),
        content: const Text('This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(c, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
    if (ok != true) return;
    try {
      await ApiService.instance.deletePost(post['id'] as int);
      if (mounted) setState(() => _posts.remove(post));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  Future<void> _openComposer() async {
    if (!_signedIn) return _requireSignIn();
    final created = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => const _ComposerSheet(),
    );
    if (created == true) _load();
  }

  Future<void> _openComments(Map<String, dynamic> post) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: context.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => _CommentsSheet(
        post: post,
        signedIn: _signedIn,
        onCountChanged: (n) => setState(() => post['comments_count'] = n),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openComposer,
        backgroundColor: _yellow,
        foregroundColor: _green,
        icon: const Icon(Icons.edit),
        label: const Text(
          'Post',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: RefreshIndicator(
        color: _green,
        onRefresh: _load,
        child: _loading
            ? const Center(child: CircularProgressIndicator(color: _green))
            : _error != null && _posts.isEmpty
            ? _errorState()
            : _posts.isEmpty
            ? _emptyState()
            : ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 88),
                itemCount: _posts.length,
                itemBuilder: (context, i) => _postCard(_posts[i]),
              ),
      ),
    );
  }

  Widget _errorState() => ListView(
    children: [
      const SizedBox(height: 120),
      Icon(Icons.wifi_off, size: 44, color: Colors.grey[400]),
      const SizedBox(height: 10),
      Center(
        child: Text(_error!, style: TextStyle(color: context.textMuted)),
      ),
      const SizedBox(height: 12),
      Center(
        child: OutlinedButton(onPressed: _load, child: const Text('Retry')),
      ),
    ],
  );

  Widget _emptyState() => ListView(
    children: [
      const SizedBox(height: 120),
      Icon(Icons.forum_outlined, size: 48, color: Colors.grey[400]),
      const SizedBox(height: 10),
      const Center(
        child: Text(
          'No posts yet. Be the first to share something.',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    ],
  );

  Widget _postCard(Map<String, dynamic> post) {
    final author = (post['author'] as Map?) ?? const {};
    final name = (author['name'] ?? 'UDA Member').toString();
    final avatar = (author['avatar_path'] ?? '').toString();
    final county = (author['county'] ?? '').toString();
    final media = (post['image_path'] ?? '').toString();
    final isVideo = post['media_type'] == 'video';
    final liked = post['liked'] == true;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.hairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 14, 6, 8),
            child: Row(
              children: [
                _avatar(name, avatar),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: _green,
                        ),
                      ),
                      Text(
                        [
                          if (county.isNotEmpty) county,
                          _timeAgo(post['created_at']),
                        ].join(' · '),
                        style: TextStyle(
                          fontSize: 11,
                          color: context.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                if (post['is_mine'] == true)
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.more_horiz, color: Colors.grey),
                    onSelected: (v) {
                      if (v == 'delete') _delete(post);
                    },
                    itemBuilder: (_) => const [
                      PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete post'),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 0, 14, 12),
            child: Text(
              post['content'].toString(),
              style: TextStyle(
                fontSize: 14,
                height: 1.45,
                color: context.textStrong,
              ),
            ),
          ),
          if (media.startsWith('http'))
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 0, 14, 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: isVideo
                    ? _videoThumb(media)
                    : Image.network(
                        media,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => const SizedBox.shrink(),
                      ),
              ),
            ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            child: Row(
              children: [
                _action(
                  liked ? Icons.favorite : Icons.favorite_border,
                  '${post['likes_count'] ?? 0}',
                  liked ? Colors.red : context.textMuted,
                  () => _toggleLike(post),
                ),
                _action(
                  Icons.mode_comment_outlined,
                  '${post['comments_count'] ?? 0}',
                  context.textMuted,
                  () => _openComments(post),
                ),
                _action(
                  Icons.share_outlined,
                  '${post['shares_count'] ?? 0}',
                  context.textMuted,
                  () => _share(post),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _videoThumb(String url) {
    return GestureDetector(
      onTap: () => Navigator.of(
        context,
      ).push(MaterialPageRoute(builder: (_) => VideoPlayerScreen(source: url))),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Container(
          color: const Color(0xFF10331B),
          alignment: Alignment.center,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.play_circle_fill, color: Colors.white, size: 54),
              SizedBox(height: 6),
              Text(
                'Tap to play video',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _avatar(String name, String url) {
    final initials = name.trim().isEmpty
        ? '?'
        : name.trim().split(RegExp(r'\s+')).take(2).map((p) => p[0]).join();
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _green,
        image: url.startsWith('http')
            ? DecorationImage(image: NetworkImage(url), fit: BoxFit.cover)
            : null,
      ),
      alignment: Alignment.center,
      child: url.startsWith('http')
          ? null
          : Text(
              initials.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
    );
  }

  Widget _action(IconData icon, String label, Color color, VoidCallback onTap) {
    return Expanded(
      child: TextButton.icon(
        onPressed: onTap,
        icon: Icon(icon, size: 18, color: color),
        label: Text(
          label,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 8),
        ),
      ),
    );
  }

  static String _timeAgo(dynamic iso) {
    final t = DateTime.tryParse(iso?.toString() ?? '');
    if (t == null) return '';
    final d = DateTime.now().difference(t);
    if (d.inSeconds < 60) return 'just now';
    if (d.inMinutes < 60) return '${d.inMinutes}m';
    if (d.inHours < 24) return '${d.inHours}h';
    if (d.inDays < 7) return '${d.inDays}d';
    return '${t.day}/${t.month}/${t.year}';
  }
}

// ============================ COMPOSER ============================

class _ComposerSheet extends StatefulWidget {
  const _ComposerSheet();

  @override
  State<_ComposerSheet> createState() => _ComposerSheetState();
}

class _ComposerSheetState extends State<_ComposerSheet> {
  static const _green = Color(0xFF1A5C2A);
  final _picker = ImagePicker();
  final _controller = TextEditingController();
  File? _media;
  String? _mediaType; // 'image' | 'video'
  bool _posting = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _chooseMedia() async {
    final choice = await showModalBottomSheet<List<String>>(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _sheetTile(Icons.photo_camera, 'Take a photo', ['image', 'camera']),
            _sheetTile(Icons.videocam, 'Record a video', ['video', 'camera']),
            _sheetTile(Icons.photo_library, 'Photo from gallery', [
              'image',
              'gallery',
            ]),
            _sheetTile(Icons.video_library, 'Video from gallery', [
              'video',
              'gallery',
            ]),
          ],
        ),
      ),
    );
    if (choice == null) return;
    await _pick(
      isVideo: choice[0] == 'video',
      fromCamera: choice[1] == 'camera',
    );
  }

  Widget _sheetTile(IconData icon, String label, List<String> value) {
    return ListTile(
      leading: Icon(icon, color: _green),
      title: Text(label),
      onTap: () => Navigator.pop(context, value),
    );
  }

  Future<void> _pick({required bool isVideo, required bool fromCamera}) async {
    try {
      final source = fromCamera ? ImageSource.camera : ImageSource.gallery;
      final XFile? file = isVideo
          ? await _picker.pickVideo(
              source: source,
              maxDuration: const Duration(minutes: 3),
            )
          : await _picker.pickImage(
              source: source,
              maxWidth: 1600,
              maxHeight: 1600,
              imageQuality: 85,
            );
      if (file != null) {
        setState(() {
          _media = File(file.path);
          _mediaType = isVideo ? 'video' : 'image';
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Could not get the media: $e')));
      }
    }
  }

  Future<void> _submit() async {
    final text = _controller.text.trim();
    if (text.isEmpty && _media == null) return;
    setState(() => _posting = true);
    try {
      await ApiService.instance.createPost(
        content: text,
        mediaPath: _media?.path,
      );
      if (mounted) Navigator.pop(context, true);
    } catch (e) {
      if (mounted) {
        setState(() => _posting = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: 16 + MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: context.hairline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            'Create post',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: _green,
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _controller,
            maxLines: 5,
            minLines: 3,
            autofocus: true,
            decoration: InputDecoration(
              hintText: "What's on your mind?",
              filled: true,
              fillColor: context.surfaceAlt,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: context.hairline),
              ),
            ),
          ),
          if (_media != null) ...[
            const SizedBox(height: 10),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: _mediaType == 'video'
                      ? Container(
                          height: 150,
                          width: double.infinity,
                          color: const Color(0xFF10331B),
                          alignment: Alignment.center,
                          child: const Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.videocam,
                                color: Colors.white,
                                size: 36,
                              ),
                              SizedBox(height: 6),
                              Text(
                                'Video ready to post',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        )
                      : Image.file(
                          _media!,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                ),
                Positioned(
                  right: 6,
                  top: 6,
                  child: GestureDetector(
                    onTap: () => setState(() {
                      _media = null;
                      _mediaType = null;
                    }),
                    child: const CircleAvatar(
                      radius: 14,
                      backgroundColor: Colors.black54,
                      child: Icon(Icons.close, size: 16, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
              TextButton.icon(
                onPressed: _chooseMedia,
                icon: const Icon(
                  Icons.add_photo_alternate_outlined,
                  color: _green,
                ),
                label: const Text(
                  'Photo / Video',
                  style: TextStyle(color: _green),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: _posting ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFCC00),
                  foregroundColor: _green,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: _posting
                    ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: _green,
                        ),
                      )
                    : const Text(
                        'Post',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ============================ COMMENTS ============================

class _CommentsSheet extends StatefulWidget {
  final Map<String, dynamic> post;
  final bool signedIn;
  final ValueChanged<int> onCountChanged;

  const _CommentsSheet({
    required this.post,
    required this.signedIn,
    required this.onCountChanged,
  });

  @override
  State<_CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends State<_CommentsSheet> {
  static const _green = Color(0xFF1A5C2A);
  final _controller = TextEditingController();
  List<Map<String, dynamic>> _comments = [];
  bool _loading = true;
  bool _sending = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    try {
      final c = await ApiService.instance.getPostComments(
        widget.post['id'] as int,
      );
      if (mounted) setState(() => _comments = c);
    } catch (_) {
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _send() async {
    final body = _controller.text.trim();
    if (body.isEmpty) return;
    if (!widget.signedIn) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please sign in to comment.')),
      );
      return;
    }
    setState(() => _sending = true);
    try {
      final c = await ApiService.instance.addPostComment(
        widget.post['id'] as int,
        body,
      );
      _controller.clear();
      if (mounted) {
        setState(() {
          _comments = [c, ..._comments];
          _sending = false;
        });
        widget.onCountChanged(_comments.length);
      }
    } catch (e) {
      if (mounted) {
        setState(() => _sending = false);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.75,
        child: Column(
          children: [
            const SizedBox(height: 10),
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: context.hairline,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12),
              child: Text(
                'Comments',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: _green,
                ),
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: _loading
                  ? const Center(
                      child: CircularProgressIndicator(color: _green),
                    )
                  : _comments.isEmpty
                  ? const Center(
                      child: Text(
                        'No comments yet.',
                        style: TextStyle(color: Colors.grey),
                      ),
                    )
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.all(12),
                      itemCount: _comments.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, i) {
                        final c = _comments[i];
                        final name =
                            ((c['author'] as Map?)?['name'] ?? 'UDA Member')
                                .toString();
                        return Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: _green,
                              child: Text(
                                name.isNotEmpty ? name[0].toUpperCase() : '?',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: _green,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    c['body'].toString(),
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
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 8, 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Write a comment…',
                        filled: true,
                        fillColor: context.surfaceAlt,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: context.hairline),
                        ),
                      ),
                      onSubmitted: (_) => _send(),
                    ),
                  ),
                  IconButton(
                    onPressed: _sending ? null : _send,
                    icon: const Icon(Icons.send, color: _green),
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
