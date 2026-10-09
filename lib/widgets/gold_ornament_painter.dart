import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

/// A custom painter that draws subtle luxury gold geometric rosettes and
/// watermark ornaments for screen backgrounds.
class GoldOrnamentPainter extends CustomPainter {
  final bool isDark;

  const GoldOrnamentPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final Color ornamentColor = isDark
        ? const Color(0xFFF5D77F).withValues(alpha: 0.16)
        : AppColors.primaryDark.withValues(alpha: 0.13);

    final Paint strokePaint = Paint()
      ..color = ornamentColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3;

    final Paint accentPaint = Paint()
      ..color = isDark
          ? const Color(0xFFF5D77F).withValues(alpha: 0.22)
          : AppColors.primaryDark.withValues(alpha: 0.18)
      ..style = PaintingStyle.fill;

    // Top-Right Rosette Ornament
    _drawRosette(
      canvas,
      Offset(size.width * 0.95, 30),
      145,
      strokePaint,
      accentPaint,
    );

    // Bottom-Left Rosette Ornament
    _drawRosette(
      canvas,
      Offset(size.width * 0.05, size.height * 0.85),
      120,
      strokePaint,
      accentPaint,
    );

    // Decorative diamond flourish points
    _drawDiamond(canvas, const Offset(24, 24), 8, strokePaint);
    _drawDiamond(canvas, Offset(size.width - 24, 24), 8, strokePaint);
    _drawDiamond(canvas, Offset(24, size.height - 24), 8, strokePaint);
    _drawDiamond(
      canvas,
      Offset(size.width - 24, size.height - 24),
      8,
      strokePaint,
    );
  }

  void _drawRosette(
    Canvas canvas,
    Offset center,
    double radius,
    Paint stroke,
    Paint fillAccent,
  ) {
    // Center gem accent
    _drawDiamond(canvas, center, 6, fillAccent);

    // Concentric rings
    canvas.drawCircle(center, radius, stroke);
    canvas.drawCircle(center, radius * 0.75, stroke);
    canvas.drawCircle(center, radius * 0.5, stroke);
    canvas.drawCircle(center, radius * 0.25, stroke);

    // 8-pointed star / diamond petals
    const int points = 8;
    final Path starPath = Path();
    for (int i = 0; i < points * 2; i++) {
      final double r = i.isEven ? radius * 0.88 : radius * 0.48;
      final double angle = (i * math.pi) / points;
      final double x = center.dx + r * math.cos(angle);
      final double y = center.dy + r * math.sin(angle);
      if (i == 0) {
        starPath.moveTo(x, y);
      } else {
        starPath.lineTo(x, y);
      }
    }
    starPath.close();
    canvas.drawPath(starPath, stroke);

    // Second rotated interlaced star
    final Path starPath2 = Path();
    for (int i = 0; i < points * 2; i++) {
      final double r = i.isEven ? radius * 0.65 : radius * 0.35;
      final double angle = (i * math.pi) / points + (math.pi / points / 2);
      final double x = center.dx + r * math.cos(angle);
      final double y = center.dy + r * math.sin(angle);
      if (i == 0) {
        starPath2.moveTo(x, y);
      } else {
        starPath2.lineTo(x, y);
      }
    }
    starPath2.close();
    canvas.drawPath(starPath2, stroke);
  }

  void _drawDiamond(Canvas canvas, Offset origin, double size, Paint paint) {
    final Path diamond = Path()
      ..moveTo(origin.dx, origin.dy - size)
      ..lineTo(origin.dx + size, origin.dy)
      ..lineTo(origin.dx, origin.dy + size)
      ..lineTo(origin.dx - size, origin.dy)
      ..close();
    canvas.drawPath(diamond, paint);
  }

  @override
  bool shouldRepaint(covariant GoldOrnamentPainter oldDelegate) =>
      oldDelegate.isDark != isDark;
}
