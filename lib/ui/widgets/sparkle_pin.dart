import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:giragiramap/theme/colors.dart';

class SparklePin extends StatefulWidget {
  final double baseSize; // 16〜24くらい
  final double progress; // 0..1（大きさに反映）
  final bool pulse; // 鼓動アニメ

  // ▼ 追加（棒ステム）
  final bool showStem; // 棒を出すか
  final double stemLenRatio; // 棒の長さ（円サイズに対する比）
  final double stemThicknessRatio; // 棒の太さ（円サイズに対する比）
  final Color? stemColor; // 棒の色（未指定なら濃いめのrose）

  const SparklePin({
    super.key,
    this.baseSize = 18,
    required this.progress,
    this.pulse = true,
    this.showStem = true,
    this.stemLenRatio = 0.55,
    this.stemThicknessRatio = 0.12,
    this.stemColor,
  });

  @override
  State<SparklePin> createState() => _SparklePinState();
}

class _SparklePinState extends State<SparklePin>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ac = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  )..repeat();

  @override
  void dispose() {
    _ac.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scale = lerpDouble(0.85, 1.3, widget.progress)!;

    return AnimatedBuilder(
      animation: _ac,
      builder: (_, __) {
        final pulse = widget.pulse ? (1 + 0.05 * sin(_ac.value * 2 * pi)) : 1.0;
        final size = widget.baseSize * scale * pulse; // 円の直径ベース
        final stemLen = widget.showStem ? size * widget.stemLenRatio : 0.0;
        final stemThickness = size * widget.stemThicknessRatio;
        final stemColor = widget.stemColor ?? AppColors.rose.withOpacity(0.95);

        return SizedBox(
          width: size,
          // 円 + 棒が下にはみ出す分も高さに含める
          height: size + stemLen,
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              // ---- 本体（円部分） ----
              SizedBox(
                width: size,
                height: size,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // ふわっとした外周グロー
                    Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.rose.withOpacity(0.25),
                            blurRadius: size * 0.6,
                          ),
                        ],
                      ),
                    ),
                    // 本体
                    Container(
                      width: size * 0.9,
                      height: size * 0.9,
                      decoration: BoxDecoration(
                        color: AppColors.rose,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: size * 0.12,
                        ),
                      ),
                    ),
                    // きらめき（小さな星が回転）
                    Transform.rotate(
                      angle: _ac.value * 2 * pi,
                      child: CustomPaint(
                        size: Size.square(size),
                        painter: _SparklePainter(
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ---- 棒（ステム） ----
              if (widget.showStem)
                Positioned(
                  top: size - stemThickness / 2, // 円の真下から生やす
                  child: Container(
                    width: stemThickness,
                    height: stemLen,
                    decoration: BoxDecoration(
                      color: stemColor,
                      borderRadius: BorderRadius.circular(stemThickness), // 丸端
                      boxShadow: [
                        // ほんのりグロー
                        BoxShadow(
                          color: stemColor.withOpacity(0.35),
                          blurRadius: stemThickness * 1.8,
                          spreadRadius: stemThickness * 0.15,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _SparklePainter extends CustomPainter {
  final Color color;
  _SparklePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    final c = Offset(size.width / 2, size.height / 2);
    final r = size.width * 0.42;

    void star(Offset o, double s) {
      final path = Path();
      const n = 4;
      for (int i = 0; i < 2 * n; i++) {
        final ang = i * pi / n;
        final rr = (i.isEven ? s : s * 0.4);
        path.lineTo(o.dx + rr * cos(ang), o.dy + rr * sin(ang));
      }
      path.close();
      canvas.drawPath(path, p);
    }

    // 小さな星を2つ
    star(c.translate(r * 0.55, -r * 0.2), size.width * 0.10);
    star(c.translate(-r * 0.35, r * 0.35), size.width * 0.07);
  }

  @override
  bool shouldRepaint(covariant _SparklePainter old) => false;
}
