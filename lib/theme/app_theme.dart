import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';

/// Light / dark [ThemeData] and matching [ColorScheme]s for the app.
class AppTheme {
  const AppTheme._();

  static ColorScheme get lightColorScheme => ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    brightness: Brightness.light,
    surface: Colors.white,
    onSurface: AppColors.ink,
  );

  static ColorScheme get darkColorScheme => ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    brightness: Brightness.dark,
    surface: const Color(0xFF1E1E1E),
    onSurface: Colors.white,
  );

  static ThemeData light() => build(colorScheme: lightColorScheme);

  static ThemeData dark() => build(colorScheme: darkColorScheme);

  static ThemeData build({required ColorScheme colorScheme}) {
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
        titleMedium: bodyText.titleMedium?.copyWith(
          color: colorScheme.onSurface,
        ),
        titleSmall: bodyText.titleSmall?.copyWith(color: colorScheme.onSurface),
        headlineSmall: titleText.headlineSmall?.copyWith(
          fontWeight: FontWeight.w700,
          color: colorScheme.onSurface,
          letterSpacing: 0.2,
        ),
        labelLarge: bodyText.labelLarge?.copyWith(
          color: colorScheme.onSurface.withValues(alpha: 0.88),
        ),
        labelMedium: bodyText.labelMedium?.copyWith(
          color: colorScheme.onSurface.withValues(alpha: 0.82),
        ),
        labelSmall: bodyText.labelSmall?.copyWith(
          color: colorScheme.onSurface.withValues(alpha: 0.75),
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
}
