import 'package:flutter/material.dart';

class ContinentChip extends StatelessWidget {
  final String label;
  final GestureLongPressStartCallback? onLongPressStart;

  // 基礎デザイン（砂→草）のデフォルト
  final String grassPatternAsset;
  final String sandPatternAsset;
  final double tileScale; // 0.25〜0.5 小さいほど細かく見える
  final double radius; // 草の角丸
  final EdgeInsets margin;
  final Size size;

  const ContinentChip({
    super.key,
    required this.label,
    required this.onLongPressStart,
    this.grassPatternAsset = "assets/images/grass_tile.png",
    this.sandPatternAsset = "assets/images/sand_tile.png",
    this.tileScale = 0.32,
    this.radius = 48,
    this.margin = EdgeInsets.zero,
    this.size = const Size(520, 360),
  });

  @override
  Widget build(BuildContext context) {
    final sandRadius = radius + 10; // 砂は少し大きく（縁取り）
    const grassInset = 14.0; // 砂→草の段差
    final titleStyle = Theme.of(
      context,
    ).textTheme.titleLarge?.copyWith(color: const Color(0xFF2E3A2F));

    return GestureDetector(
      onLongPressStart: onLongPressStart,
      child: Container(
        margin: margin,
        width: size.width,
        height: size.height,
        // 下層：砂
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(sandRadius),
          boxShadow: const [
            BoxShadow(
              blurRadius: 16,
              offset: Offset(0, 8),
              color: Color(0x33000000),
            ),
          ],
          color: const Color(0xFFF4E1B5), // 保険色
          image: DecorationImage(
            image: AssetImage(sandPatternAsset),
            repeat: ImageRepeat.repeat,
            fit: BoxFit.none,
            scale: 1 / tileScale,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(grassInset),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            // 上層：草
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFCDECCF),
                    image: DecorationImage(
                      image: AssetImage(grassPatternAsset),
                      repeat: ImageRepeat.repeat,
                      fit: BoxFit.none,
                      scale: 1 / tileScale,
                    ),
                  ),
                ),
                // ラベル
                Positioned(
                  left: 24,
                  top: 20,
                  child: Text(label, style: titleStyle),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
