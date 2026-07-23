import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/app_colors.dart';
import 'converter_screen.dart';
import 'l10n/app_localizations.dart';
import 'providers/locale_provider.dart';
import 'providers/theme_provider.dart';
import 'services/analytics_service.dart';
import 'services/preferences_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferencesService = PreferencesService();
  await preferencesService.init();

  // Initialize analytics service
  await AnalyticsService.init();
  AnalyticsService.syncUserPreferences(
    locale: preferencesService.getLocale(),
    themeMode: preferencesService.getThemeMode(),
  );

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

    final Locale? locale = ref.watch(localeProvider);
    //  Decide effective locale (fix unsupported sd)
    final Locale effectiveLocale = (locale?.languageCode == 'sd')
        ? const Locale('ur') // fallback for system widgets
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
      theme: _buildTheme(colorScheme: lightColorScheme),
      darkTheme: _buildTheme(colorScheme: darkColorScheme),
      themeMode: themeMode,
      builder: (context, child) {
        final isRomanUrdu =
            effectiveLocale.languageCode == 'ur' &&
            effectiveLocale.countryCode == 'RO';

        final direction = isRomanUrdu
            ? TextDirection.ltr
            : Directionality.maybeOf(context) ?? TextDirection.ltr;

        return Directionality(
          textDirection: direction,
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const GoldConverterScreen(),
    );
  }
}
