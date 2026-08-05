// lib/screens/contact_screen.dart
import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'CONTACT US',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFFFCC00),
        foregroundColor: Colors.black,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A5C2A),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  children: [
                    Icon(Icons.phone, color: Color(0xFFFFCC00), size: 48),
                    SizedBox(height: 8),
                    Text(
                      'Contact UDA',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildContactCard(
                icon: Icons.phone,
                title: 'Phone',
                info: ['+254 720 000 000', '+254 730 000 000'],
              ),
              _buildContactCard(
                icon: Icons.email,
                title: 'Email',
                info: ['info@uda.go.ke', 'support@uda.go.ke'],
              ),
              _buildContactCard(
                icon: Icons.location_on,
                title: 'Head Office',
                info: ['UDA Headquarters', 'Nairobi, Kenya'],
              ),
              _buildContactCard(
                icon: Icons.access_time,
                title: 'Working Hours',
                info: ['Monday - Friday: 8:00 AM - 5:00 PM', 'Saturday: 8:00 AM - 1:00 PM'],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard({
    required IconData icon,
    required String title,
    required List<String> info,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFFCC00),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFF1A5C2A)),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A5C2A),
                  ),
                ),
                ...info.map((item) => Text(
                  item,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
