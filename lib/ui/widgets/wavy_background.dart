import 'dart:math' as math;
import 'package:flutter/material.dart';

class TiledWavyBackground extends StatefulWidget {
  final String assetPath;
  final double amplitude;
  final Duration period;
  final double tileScale;
  final double overscan; // 四辺に足す余白

  const TiledWavyBackground({
    super.key,
    required this.assetPath,
    this.amplitude = 12,
    this.period = const Duration(seconds: 3),
    this.tileScale = 0.3,
    this.overscan = 200,
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
  void didUpdateWidget(covariant TiledWavyBackground oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.period != widget.period) {
      _ac.duration = widget.period;
      if (!_ac.isAnimating) _ac.repeat();
    }
  }

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
        final t = _ac.value * 2 * math.pi;
        final dx = math.sin(t) * widget.amplitude;
        final dy = math.cos(t) * (widget.amplitude * 0.25);

        return LayoutBuilder(
          builder: (context, c) {
            final bleed = widget.amplitude * 2 + 24; // 揺れ対策
            final pad = bleed + widget.overscan; // 追加余白
            final w = c.maxWidth + pad * 2;
            final h = c.maxHeight + pad * 2;

            return IgnorePointer(
              child: Transform.translate(
                offset: Offset(-pad + dx, -pad + dy),
                child: OverflowBox(
                  // ← はみ出しOKにする
                  minWidth: w,
                  maxWidth: w,
                  minHeight: h,
                  maxHeight: h,
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    widget.assetPath,
                    repeat: ImageRepeat.repeat,
                    scale: 1 / widget.tileScale,
                    fit: BoxFit.none,
                    filterQuality: FilterQuality.low,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
