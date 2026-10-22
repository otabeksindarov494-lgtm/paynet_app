import 'dart:math' as math;

import 'package:flutter/material.dart';

class CancelRequestButton extends StatelessWidget {
  const CancelRequestButton({
    super.key,
    required this.label,
    this.onPressed,
    this.height = 60,
    this.borderRadius = 20,
    this.borderWidth = 1.5,
    this.fontSize = 16,
    this.fontFamily,
  });

  final String label;
  final VoidCallback? onPressed;
  final double height;
  final double borderRadius;
  final double borderWidth;
  final double fontSize;
  final String? fontFamily;

  static const Color fill = Color(0xFF2B2B2B);

  static const Color accent = Color(0xFFCB3A32);

  static const Color highlight = Color(0xFF525252);

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(borderRadius);

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
          BoxShadow(
            color: accent.withValues(alpha: 0.12),
            blurRadius: 12,
            spreadRadius: -8,
            offset: const Offset(7, 0),
          ),
        ],
      ),
      child: Material(
        color: fill,
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: CustomPaint(
            foregroundPainter: _GradientBorderPainter(
              radius: borderRadius,
              strokeWidth: borderWidth,
            ),
            child: SizedBox(
              height: height,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    label,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.2,
                      fontFamily: fontFamily,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _GradientBorderPainter extends CustomPainter {
  const _GradientBorderPainter({
    required this.radius,
    required this.strokeWidth,
  });

  final double radius;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final inset = strokeWidth / 2;
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(
      rect.deflate(inset),
      Radius.circular(radius - inset),
    );

    const c = CancelRequestButton.fill;
    const red = CancelRequestButton.accent;
    const hi = CancelRequestButton.highlight;

    final shader = SweepGradient(
      startAngle: 0,
      endAngle: 2 * math.pi,
      colors: const [
        red,
        c,
        c,
        hi,
        hi,
        hi,
        red,
        red,
      ],
      stops: const [0.00, 0.03, 0.46, 0.50, 0.62, 0.82, 0.95, 1.00],
      transform: const GradientRotation(0),
    ).createShader(rect);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true
      ..shader = shader;

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(_GradientBorderPainter old) =>
      old.radius != radius || old.strokeWidth != strokeWidth;
}