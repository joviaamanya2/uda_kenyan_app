// lib/utils/web_utils_mobile.dart
// Mobile-specific implementation (does nothing)
class WebUtils {
  static bool get isWeb => false;
  
  static void registerMapView() {
    // Do nothing on mobile
  }
  
  static void openMapUrl(String url) {
    // Do nothing on mobile
  }
}