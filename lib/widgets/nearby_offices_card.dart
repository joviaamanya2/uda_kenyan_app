// lib/widgets/nearby_offices_card.dart
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../services/api_service.dart';
import '../theme/theme_ext.dart';

/// "UDA NEAR YOU" home-screen card. Loads UDA office locations from the backend
/// and, with the user's permission, sorts them by distance and offers
/// turn-by-turn directions in the phone's maps app.
class NearbyOfficesCard extends StatefulWidget {
  const NearbyOfficesCard({super.key});

  @override
  State<NearbyOfficesCard> createState() => _NearbyOfficesCardState();
}

class _Office {
  final String name;
  final String address;
  final double? lat;
  final double? lng;
  double? distanceMeters;

  _Office(this.name, this.address, this.lat, this.lng);
}

class _NearbyOfficesCardState extends State<NearbyOfficesCard> {
  static const _green = Color(0xFF1A5C2A);
  static const _yellow = Color(0xFFFFCC00);

  List<_Office> _offices = [];
  bool _loading = true;
  bool _expanded = false;
  String? _locationNote;
  Position? _position;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await Future.wait([_loadOffices(), _resolveLocation()]);
    _sort();
    if (mounted) setState(() => _loading = false);
  }

  Future<void> _loadOffices() async {
    try {
      final rows = await ApiService.instance.getList('locations');
      _offices = rows.map((r) {
        return _Office(
          (r['name'] ?? 'UDA Office').toString(),
          (r['address'] ?? '').toString(),
          _toDouble(r['latitude']),
          _toDouble(r['longitude']),
        );
      }).toList();
    } catch (_) {
      _offices = [];
    }
  }

  double? _toDouble(dynamic v) {
    if (v == null) return null;
    return double.tryParse(v.toString());
  }

  Future<void> _resolveLocation() async {
    try {
      if (!await Geolocator.isLocationServiceEnabled()) {
        _locationNote = 'Turn on location to see the offices closest to you.';
        return;
      }
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        _locationNote = 'Allow location access to sort offices by distance.';
        return;
      }
      _position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.medium,
        ),
      ).timeout(const Duration(seconds: 12));
    } catch (_) {
      _locationNote = 'Could not get your location.';
    }
  }

  void _sort() {
    final pos = _position;
    if (pos != null) {
      for (final o in _offices) {
        if (o.lat != null && o.lng != null) {
          o.distanceMeters = Geolocator.distanceBetween(
            pos.latitude,
            pos.longitude,
            o.lat!,
            o.lng!,
          );
        }
      }
      _offices.sort((a, b) {
        final da = a.distanceMeters ?? double.infinity;
        final db = b.distanceMeters ?? double.infinity;
        return da.compareTo(db);
      });
    } else {
      _offices.sort((a, b) => a.name.compareTo(b.name));
    }
  }

  Future<void> _directions(_Office o) async {
    final Uri uri;
    if (o.lat != null && o.lng != null) {
      uri = Uri.parse(
        'https://www.google.com/maps/dir/?api=1&destination=${o.lat},${o.lng}',
      );
    } else {
      uri = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent('${o.name} ${o.address}')}',
      );
    }
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _openAllInMaps() async {
    final uri = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent('UDA Party office Kenya')}',
    );
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  Future<void> _retryLocation() async {
    setState(() => _loading = true);
    _locationNote = null;
    await _resolveLocation();
    _sort();
    if (mounted) setState(() => _loading = false);
  }

  String _distanceLabel(double meters) {
    if (meters < 1000) return '${meters.round()} m away';
    return '${(meters / 1000).toStringAsFixed(1)} km away';
  }

  @override
  Widget build(BuildContext context) {
    final visible = _expanded ? _offices : _offices.take(3).toList();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: _green,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.location_on, color: _yellow, size: 20),
                const SizedBox(width: 8),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'UDA NEAR YOU',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Find your nearest UDA office',
                        style: TextStyle(color: Colors.white70, fontSize: 11),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: _openAllInMaps,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _yellow,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Open Map',
                          style: TextStyle(
                            color: _green,
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(Icons.open_in_new, color: _green, size: 14),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Body
          if (_loading)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 32),
              child: Center(child: CircularProgressIndicator(color: _green)),
            )
          else if (_offices.isEmpty)
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Office locations are not available right now.',
                style: TextStyle(color: Colors.grey),
              ),
            )
          else ...[
            if (_locationNote != null)
              Container(
                width: double.infinity,
                color: const Color(0xFFFFF8E1),
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                child: Row(
                  children: [
                    const Icon(
                      Icons.info_outline,
                      size: 16,
                      color: Color(0xFF8A6D00),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _locationNote!,
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFF8A6D00),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _retryLocation,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(0, 0),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text(
                        'Enable',
                        style: TextStyle(fontSize: 11, color: _green),
                      ),
                    ),
                  ],
                ),
              ),
            ...visible.map(_officeRow),
            if (_offices.length > 3)
              InkWell(
                onTap: () => setState(() => _expanded = !_expanded),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Center(
                    child: Text(
                      _expanded
                          ? 'Show fewer'
                          : 'Show all ${_offices.length} offices',
                      style: const TextStyle(
                        color: _green,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ],
      ),
    );
  }

  Widget _officeRow(_Office o) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: context.hairline)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: _green.withOpacity(0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.apartment, color: _green, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  o.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: _green,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  o.distanceMeters != null
                      ? '${_distanceLabel(o.distanceMeters!)}  ·  ${o.address}'
                      : o.address,
                  style: TextStyle(fontSize: 11, color: context.textMuted),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          TextButton.icon(
            onPressed: () => _directions(o),
            icon: const Icon(Icons.directions, size: 16),
            label: const Text('Directions', style: TextStyle(fontSize: 11)),
            style: TextButton.styleFrom(
              foregroundColor: _green,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }
}
