// lib/utils/web_utils.dart
import 'package:flutter/foundation.dart' show kIsWeb;

// This file will only be used on web platforms
class WebUtils {
  static bool get isWeb => kIsWeb;

  // These will only be called when on web
  static void registerMapView() {
    // We'll implement this using dynamic imports
  }

  static void openMapUrl(String url) {
    // We'll implement this using dynamic imports
  }
}
