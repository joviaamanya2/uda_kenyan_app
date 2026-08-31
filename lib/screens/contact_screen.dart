// lib/screens/contact_screen.dart
import 'package:flutter/material.dart';
import 'ask_president.dart';
import '../services/api_service.dart';
import '../theme/theme_ext.dart';

class ContactScreen extends StatefulWidget {
  final bool embedded;
  const ContactScreen({super.key, this.embedded = false});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();

  // Contact / social details from the admin dashboard (with sensible defaults).
  String _phone = '020 2020405';
  String _email = 'hello@uda.ke';
  String _address = 'Hustler Plaza, Ngong Road, Nairobi';
  String _hours = 'Mon - Fri: 8:00 AM - 5:00 PM';
  String _facebook = 'TheUDAKenya';
  String _twitter = 'UDAKenya';
  String _instagram = 'theudakenya';
  String _youtube = '';

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final s = await ApiService.instance.getSettings();
    if (!mounted || s.isEmpty) return;
    setState(() {
      _phone = s['contact_phone']?.trim().isNotEmpty == true
          ? s['contact_phone']!
          : _phone;
      _email = s['contact_email']?.trim().isNotEmpty == true
          ? s['contact_email']!
          : _email;
      _address = s['contact_address']?.trim().isNotEmpty == true
          ? s['contact_address']!
          : _address;
      _hours = s['contact_hours']?.trim().isNotEmpty == true
          ? s['contact_hours']!
          : _hours;
      _facebook = s['social_facebook'] ?? _facebook;
      _twitter = s['social_twitter'] ?? _twitter;
      _instagram = s['social_instagram'] ?? _instagram;
      _youtube = s['social_youtube'] ?? _youtube;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields before sending.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Email validation
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(_emailController.text)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid email address.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    try {
      await ApiService.instance.sendContact(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        message: _messageController.text.trim(),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.toString()), backgroundColor: Colors.red),
      );
      return;
    }
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: const [
            Icon(Icons.check_circle, color: Color(0xFF1A3C6B), size: 28),
            SizedBox(width: 8),
            Text(
              'Message Sent',
              style: TextStyle(
                color: Color(0xFF1A3C6B),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          'Thank you ${_nameController.text}! Your message has been sent to UDA Support Center. We will get back to you shortly.',
          style: const TextStyle(fontSize: 14, height: 1.5),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _messageController.clear();
              _nameController.clear();
              _emailController.clear();
            },
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF1A3C6B),
            ),
            child: const Text(
              'OK',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.embedded
          ? context.pageBg
          : const Color(0xFFFFD700), // UDA Gold/Yellow
      appBar: widget.embedded
          ? null
          : AppBar(
              backgroundColor: const Color(0xFFFFD700),
              elevation: 0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Color(0xFF1A3C6B),
                  size: 24,
                ),
                onPressed: () => Navigator.pop(context),
              ),
              title: Row(
                children: [
                  Container(
                    height: 32,
                    width: 32,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF1A3C6B),
                    ),
                    child: const Center(
                      child: Text(
                        'U',
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
                    'Contact UDA',
                    style: TextStyle(
                      color: Color(0xFF1A3C6B),
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              centerTitle: false,
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.help_outline,
                    color: Color(0xFF1A3C6B),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text(
                          'Need Help?',
                          style: TextStyle(color: Color(0xFF1A3C6B)),
                        ),
                        content: Text(
                          'For immediate assistance, please contact the UDA National Office:\n\n📞 $_phone\n📧 $_email\n📍 $_address',
                          style: const TextStyle(height: 1.8),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text(
                              'Close',
                              style: TextStyle(color: Color(0xFF1A3C6B)),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Welcome Header
            Container(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome to UDA Support Center.',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1A3C6B),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'We\'re here to help you connect with UDA.',
                    style: TextStyle(fontSize: 14, color: context.textMuted),
                  ),
                ],
              ),
            ),

            // Quick Action Cards
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: _buildQuickActionCard(
                      icon: Icons.headset_mic_outlined,
                      title: 'Ask UDA AI',
                      subtitle: 'Get instant answers',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AskPresidentScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildQuickActionCard(
                      icon: Icons.phone,
                      title: 'Call Office',
                      subtitle: 'Speak to a representative',
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text(
                              'Contact UDA Office',
                              style: TextStyle(color: Color(0xFF1A3C6B)),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('📞 $_phone'),
                                const SizedBox(height: 8),
                                Text('📧 $_email'),
                                const SizedBox(height: 8),
                                Text('📍 $_address'),
                                const SizedBox(height: 8),
                                Text('🕐 $_hours'),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text(
                                  'Close',
                                  style: TextStyle(color: Color(0xFF1A3C6B)),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Main White Container
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF8F9FA),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28),
                  topRight: Radius.circular(28),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Follow UDA Card
                  _buildFollowUDACard(),
                  const SizedBox(height: 16),

                  // Send Email Card
                  _buildSendEmailCard(),
                  const SizedBox(height: 16),

                  // Additional Contact Info
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: context.surface,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.04),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildContactInfoItem(Icons.email, 'Email', _email),
                        _buildContactInfoItem(
                          Icons.location_on,
                          'Address',
                          _address,
                        ),
                        _buildContactInfoItem(Icons.phone, 'Phone', _phone),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        decoration: BoxDecoration(
          color: context.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: const BoxDecoration(
                color: Color(0xFFFFD700),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: const Color(0xFF1A3C6B), size: 26),
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A3C6B),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              style: TextStyle(fontSize: 10, color: context.textMuted),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactInfoItem(IconData icon, String label, String value) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF1A3C6B), size: 22),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            color: Color(0xFF1A3C6B),
          ),
        ),
        Text(value, style: TextStyle(fontSize: 10, color: context.textMuted)),
      ],
    );
  }

  Widget _buildFollowUDACard() {
    final socials = [
      if (_facebook.trim().isNotEmpty)
        {
          'name': _facebook,
          'icon': Icons.facebook,
          'color': const Color(0xFF1877F2),
        },
      if (_twitter.trim().isNotEmpty)
        {
          'name': _twitter,
          'icon': Icons.flutter_dash,
          'color': const Color(0xFF1DA1F2),
        },
      if (_instagram.trim().isNotEmpty)
        {
          'name': _instagram,
          'icon': Icons.camera_alt,
          'color': const Color(0xFFE4405F),
        },
      if (_youtube.trim().isNotEmpty)
        {
          'name': 'YouTube',
          'icon': Icons.play_circle_fill,
          'color': const Color(0xFFE50914),
        },
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Follow UDA',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1A3C6B),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFD700),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'CONNECT',
                  style: TextStyle(
                    color: Color(0xFF1A3C6B),
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 20,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: socials.map((social) {
              final name = social['name'] as String;
              final icon = social['icon'] as IconData;
              final color = social['color'] as Color;

              return GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Opening UDA $name page...'),
                      backgroundColor: const Color(0xFF1A3C6B),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                child: SizedBox(
                  width: 70,
                  child: Column(
                    children: [
                      Container(
                        width: 46,
                        height: 46,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: context.surface,
                          border: Border.all(
                            color: context.hairline,
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(icon, color: color, size: 24),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        name,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: context.textMuted,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSendEmailCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.email_outlined,
                color: Color(0xFF1A3C6B),
                size: 24,
              ),
              const SizedBox(width: 10),
              const Text(
                'Send us an Email',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1A3C6B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Name field
          TextField(
            controller: _nameController,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              labelText: 'Your Name *',
              hintText: 'Enter your full name',
              hintStyle: TextStyle(color: Colors.grey[400]),
              labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: context.hairline),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xFF1A3C6B),
                  width: 2,
                ),
              ),
              prefixIcon: const Icon(
                Icons.person_outline,
                color: Colors.grey,
                size: 20,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Email field
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              labelText: 'Your Email Address *',
              hintText: 'you@example.com',
              hintStyle: TextStyle(color: Colors.grey[400]),
              labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: context.hairline),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xFF1A3C6B),
                  width: 2,
                ),
              ),
              prefixIcon: const Icon(
                Icons.email_outlined,
                color: Colors.grey,
                size: 20,
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Message field
          TextField(
            controller: _messageController,
            maxLines: 4,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              labelText: 'Your Message *',
              hintText: 'How can we help you?',
              hintStyle: TextStyle(color: Colors.grey[400]),
              alignLabelWithHint: true,
              labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: context.hairline),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Color(0xFF1A3C6B),
                  width: 2,
                ),
              ),
              prefixIcon: const Icon(
                Icons.message_outlined,
                color: Colors.grey,
                size: 20,
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Send Message Button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _sendMessage,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFD700),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'SEND MESSAGE',
                style: TextStyle(
                  color: Color(0xFF1A3C6B),
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          Text(
            '* All fields are required',
            style: TextStyle(
              fontSize: 11,
              color: context.textMuted,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
