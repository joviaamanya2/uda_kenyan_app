// lib/screens/resource_center/financial_statements_screen.dart
import 'package:flutter/material.dart';
import '../../theme/theme_ext.dart';

class FinancialStatementsScreen extends StatelessWidget {
  const FinancialStatementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        title: const Text(
          'FINANCIAL STATEMENTS',
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
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFCC00).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFFFCC00)),
              ),
              child: Text(
                'Party financial reports and statements',
                style: TextStyle(fontSize: 13, color: context.textMuted),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildFinancialItem(
                    context: context,
                    title: 'Annual Financial Report 2023',
                    year: '2023',
                    type: 'Annual Report',
                    size: '4.2 MB',
                  ),
                  _buildFinancialItem(
                    context: context,
                    title: 'Audited Accounts 2022',
                    year: '2022',
                    type: 'Audited Accounts',
                    size: '3.8 MB',
                  ),
                  _buildFinancialItem(
                    context: context,
                    title: 'Quarterly Report Q4 2023',
                    year: '2023',
                    type: 'Quarterly Report',
                    size: '1.5 MB',
                  ),
                  _buildFinancialItem(
                    context: context,
                    title: 'Budget Summary 2024',
                    year: '2024',
                    type: 'Budget',
                    size: '2.1 MB',
                  ),
                  _buildFinancialItem(
                    context: context,
                    title: 'Audited Accounts 2021',
                    year: '2021',
                    type: 'Audited Accounts',
                    size: '3.2 MB',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFinancialItem({
    required BuildContext context,
    required String title,
    required String year,
    required String type,
    required String size,
  }) {
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
      child: Row(
        children: [
          Expanded(
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
                const SizedBox(height: 6),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFCC00),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        type,
                        style: const TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1A5C2A),
                        ),
                      ),
                    ),
                    Text(
                      year,
                      style: TextStyle(fontSize: 12, color: context.textMuted),
                    ),
                    Text(
                      size,
                      style: TextStyle(fontSize: 12, color: context.textMuted),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
            decoration: BoxDecoration(
              color: const Color(0xFF1A5C2A),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'View',
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
