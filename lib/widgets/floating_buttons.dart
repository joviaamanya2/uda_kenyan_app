// lib/widgets/floating_buttons.dart
import 'package:flutter/material.dart';

class FloatingButtons extends StatelessWidget {
  const FloatingButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          heroTag: 'support',
          onPressed: () {
            _showSupportDialog(context);
          },
          backgroundColor: const Color(0xFF1A5C2A),
          child: const Icon(Icons.support_agent, color: Colors.white),
        ),
        const SizedBox(height: 12),
        FloatingActionButton(
          heroTag: 'chat',
          onPressed: () {
            _showChatDialog(context);
          },
          backgroundColor: const Color(0xFFFFCC00),
          child: const Icon(Icons.chat, color: Color(0xFF1A5C2A)),
        ),
      ],
    );
  }

  void _showSupportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Support Center',
          style: TextStyle(
            color: Color(0xFF1A5C2A),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'How can we help you?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text('📞 Call: +254 720 000 000'),
            Text('📧 Email: support@uda.go.ke'),
            Text('🌐 Visit: www.uda.go.ke/support'),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'CLOSE',
              style: TextStyle(
                color: Color(0xFF1A5C2A),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFCC00),
              foregroundColor: const Color(0xFF1A5C2A),
            ),
            child: const Text('CONTACT SUPPORT'),
          ),
        ],
      ),
    );
  }

  void _showChatDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Chat with UDA',
          style: TextStyle(
            color: Color(0xFF1A5C2A),
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chat with us on our official platforms:',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 12),
            Text('💬 WhatsApp: +254 720 000 000'),
            Text('📱 Telegram: @UDAParty'),
            Text('🐦 Twitter: @UDAParty'),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              'CLOSE',
              style: TextStyle(
                color: Color(0xFF1A5C2A),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFCC00),
              foregroundColor: const Color(0xFF1A5C2A),
            ),
            child: const Text('START CHAT'),
          ),
        ],
      ),
    );
  }
}