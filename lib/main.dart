import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants/app_colors.dart';
import 'converter_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData baseTheme = ThemeData.light(useMaterial3: true);
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      brightness: Brightness.light,
      surface: Colors.white,
      onSurface: AppColors.ink,
    );

    final TextTheme bodyText = GoogleFonts.manropeTextTheme(
      baseTheme.textTheme,
    );
    final TextTheme titleText = GoogleFonts.cinzelTextTheme(bodyText);

    return ProviderScope(
      child: MaterialApp(
        title: 'Gold Weight Converter',
        debugShowCheckedModeBanner: false,
        theme: baseTheme.copyWith(
          colorScheme: colorScheme,
          scaffoldBackgroundColor: AppColors.background,
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
            fillColor: AppColors.surface,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 16,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: AppColors.cardBorder.withValues(alpha: 0.9),
                width: 1.4,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: AppColors.cardBorder.withValues(alpha: 0.9),
                width: 1.4,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(color: AppColors.primaryDark, width: 2),
            ),
            hintStyle: TextStyle(color: AppColors.ink.withValues(alpha: 0.45)),
          ),
          cardTheme: CardThemeData(
            elevation: 0,
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          textTheme: bodyText.copyWith(
            titleLarge: titleText.titleLarge?.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
            ),
            headlineSmall: titleText.headlineSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: AppColors.ink,
              letterSpacing: 0.2,
            ),
            bodyLarge: bodyText.bodyLarge?.copyWith(
              fontSize: 16,
              color: AppColors.ink,
              height: 1.45,
            ),
            bodyMedium: bodyText.bodyMedium?.copyWith(
              color: AppColors.ink.withValues(alpha: 0.82),
            ),
          ),
        ),
        home: const GoldConverterScreen(),
      ),
    );
  }
}
