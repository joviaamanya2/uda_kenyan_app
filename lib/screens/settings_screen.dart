// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../services/app_settings.dart';
import 'about_screen.dart';
import 'contact_screen.dart';
import 'profile_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: AppSettings.instance,
      builder: (context, _) {
        final s = AppSettings.instance;
        final scheme = Theme.of(context).colorScheme;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              context.l10n('settings_title').toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.symmetric(vertical: 8),
            children: [
              _sectionLabel(context, context.l10n('settings_account')),
              _tile(
                context,
                icon: Icons.person_outline,
                title: context.l10n('menu_profile'),
                onTap: () => _push(context, const ProfileScreen()),
              ),

              _sectionLabel(context, context.l10n('settings_preferences')),
              _tile(
                context,
                icon: Icons.translate,
                title: context.l10n('settings_language'),
                subtitle: AppSettings.supportedLanguages[s.languageCode],
                onTap: () => _pickLanguage(context, s),
              ),
              _tile(
                context,
                icon: Icons.brightness_6_outlined,
                title: context.l10n('settings_appearance'),
                subtitle: _themeLabel(context, s.themeMode),
                onTap: () => _pickTheme(context, s),
              ),

              _sectionLabel(context, context.l10n('settings_about_support')),
              _tile(
                context,
                icon: Icons.help_outline,
                title: context.l10n('settings_help'),
                onTap: () => _push(context, const ContactScreen()),
              ),
              _tile(
                context,
                icon: Icons.info_outline,
                title: context.l10n('settings_about'),
                onTap: () => _push(context, const AboutUDAScreen()),
              ),

              const SizedBox(height: 24),
              Center(
                child: Text(
                  '${context.l10n('settings_version')}  1.0.0',
                  style: TextStyle(
                    fontSize: 12,
                    color: scheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  void _push(BuildContext context, Widget screen) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => screen));
  }

  String _themeLabel(BuildContext context, ThemeMode mode) => switch (mode) {
    ThemeMode.light => context.l10n('settings_theme_light'),
    ThemeMode.dark => context.l10n('settings_theme_dark'),
    ThemeMode.system => context.l10n('settings_theme_system'),
  };

  Future<void> _pickLanguage(BuildContext context, AppSettings s) async {
    await _choiceSheet(
      context,
      title: context.l10n('settings_language'),
      options: [
        for (final e in AppSettings.supportedLanguages.entries)
          _Choice(e.value, e.key == s.languageCode, () => s.setLanguage(e.key)),
      ],
    );
  }

  Future<void> _pickTheme(BuildContext context, AppSettings s) async {
    await _choiceSheet(
      context,
      title: context.l10n('settings_appearance'),
      options: [
        for (final mode in ThemeMode.values)
          _Choice(
            _themeLabel(context, mode),
            mode == s.themeMode,
            () => s.setThemeMode(mode),
          ),
      ],
    );
  }

  Future<void> _choiceSheet(
    BuildContext context, {
    required String title,
    required List<_Choice> options,
  }) {
    return showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            for (final o in options)
              ListTile(
                title: Text(o.label),
                trailing: o.selected
                    ? Icon(
                        Icons.check,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : null,
                onTap: () {
                  o.onSelect();
                  Navigator.pop(context);
                },
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 6),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _tile(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: subtitle == null ? null : Text(subtitle),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: onTap,
    );
  }
}

class _Choice {
  final String label;
  final bool selected;
  final VoidCallback onSelect;
  const _Choice(this.label, this.selected, this.onSelect);
}
