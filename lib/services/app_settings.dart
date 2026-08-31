// lib/services/app_settings.dart
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

/// App-wide user preferences: interface language and light/dark theme.
/// A [ChangeNotifier] so `MaterialApp` rebuilds when either changes; persisted
/// to a small JSON file so the choice survives app restarts.
class AppSettings extends ChangeNotifier {
  AppSettings._();
  static final AppSettings instance = AppSettings._();

  static const supportedLanguages = {'en': 'English', 'sw': 'Kiswahili'};

  ThemeMode _themeMode = ThemeMode.system;
  String _languageCode = 'en';

  ThemeMode get themeMode => _themeMode;
  String get languageCode => _languageCode;
  Locale get locale => Locale(_languageCode);

  Future<void> load() async {
    try {
      final file = await _file();
      if (await file.exists()) {
        final data = jsonDecode(await file.readAsString());
        if (data is Map) {
          final lang = data['language']?.toString();
          if (lang != null && supportedLanguages.containsKey(lang)) {
            _languageCode = lang;
          }
          switch (data['theme']?.toString()) {
            case 'light':
              _themeMode = ThemeMode.light;
              break;
            case 'dark':
              _themeMode = ThemeMode.dark;
              break;
            default:
              _themeMode = ThemeMode.system;
          }
        }
      }
    } catch (_) {
      // fall back to defaults
    }
  }

  Future<void> setLanguage(String code) async {
    if (!supportedLanguages.containsKey(code) || code == _languageCode) return;
    _languageCode = code;
    notifyListeners();
    await _save();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (mode == _themeMode) return;
    _themeMode = mode;
    notifyListeners();
    await _save();
  }

  Future<File> _file() async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/uda_app_settings.json');
  }

  Future<void> _save() async {
    try {
      final file = await _file();
      await file.writeAsString(
        jsonEncode({
          'language': _languageCode,
          'theme': switch (_themeMode) {
            ThemeMode.light => 'light',
            ThemeMode.dark => 'dark',
            ThemeMode.system => 'system',
          },
        }),
      );
    } catch (_) {}
  }
}
