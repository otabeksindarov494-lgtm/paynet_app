import 'package:flutter/material.dart';

class BottomSheetBorder extends StatelessWidget {
  const BottomSheetBorder({
    super.key,
    required this.child,
    this.topRadius = 30,
    this.borderWidth = 1.5,
    this.fill = const Color(0xFF2B2B2B),
    this.accent = const Color(0xFF54C59C),
  });

  final Widget child;
  final double topRadius;
  final double borderWidth;

  final Color fill;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.vertical(top: Radius.circular(topRadius));

    return DecoratedBox(
      decoration: BoxDecoration(
        color: fill,
        borderRadius: radius,
      ),
      child: CustomPaint(
        foregroundPainter: _TopGradientBorderPainter(
          topRadius: topRadius,
          strokeWidth: borderWidth,
          fill: fill,
          accent: accent,
        ),
        child: ClipRRect(
          borderRadius: radius,
          child: child,
        ),
      ),
    );
  }
}

class _TopGradientBorderPainter extends CustomPainter {
  const _TopGradientBorderPainter({
    required this.topRadius,
    required this.strokeWidth,
    required this.fill,
    required this.accent,
  });

  final double topRadius;
  final double strokeWidth;
  final Color fill;
  final Color accent;

  @override
  void paint(Canvas canvas, Size size) {
    final inset = strokeWidth / 2;
    final rect = Rect.fromLTWH(
      inset,
      inset,
      size.width - strokeWidth,
      size.height - strokeWidth,
    );

    final path = Path()
      ..moveTo(rect.left + topRadius, rect.top)
      ..lineTo(rect.right - topRadius, rect.top)
      ..arcToPoint(
        Offset(rect.right, rect.top + topRadius),
        radius: Radius.circular(topRadius),
      )
      ..lineTo(rect.right, rect.bottom);

    final shader = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [accent, fill],
      stops: const [0.0, 1.0],
    ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true
      ..shader = shader;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _TopGradientBorderPainter old) =>
      old.topRadius != topRadius ||
          old.strokeWidth != strokeWidth ||
          old.fill != fill ||
          old.accent != accent;
}