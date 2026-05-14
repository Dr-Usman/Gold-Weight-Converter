import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/app_colors.dart';
import 'converter_screen.dart';
import 'l10n/app_localizations.dart';
import 'providers/locale_provider.dart';
import 'providers/theme_provider.dart';
import 'services/preferences_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferencesService = PreferencesService();
  await preferencesService.init();

  runApp(
    ProviderScope(
      overrides: [
        preferencesServiceProvider.overrideWithValue(preferencesService),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  /// Resolve locales that aren't supported by Flutter's Material/Cupertino
  /// localizations to appropriate fallbacks
  Locale? _resolveLocale(List<Locale>? locales, Iterable<Locale> supported) {
    if (locales == null || locales.isEmpty) return null;

    final preferredLocale = locales.first;
    final code = preferredLocale.languageCode;

    // Map unsupported locales to fallback locales that Flutter supports
    const Map<String, String> fallbackMap = {
      'ur': 'ar', // Urdu → Arabic
      'rmu': 'ar', // Roman Urdu → Arabic
      'sd': 'ar', // Sindhi → Arabic
      'ps': 'ar', // Pashto → Arabic
      'bn': 'hi', // Bengali → Hindi
      'ms': 'id', // Malay → Indonesian
    };

    // If locale is unsupported, use fallback
    if (fallbackMap.containsKey(code)) {
      final fallbackCode = fallbackMap[code]!;
      return Locale(fallbackCode);
    }

    // Otherwise check if it's directly supported
    for (final supportedLocale in supported) {
      if (supportedLocale.languageCode == code) {
        return supportedLocale;
      }
    }

    // Default to English
    return const Locale('en');
  }

  ThemeData _buildTheme({required ColorScheme colorScheme}) {
    final ThemeData baseTheme = ThemeData(useMaterial3: true);
    final TextTheme bodyText = GoogleFonts.manropeTextTheme(
      baseTheme.textTheme,
    );
    final TextTheme titleText = GoogleFonts.cinzelTextTheme(bodyText);
    final bool isDark = colorScheme.brightness == Brightness.dark;

    return baseTheme.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: isDark
          ? const Color(0xFF171310)
          : AppColors.background,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: isDark
            ? colorScheme.surfaceContainerHigh
            : AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: isDark
                ? colorScheme.outlineVariant
                : AppColors.cardBorder.withValues(alpha: 0.9),
            width: 1.4,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: isDark
                ? colorScheme.outlineVariant
                : AppColors.cardBorder.withValues(alpha: 0.9),
            width: 1.4,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: AppColors.primaryDark, width: 2),
        ),
        hintStyle: TextStyle(
          color: isDark
              ? colorScheme.onSurface.withValues(alpha: 0.55)
              : AppColors.ink.withValues(alpha: 0.45),
        ),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: isDark ? colorScheme.surfaceContainer : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      textTheme: bodyText.copyWith(
        titleLarge: titleText.titleLarge?.copyWith(
          fontSize: 22,
          fontWeight: FontWeight.w700,
          color: colorScheme.onSurface,
        ),
        headlineSmall: titleText.headlineSmall?.copyWith(
          fontWeight: FontWeight.w700,
          color: colorScheme.onSurface,
          letterSpacing: 0.2,
        ),
        bodyLarge: bodyText.bodyLarge?.copyWith(
          fontSize: 16,
          color: colorScheme.onSurface,
          height: 1.45,
        ),
        bodyMedium: bodyText.bodyMedium?.copyWith(
          color: colorScheme.onSurface.withValues(alpha: 0.82),
        ),
        bodySmall: bodyText.bodySmall?.copyWith(
          color: colorScheme.onSurface.withValues(alpha: 0.7),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);

    // Light theme
    final ColorScheme lightColorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      brightness: Brightness.light,
      surface: Colors.white,
      onSurface: AppColors.ink,
    );

    // Dark theme
    final ColorScheme darkColorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      brightness: Brightness.dark,
      surface: const Color(0xFF1E1E1E),
      onSurface: Colors.white,
    );

    final locale = ref.watch(localeProvider);
    return MaterialApp(
      title: 'Gold Weight Converter',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      localeListResolutionCallback: _resolveLocale,
      theme: _buildTheme(colorScheme: lightColorScheme),
      darkTheme: _buildTheme(colorScheme: darkColorScheme),
      themeMode: themeMode,
      locale: locale,
      home: const GoldConverterScreen(),
    );
  }
}
