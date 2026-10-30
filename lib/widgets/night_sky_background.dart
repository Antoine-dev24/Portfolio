import 'dart:math';

import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class NightSkyBackground extends StatelessWidget {
  const NightSkyBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.midnight, AppColors.aubergine, AppColors.abyss],
          stops: [0, 0.55, 1],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          _Glow(
            alignment: const Alignment(0.9, -0.9),
            color: AppColors.orchid.withValues(alpha: 0.16),
          ),
          _Glow(
            alignment: const Alignment(-0.9, 0.9),
            color: AppColors.lagoon.withValues(alpha: 0.10),
          ),
          const RepaintBoundary(child: CustomPaint(painter: _StarsPainter())),
        ],
      ),
    );
  }
}

class _Glow extends StatelessWidget {
  const _Glow({required this.alignment, required this.color});

  final Alignment alignment;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          center: alignment,
          radius: 0.9,
          colors: [color, color.withValues(alpha: 0)],
        ),
      ),
    );
  }
}

class _StarsPainter extends CustomPainter {
  const _StarsPainter();

  @override
  void paint(Canvas canvas, Size size) {
    // Graine fixe : les étoiles gardent la même place à chaque rendu.
    final random = Random(42);
    final paint = Paint();
    for (var i = 0; i < 140; i++) {
      final position = Offset(
        random.nextDouble() * size.width,
        random.nextDouble() * size.height,
      );
      final radius = 0.4 + random.nextDouble() * 1.1;
      paint.color = AppColors.moonlight.withValues(
        alpha: 0.15 + random.nextDouble() * 0.55,
      );
      canvas.drawCircle(position, radius, paint);
    }
  }

  @override
  bool shouldRepaint(_StarsPainter oldDelegate) => false;
}
