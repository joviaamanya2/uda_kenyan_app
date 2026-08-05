// lib/screens/uda_candidates_screen.dart
import 'package:flutter/material.dart';

class UDACandidatesScreen extends StatefulWidget {
  const UDACandidatesScreen({super.key});

  @override
  State<UDACandidatesScreen> createState() => _UDACandidatesScreenState();
}

class _UDACandidatesScreenState extends State<UDACandidatesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  final List<Map<String, dynamic>> _candidates = [
    {
      'title': 'Presidential Candidate',
      'icon': Icons.how_to_vote,
      'count': '1',
    },
    {
      'title': 'Members of Parliament',
      'icon': Icons.gavel,
      'count': '290',
    },
    {
      'title': 'Mayors',
      'icon': Icons.emoji_people,
      'count': '47',
    },
    {
      'title': 'Governors',
      'icon': Icons.account_balance,
      'count': '47',
    },
    {
      'title': 'County Assembly Members',
      'icon': Icons.person_pin,
      'count': '1,450',
    },
    {
      'title': 'Youth Representatives',
      'icon': Icons.people,
      'count': '470',
    },
    {
      'title': 'Women Representatives',
      'icon': Icons.woman,
      'count': '47',
    },
    {
      'title': 'Senators',
      'icon': Icons.groups,
      'count': '47',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        title: const Text(
          'UDA CANDIDATES',
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: const Icon(Icons.search, color: Colors.black),
              onPressed: () {
                print('🔍 Search candidates');
              },
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color(0xFF1A5C2A).withOpacity(0.05),
              const Color(0xFFFFCC00).withOpacity(0.05),
              const Color(0xFF1A5C2A).withOpacity(0.05),
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Animated Background Shapes
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return CustomPaint(
                  painter: AnimatedBackgroundPainter(
                    animationValue: _animationController.value,
                  ),
                  size: MediaQuery.of(context).size,
                );
              },
            ),
            // Main Content
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF1A5C2A), Color(0xFF2E7D32)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.how_to_vote,
                          color: Color(0xFFFFCC00),
                          size: 48,
                        ),
                        SizedBox(height: 12),
                        Text(
                          'UDA CANDIDATES 2026',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'KAZI NI KAZI',
                          style: TextStyle(
                            color: Color(0xFFFFCC00),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Search Bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Search candidates...',
                        prefixIcon: Icon(Icons.search, color: Color(0xFF1A5C2A)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      ),
                      onChanged: (value) {
                        // Search functionality
                      },
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Candidates Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.1,
                    ),
                    itemCount: _candidates.length,
                    itemBuilder: (context, index) {
                      final candidate = _candidates[index];
                      return _buildCandidateCard(
                        title: candidate['title'] as String,
                        icon: candidate['icon'] as IconData,
                        count: candidate['count'] as String,
                        index: index,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCandidateCard({
    required String title,
    required IconData icon,
    required String count,
    required int index,
  }) {
    return GestureDetector(
      onTap: () {
        print('👤 $title tapped');
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFF1A5C2A),
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Animated Shimmer Effect on Card
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.transparent,
                            const Color(0xFF1A5C2A).withOpacity(0.08 + _animationController.value * 0.15),
                            Colors.transparent,
                          ],
                          stops: [
                            _animationController.value,
                            _animationController.value + 0.3,
                            _animationController.value + 0.6,
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Card Content
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFCC00).withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      color: const Color(0xFF1A5C2A),
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    count,
                    style: const TextStyle(
                      color: Color(0xFF1A5C2A),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    title,
                    style: const TextStyle(
                      color: Color(0xFF1A5C2A),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            // Small yellow indicator at bottom
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFCC00),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(index % 2 == 0 ? 12 : 0),
                    bottomRight: Radius.circular(index % 2 == 0 ? 0 : 12),
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

// Animated Background Painter
class AnimatedBackgroundPainter extends CustomPainter {
  final double animationValue;

  AnimatedBackgroundPainter({required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    
    // Moving circles
    for (int i = 0; i < 6; i++) {
      final offset = (animationValue + i * 0.15) % 1.0;
      final x = size.width * (0.1 + offset * 0.8);
      final y = size.height * (0.1 + (offset * 0.7 + i * 0.05) % 0.8);
      final radius = 60.0 + 30.0 * (i % 3);
      
      paint.color = i % 2 == 0
          ? const Color(0xFF1A5C2A).withOpacity(0.03)
          : const Color(0xFFFFCC00).withOpacity(0.03);
      
      canvas.drawCircle(Offset(x, y), radius, paint);
    }

    // Moving squares
    for (int i = 0; i < 4; i++) {
      final offset = (animationValue * 0.7 + i * 0.25) % 1.0;
      final x = size.width * (0.05 + offset * 0.9);
      final y = size.height * (0.05 + (offset * 0.6 + i * 0.08) % 0.9);
      final size2 = 40.0 + 20.0 * (i % 3);
      
      paint.color = i % 2 == 0
          ? const Color(0xFFFFCC00).withOpacity(0.02)
          : const Color(0xFF1A5C2A).withOpacity(0.02);
      
      canvas.drawRect(
        Rect.fromCenter(center: Offset(x, y), width: size2, height: size2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
