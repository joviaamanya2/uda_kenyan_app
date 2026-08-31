// lib/screens/join_uda_screen.dart
import 'package:flutter/material.dart';
import 'join_uda_form.dart';
import '../theme/theme_ext.dart';

class JoinUDAScreen extends StatelessWidget {
  const JoinUDAScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        title: const Text(
          'JOIN UDA',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFFCC00),
        foregroundColor: Colors.black,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        // Floating Join UDA Button in AppBar - Top Right Corner
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () => _navigateToForm(context),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A5C2A),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person_add, color: Colors.white, size: 16),
                    SizedBox(width: 6),
                    Text(
                      'JOIN UDA',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Who Can Join UDA Section
            _buildSectionHeader('Who Can Join UDA'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: _cardDecoration(context),
              child: Text(
                'Membership to UDA is open to all Kenyans, irrespective of ethnic identity, sex, tribe, creed or religion, birth, economic status, race and disability or other sectional division, who are prepared to abide by its Constitution, Code of Conduct, Rules, Regulations and Bye-laws as may from time to time be made.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: context.textStrong,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // How To Join UDA Section
            _buildSectionHeader('How To Join UDA'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: _cardDecoration(context),
              child: Text(
                'Contact the secretary to your nearest Cell (village) or any other Branch Executive Committee member for registration, upon completion of registration an oath of allegiance to UDA will be made and then a membership card issued.',
                style: TextStyle(
                  fontSize: 14,
                  height: 1.6,
                  color: context.textStrong,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Membership Shall Cease Section
            _buildSectionHeader('Membership Shall Cease If A Member:'),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: _cardDecoration(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildListItem(context, '1. Dies;'),
                  _buildListItem(context, '2. Resigns;'),
                  _buildListItem(
                    context,
                    '3. Joins another political organisation or political party;',
                  ),
                  _buildListItem(
                    context,
                    '4. Is dismissed in accordance with the Constitution and the Code of Conduct of UDA;',
                  ),
                  _buildListItem(
                    context,
                    '5. Is found in breach of the code and in particular:',
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildListItem(
                          context,
                          '• Campaigning for a candidate sponsored by another political organisation or party;',
                        ),
                        _buildListItem(
                          context,
                          '• Offering material support to a candidate sponsored by another political organisation or party;',
                        ),
                        _buildListItem(
                          context,
                          '• Campaigning against the official candidate of UDA.',
                        ),
                        const SizedBox(height: 8),
                        _buildListItem(
                          context,
                          'Dismissal under circumstance (e) above shall be after a fair hearing.',
                        ),
                        const SizedBox(height: 8),
                        _buildListItem(
                          context,
                          'A person who wishes to rejoin UDA may apply in accordance with the Rules and Regulations made under the UDA constitution.',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Rights and Duties Section
            _buildSectionHeader('RIGHTS AND DUTIES OF MEMBERS'),
            const SizedBox(height: 8),

            // Rights Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: _cardDecoration(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Every member of UDA shall have a right to:',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A5C2A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildListItem(
                    context,
                    '1. Take a full and active part in the discussion, formulation and implementation of policies of UDA at the organ where he/she belongs;',
                  ),
                  _buildListItem(
                    context,
                    '2. Attend meetings of the relevant organ where he/she is a member;',
                  ),
                  _buildListItem(
                    context,
                    '3. Receive and disseminate information on all aspects of UDA policies and activities;',
                  ),
                  _buildListItem(
                    context,
                    '4. Offer constructive criticism of any member, official, policy, programme or activity within the organs of UDA;',
                  ),
                  _buildListItem(
                    context,
                    '5. Take part in elections and be eligible for election to any elective office within the structures of UDA or appointment to any committee, structure, commission or delegation of UDA;',
                  ),
                  _buildListItem(
                    context,
                    '6. Submit proposals or statements to the National Conference, or the National Executive Council (NEC) provided such proposals or statements are submitted through the appropriate structure.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Duties Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: _cardDecoration(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Every member of UDA shall, as a duty:',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A5C2A),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildListItem(
                    context,
                    '1. Belong to and take an active part in the activities of his or her branch;',
                  ),
                  _buildListItem(
                    context,
                    '2. Take all the necessary steps and means to understand and carry out the aims, policies and programmes of UDA;',
                  ),
                  _buildListItem(
                    context,
                    '3. Explain the aims, policies, programmes and achievements of UDA to the population;',
                  ),
                  _buildListItem(
                    context,
                    '4. Fight propaganda detrimental to the interests of UDA and defend its policies, aims and programmes;',
                  ),
                  _buildListItem(
                    context,
                    '5. Guard against sectarianism, tribal chauvinism, sexism, religious and political intolerance or any other form of discrimination;',
                  ),
                  _buildListItem(
                    context,
                    '6. Promote peace, unity and solidarity;',
                  ),
                  _buildListItem(
                    context,
                    '7. Observe discipline, behave honestly and be loyal to the decisions of the majority of the members of the organ where a member belongs and to the decisions of higher organs within the structures of UDA;',
                  ),
                  _buildListItem(
                    context,
                    '8. Refrain from publishing, distributing or making statements to any media house which purports to be the view or position of UDA without authorisation of the organ of UDA.',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      // Floating Join UDA Button at Bottom Right
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToForm(context),
        backgroundColor: const Color(0xFF1A5C2A),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.person_add),
        label: const Text(
          'JOIN UDA',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  // Helper method for section headers
  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(width: 4, height: 24, color: const Color(0xFFFFCC00)),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1A5C2A),
            ),
          ),
        ),
      ],
    );
  }

  // Helper method for list items
  Widget _buildListItem(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        text,
        style: TextStyle(fontSize: 13, height: 1.5, color: context.textStrong),
      ),
    );
  }

  // Helper method for card decoration
  BoxDecoration _cardDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.surface,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ],
      border: Border.all(color: context.hairline, width: 1),
    );
  }

  // Navigate to the registration form
  void _navigateToForm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const JoinUDAFormScreen()),
    );
  }
}
