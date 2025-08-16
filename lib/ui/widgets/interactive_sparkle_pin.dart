import 'package:flutter/material.dart';

/// SparklePin をそのまま中に入れて、
/// 1) 広めのヒット領域（hitPadding）
/// 2) 下に落ちる影（drop shadow）
/// 3) onTap コールバック
/// を足すだけのラッパー。
class InteractiveSparklePin extends StatelessWidget {
  final Widget pin; // 中に SparklePin を入れる
  final VoidCallback? onTap;
  final double visualSize; // ピンの見た目直径（baseSize等と同じ程度）
  final double stemLen; // ステム分の高さ（なければ 0）
  final double hitPadding; // ヒット領域の余白(px)
  final bool showDropShadow; // 落ち影を出すか
  final double shadowScaleY; // 影の縦つぶし率（0.25〜0.5くらい）

  const InteractiveSparklePin({
    super.key,
    required this.pin,
    required this.visualSize,
    this.stemLen = 0,
    this.onTap,
    this.hitPadding = 14,
    this.showDropShadow = true,
    this.shadowScaleY = 0.35,
  });

  @override
  Widget build(BuildContext context) {
    final totalH = visualSize + stemLen;

    return SizedBox(
      width: visualSize + hitPadding * 2,
      height: totalH + hitPadding * 2,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // ---- 落ち影（地面に落ちる影）----
          if (showDropShadow)
            Positioned(
              top: visualSize * 0.88 + hitPadding,
              child: Transform.scale(
                scaleY: shadowScaleY,
                child: Container(
                  width: visualSize * 0.72,
                  height: visualSize * 0.72,
                  decoration: const BoxDecoration(shape: BoxShape.circle),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 16,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // ---- ヒット領域 + 本体 ----
          Positioned.fill(
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: onTap,
                splashColor: Colors.white24,
                highlightColor: Colors.transparent,
                child: Padding(
                  padding: EdgeInsets.all(hitPadding),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: visualSize,
                      height: totalH,
                      child: pin,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
