import 'dart:math' as math;
import 'package:flutter/material.dart';

class TiledWavyBackground extends StatefulWidget {
  final String assetPath;
  final double amplitude; // 揺れ幅(px)
  final Duration period; // 往復の周期
  final double tileScale; // 波タイルの大きさ縮小率 (1.0=原寸)

  const TiledWavyBackground({
    super.key,
    required this.assetPath,
    this.amplitude = 12,
    this.period = const Duration(seconds: 3),
    this.tileScale = 0.3, // 小さくするとタイルが細かくなる
  });

  @override
  State<TiledWavyBackground> createState() => _TiledWavyBackgroundState();
}

class _TiledWavyBackgroundState extends State<TiledWavyBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ac = AnimationController(
    vsync: this,
    duration: widget.period,
  )..repeat();

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ac,
      builder: (_, __) {
        final dx = math.sin(_ac.value * 2 * math.pi) * widget.amplitude;

        return ClipRect(
          child: Transform.translate(
            offset: Offset(dx, 0),
            child: Transform.scale(
              scale: 1.05, // はみ出し防止
              child: Image.asset(
                widget.assetPath,
                repeat: ImageRepeat.repeat, // ←ここで敷き詰め！
                scale: 1 / widget.tileScale, // 小さくして並べる
                fit: BoxFit.none,
              ),
            ),
          ),
        );
      },
    );
  }
}
