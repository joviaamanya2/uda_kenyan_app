// lib/utils/web_utils_web.dart
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

// Web-specific implementation
class WebUtils {
  static bool get isWeb => true;
  
  static void registerMapView() {
    try {
      ui_web.platformViewRegistry.registerViewFactory(
        'google-maps-uda',
        (int viewId) {
          final iframe = html.IFrameElement()
            ..src = 'https://maps.google.com/maps?q=UDA+Party+Headquarters,+Nairobi,+Kenya&z=13&output=embed'
            ..style.border = 'none'
            ..style.width = '100%'
            ..style.height = '100%'
            ..setAttribute('allowfullness', '')
            ..setAttribute('loading', 'lazy')
            ..setAttribute('referrerpolicy', 'no-referrer-when-downgrade');
          return iframe;
        },
      );
    } catch (e) {
      print('Error registering map view: $e');
    }
  }
  
  static void openMapUrl(String url) {
    try {
      html.window.open(url, '_blank');
    } catch (e) {
      print('Error opening map: $e');
    }
  }
}