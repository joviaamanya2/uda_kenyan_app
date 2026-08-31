// lib/screens/resource_center/tenders_screen.dart
import 'package:flutter/material.dart';
import '../../theme/theme_ext.dart';

class TendersScreen extends StatelessWidget {
  const TendersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        title: const Text(
          'TENDERS',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFCC00),
        foregroundColor: Colors.black,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFCC00).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFFFCC00)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.request_quote, color: Color(0xFF1A5C2A)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Open tenders and procurement opportunities',
                      style: TextStyle(fontSize: 13, color: context.textMuted),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildTenderItem(
                    context: context,
                    title: 'Supply of Office Equipment',
                    ref: 'UDA/T/2024/001',
                    deadline: '30 April 2024',
                    status: 'Open',
                  ),
                  _buildTenderItem(
                    context: context,
                    title: 'Event Management Services',
                    ref: 'UDA/T/2024/002',
                    deadline: '25 April 2024',
                    status: 'Open',
                  ),
                  _buildTenderItem(
                    context: context,
                    title: 'Printing and Branding Services',
                    ref: 'UDA/T/2024/003',
                    deadline: '20 April 2024',
                    status: 'Closing Soon',
                  ),
                  _buildTenderItem(
                    context: context,
                    title: 'IT Infrastructure Upgrade',
                    ref: 'UDA/T/2024/004',
                    deadline: '15 April 2024',
                    status: 'Closed',
                  ),
                  _buildTenderItem(
                    context: context,
                    title: 'Security Services',
                    ref: 'UDA/T/2024/005',
                    deadline: '10 April 2024',
                    status: 'Closed',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTenderItem({
    required BuildContext context,
    required String title,
    required String ref,
    required String deadline,
    required String status,
  }) {
    Color statusColor;
    if (status == 'Open') {
      statusColor = Colors.green;
    } else if (status == 'Closing Soon') {
      statusColor = Colors.orange;
    } else {
      statusColor = Colors.red;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color(0xFF1A5C2A),
            ),
          ),
          const SizedBox(height: 4),
          Text(ref, style: TextStyle(fontSize: 12, color: context.textMuted)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.event, size: 14, color: Colors.grey),
                  const SizedBox(width: 4),
                  Text(
                    deadline,
                    style: TextStyle(fontSize: 12, color: context.textMuted),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: statusColor),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
