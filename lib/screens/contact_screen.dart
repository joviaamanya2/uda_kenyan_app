// lib/screens/contact_screen.dart
import 'package:flutter/material.dart';
import 'ask_president.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final TextEditingController _nameController = TextEditingController(text: 'Amanya Jovia');
  final TextEditingController _emailController = TextEditingController(text: 'joviaamanya2@gmail.com');
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_nameController.text.isEmpty || _emailController.text.isEmpty || _messageController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields before sending.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: const [
            Icon(Icons.check_circle, color: Color(0xFF1A5C2A), size: 28),
            SizedBox(width: 8),
            Text('Message Sent', style: TextStyle(color: Color(0xFF1A5C2A), fontWeight: FontWeight.bold)),
          ],
        ),
        content: Text('Thank you ${_nameController.text}! Your message has been sent to UDA Support Center. We will get back to you shortly.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _messageController.clear();
            },
            child: const Text('OK', style: TextStyle(color: Color(0xFF1A5C2A), fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFCC00), // Main Yellow theme background
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFCC00),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 24),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Contact UDA',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
            fontSize: 22,
          ),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Top Welcome Header
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome to UDA Support Center.',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
              ),
            ),

            // Top Action Cards: Ask UDA AI & Call UDA Office
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(
                    child: _buildTopActionCard(
                      icon: Icons.headset_mic_outlined,
                      title: 'Ask UDA AI',
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
                  const SizedBox(width: 14),
                  Expanded(
                    child: _buildTopActionCard(
                      icon: Icons.phone,
                      title: 'Call UDA Office',
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Calling UDA Support Office: +254 720 000 000'),
                            backgroundColor: Color(0xFF1A5C2A),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Main White Container Sheet with Socials and Email Form
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF7F7F7),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Follow UDA Card
                  _buildFollowUDACard(),

                  const SizedBox(height: 18),

                  // Send us an Email Card
                  _buildSendEmailCard(),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget for Top Action Card (Ask UDA AI & Call UDA Office)
  Widget _buildTopActionCard({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                color: Color(0xFFFFCC00),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.black, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // Follow UDA Card
  Widget _buildFollowUDACard() {
    final socials = [
      {'name': 'Youtube', 'icon': Icons.play_arrow_rounded, 'color': const Color(0xFFE50914)},
      {'name': 'Facebook', 'icon': Icons.facebook, 'color': const Color(0xFF1877F2)},
      {'name': 'Instagram', 'icon': Icons.camera_alt, 'color': const Color(0xFFE4405F)},
      {'name': 'Twitter', 'icon': Icons.flutter_dash, 'color': const Color(0xFF1DA1F2)},
      {'name': 'Flickr', 'icon': Icons.circle_notifications, 'color': const Color(0xFF0063DC)},
      {'name': 'Soundcloud', 'icon': Icons.cloud_queue, 'color': const Color(0xFFFF5500)},
      {'name': 'TikTok', 'icon': Icons.music_note, 'color': Colors.black},
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Follow UDA.',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 140,
            height: 1.5,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 24,
            runSpacing: 20,
            alignment: WrapAlignment.start,
            children: socials.map((social) {
              final name = social['name'] as String;
              final icon = social['icon'] as IconData;
              final color = social['color'] as Color;

              return GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Opening UDA $name page...'),
                      backgroundColor: const Color(0xFF1A5C2A),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                child: SizedBox(
                  width: 75,
                  child: Column(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: Colors.grey[200]!, width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.06),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(icon, color: color, size: 26),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
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

  // Send us an Email Card
  Widget _buildSendEmailCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Send us an Email',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            width: 140,
            height: 1.5,
            color: Colors.grey[300],
          ),
          const SizedBox(height: 20),

          // Name field
          TextField(
            controller: _nameController,
            style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
            decoration: InputDecoration(
              labelText: 'Your Name',
              labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF1A5C2A), width: 2),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Email field
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
            decoration: InputDecoration(
              labelText: 'Your Email Address',
              labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF1A5C2A), width: 2),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Message field
          TextField(
            controller: _messageController,
            maxLines: 4,
            style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
            decoration: InputDecoration(
              labelText: 'Your Message',
              alignLabelWithHint: true,
              labelStyle: const TextStyle(color: Colors.grey, fontSize: 14),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xFF1A5C2A), width: 2),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Send Message Button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _sendMessage,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFCC00),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'SEND MESSAGE',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 15,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
