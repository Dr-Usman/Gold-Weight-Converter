import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'l10n/app_localizations.dart';
import 'providers/locale_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/converter_screen.dart';
import 'theme/app_theme.dart';
import 'widgets/app_update_listener.dart';

/// Root [MaterialApp] — themes, locale, and home screen.
class GoldWeightConverterApp extends ConsumerWidget {
  const GoldWeightConverterApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeMode themeMode = ref.watch(themeModeProvider);
    final Locale? locale = ref.watch(localeProvider);

    // Sindhi falls back to Urdu for system Material/Cupertino widgets.
    final Locale effectiveLocale = (locale?.languageCode == 'sd')
        ? const Locale('ur')
        : (locale ?? const Locale('en'));

    return MaterialApp(
      title: AppLocalizations.of(context)?.appTitle ?? 'Gold Weight Converter',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: effectiveLocale,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      builder: (context, child) {
        final bool isRomanUrdu =
            effectiveLocale.languageCode == 'ur' &&
            effectiveLocale.countryCode == 'RO';

        final TextDirection direction = isRomanUrdu
            ? TextDirection.ltr
            : Directionality.maybeOf(context) ?? TextDirection.ltr;

        return Directionality(
          textDirection: direction,
          child: AppUpdateListener(
            child: child ?? const SizedBox.shrink(),
          ),
        );
      },
      home: const GoldConverterScreen(),
    );
  }
}

/// Alias for older call sites / tests.
typedef MyApp = GoldWeightConverterApp;
