// lib/screens/locations_screen.dart
import 'package:flutter/material.dart';
import '../theme/theme_ext.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: AppBar(
        title: const Text(
          'OUR LOCATIONS',
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
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // National Headquarters
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(bottom: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A5C2A),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.account_balance, color: Color(0xFFFFCC00)),
                      SizedBox(width: 8),
                      Text(
                        'UDA National Headquarters',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Hustler Plaza, Ngong Road, Nairobi',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Tel: 020 2020405   •   Email: hello@uda.ke',
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ],
              ),
            ),

            // Main Featured Location - Baringo
            _buildMainLocationCard(
              title: 'Baringo',
              subtitle: 'UDA Regional Office',
              location: 'Baringo County Headquarters',
              address: 'Along Kabarnet - Eldama Ravine Road',
              imageAsset: 'assets/images/location images/baringo (1).jpeg',
            ),
            const SizedBox(height: 20),

            // Section Title
            const Text(
              'OTHER REGIONAL OFFICES',
              style: TextStyle(
                color: Color(0xFF1A5C2A),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),

            // Grid of Regional Offices
            _buildLocationGrid(),

            const SizedBox(height: 16),

            // Contact Information
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.surface,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFCC00),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.phone,
                      color: Color(0xFF1A5C2A),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Need help finding us?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A5C2A),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Call us: 020 2020405',
                          style: TextStyle(
                            fontSize: 13,
                            color: context.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  // Main Featured Location Card with background image
  Widget _buildMainLocationCard({
    required String title,
    required String subtitle,
    required String location,
    required String address,
    required String imageAsset,
  }) {
    return Container(
      height: 220,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(imageAsset),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4),
            BlendMode.darken,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: const Color(0xFFFFCC00),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF1A5C2A),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on,
                  color: Color(0xFFFFCC00),
                  size: 16,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        location,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        address,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Grid of Regional Offices
  Widget _buildLocationGrid() {
    final locations = [
      {
        'name': 'Baringo',
        'image': 'assets/images/location images/baringo.jpeg',
        'address': 'UDA Baringo County Office',
        'county': 'Baringo County',
      },
      {
        'name': 'BUNGOMA',
        'image': 'assets/images/location images/bungoma.jpeg',
        'address': 'UDA Bungoma County Office',
        'county': 'Bungoma County',
      },
      {
        'name': 'Busia',
        'image': 'assets/images/location images/busia1.jpeg',
        'address': 'UDA Busia County Office',
        'county': 'Busia County',
      },
      {
        'name': 'Homa Bay',
        'image': 'assets/images/homa_bay.jpg',
        'address': 'UDA Homa Bay County Office',
        'county': 'Homa Bay County',
      },
      {
        'name': 'Isiolo North',
        'image': 'assets/images/location images/isiolonorth4.jpeg',
        'address': 'UDA Isiolo North Constituency Office',
        'county': 'Isiolo County',
      },
      // {
      //   'name': 'GARISSA',
      //   'image': 'assets/images/garissa.jpg',
      //   'address': 'Garissa County HQ',
      //   'county': 'Garissa County',
      // },
      // {
      //   'name': 'NYERI',
      //   'image': 'assets/images/nyeri.jpg',
      //   'address': 'Nyeri County HQ',
      //   'county': 'Nyeri County',
      // },
      // {
      //   'name': 'KAKAMEGA',
      //   'image': 'assets/images/kakamega.jpg',
      //   'address': 'Kakamega County HQ',
      //   'county': 'Kakamega County',
      // },
      // {
      //   'name': 'MACHAKOS',
      //   'image': 'assets/images/machakos.jpg',
      //   'address': 'Machakos County HQ',
      //   'county': 'Machakos County',
      // },
      // {
      //   'name': 'KERICHO',
      //   'image': 'assets/images/kericho.jpg',
      //   'address': 'Kericho County HQ',
      //   'county': 'Kericho County',
      // },
      // {
      //   'name': 'KITALE',
      //   'image': 'assets/images/kitale.jpg',
      //   'address': 'Kitale County HQ',
      //   'county': 'Trans Nzoia County',
      // },
      // {
      //   'name': 'MERU',
      //   'image': 'assets/images/meru.jpg',
      //   'address': 'Meru County HQ',
      //   'county': 'Meru County',
      // },
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.85,
      ),
      itemCount: locations.length,
      itemBuilder: (context, index) {
        final location = locations[index];
        return _buildLocationCard(
          context: context,
          name: location['name']!,
          image: location['image']!,
          address: location['address']!,
          county: location['county']!,
        );
      },
    );
  }

  // Individual Location Card with Background Image
  Widget _buildLocationCard({
    required BuildContext context,
    required String name,
    required String image,
    required String address,
    required String county,
  }) {
    return GestureDetector(
      onTap: () {
        _showLocationDetails(context, name, address, county);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.4),
              BlendMode.darken,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.6)],
            ),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFCC00),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  name,
                  style: const TextStyle(
                    color: Color(0xFF1A5C2A),
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                address,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                county,
                style: TextStyle(color: Colors.white70, fontSize: 9),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Show Location Details Dialog
  void _showLocationDetails(
    BuildContext context,
    String name,
    String address,
    String county,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) => AlertDialog(
        title: Row(
          children: [
            const Icon(Icons.location_on, color: Color(0xFF1A5C2A)),
            const SizedBox(width: 8),
            Text(name, style: const TextStyle(color: Color(0xFF1A5C2A))),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFF1A5C2A),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'assets/images/${name.toLowerCase()}.jpg',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: const Color(0xFF1A5C2A),
                      child: const Center(
                        child: Icon(
                          Icons.location_on,
                          color: Color(0xFFFFCC00),
                          size: 50,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'Address:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A5C2A),
              ),
            ),
            const SizedBox(height: 4),
            Text(address, style: const TextStyle(fontSize: 14)),
            const SizedBox(height: 4),
            Text(
              county,
              style: TextStyle(fontSize: 13, color: context.textMuted),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFFFCC00).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFFFCC00)),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Color(0xFF1A5C2A),
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Visit us during office hours: Mon-Fri 8:00 AM - 5:00 PM',
                      style: TextStyle(fontSize: 12, color: context.textMuted),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text(
              'CLOSE',
              style: TextStyle(color: Color(0xFF1A5C2A)),
            ),
          ),
        ],
      ),
    );
  }
}
