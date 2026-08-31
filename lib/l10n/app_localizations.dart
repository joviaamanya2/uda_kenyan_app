// lib/l10n/app_localizations.dart
import 'package:flutter/material.dart';

/// Lightweight, map-based localizations for the UDA app (English + Kiswahili).
/// Add a key to [_values] and use `context.l10n('key')` anywhere.
class AppLocalizations {
  final Locale locale;
  const AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations) ??
      const AppLocalizations(Locale('en'));

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const supportedLocales = [Locale('en'), Locale('sw')];

  static const Map<String, Map<String, String>> _values = {
    'en': {
      'menu_profile': 'Profile',
      'menu_settings': 'Settings',
      'menu_help': 'Help & Support',
      'menu_about': 'About UDA',
      'settings_title': 'Settings',
      'settings_preferences': 'Preferences',
      'settings_language': 'Language',
      'settings_appearance': 'Appearance',
      'settings_theme_system': 'System default',
      'settings_theme_light': 'Light',
      'settings_theme_dark': 'Dark',
      'settings_account': 'Account',
      'settings_about_support': 'About & Support',
      'settings_help': 'Help & Support',
      'settings_about': 'About UDA',
      'settings_version': 'App version',
      'language_choose': 'Choose your language',
      'language_subtitle': 'Select your preferred language to continue',
      'continue': 'Continue',
      'skip': 'Skip for now',
      'save': 'Save',
      'cancel': 'Cancel',
      'done': 'Done',
    },
    'sw': {
      'menu_profile': 'Wasifu',
      'menu_settings': 'Mipangilio',
      'menu_help': 'Msaada',
      'menu_about': 'Kuhusu UDA',
      'settings_title': 'Mipangilio',
      'settings_preferences': 'Mapendeleo',
      'settings_language': 'Lugha',
      'settings_appearance': 'Muonekano',
      'settings_theme_system': 'Chaguo-msingi la mfumo',
      'settings_theme_light': 'Mwangaza',
      'settings_theme_dark': 'Giza',
      'settings_account': 'Akaunti',
      'settings_about_support': 'Kuhusu na Msaada',
      'settings_help': 'Msaada',
      'settings_about': 'Kuhusu UDA',
      'settings_version': 'Toleo la programu',
      'language_choose': 'Chagua lugha yako',
      'language_subtitle': 'Chagua lugha unayopendelea ili kuendelea',
      'continue': 'Endelea',
      'skip': 'Ruka kwa sasa',
      'save': 'Hifadhi',
      'cancel': 'Ghairi',
      'done': 'Sawa',
    },
  };

  String call(String key) {
    final lang = _values.containsKey(locale.languageCode)
        ? locale.languageCode
        : 'en';
    return _values[lang]?[key] ?? _values['en']?[key] ?? key;
  }
}

extension AppLocalizationsX on BuildContext {
  String l10n(String key) => AppLocalizations.of(this)(key);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      const ['en', 'sw'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async =>
      AppLocalizations(locale);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
