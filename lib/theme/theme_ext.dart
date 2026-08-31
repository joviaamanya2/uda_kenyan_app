// lib/theme/theme_ext.dart
//
// Theme-aware colour helpers so screens can adapt to light/dark without
// hard-coding literals. Use `context.surface`, `context.textMuted`, etc.
import 'package:flutter/material.dart';

extension AppThemeX on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  /// Page / Scaffold background.
  Color get pageBg => Theme.of(this).scaffoldBackgroundColor;

  /// Raised card / list-tile surface (was `Colors.white`).
  Color get surface => isDark ? const Color(0xFF1C1F1D) : Colors.white;

  /// Subtle inset fill (was `Colors.grey.shade50/100`).
  Color get surfaceAlt =>
      isDark ? const Color(0xFF262A28) : const Color(0xFFF2F4F3);

  /// Primary body text (was `Colors.black87` / `Colors.black`).
  Color get textStrong =>
      isDark ? const Color(0xFFECEFEC) : const Color(0xFF1B1B1B);

  /// Secondary / caption text (was `Colors.grey.shade600`).
  Color get textMuted =>
      isDark ? const Color(0xFF9AA6A0) : const Color(0xFF6B7280);

  /// Hairline borders / dividers (was `Colors.grey.shade200/300`).
  Color get hairline =>
      isDark ? const Color(0xFF2C302E) : const Color(0xFFE7E9EC);
}
