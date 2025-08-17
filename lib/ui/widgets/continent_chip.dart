import 'package:flutter/material.dart';

/// 島ごとのメタ情報（旗画像のアセットパスだけ）
class IslandMeta {
  final String flagAsset; // 透明PNGなど
  const IslandMeta({required this.flagAsset});
}

class ContinentChip extends StatelessWidget {
  final int islandIndex;
  final List<IslandMeta> islands;
  final GestureLongPressStartCallback? onLongPressStart;

  // 基礎デザイン（砂→草）
  final String grassPatternAsset;
  final String sandPatternAsset;
  final double tileScale;
  final double radius;
  final EdgeInsets margin;
  final Size size;

  // 旗の表示調整（負の値OK：左上へはみ出し可能）
  final double flagSize;
  final EdgeInsets flagPadding; // left=+右/−左, top=+下/−上

  const ContinentChip({
    super.key,
    required this.islandIndex,
    required this.islands,
    this.onLongPressStart,
    this.grassPatternAsset = "assets/images/grass_tile.png",
    this.sandPatternAsset = "assets/images/sand_tile.png",
    this.tileScale = 0.32,
    this.radius = 48,
    this.margin = EdgeInsets.zero,
    this.size = const Size(520, 360),
    this.flagSize = 40,
    this.flagPadding = const EdgeInsets.fromLTRB(20, 16, 0, 0),
  });

  @override
  Widget build(BuildContext context) {
    final int safeIndex = (0 <= islandIndex && islandIndex < islands.length)
        ? islandIndex
        : 0;
    final meta = islands.isNotEmpty
        ? islands[safeIndex]
        : const IslandMeta(flagAsset: '');

    final sandRadius = radius + 10; // 砂は少し大きく（縁取りっぽく）
    const grassInset = 14.0; // 砂→草の段差

    return GestureDetector(
      onLongPressStart: onLongPressStart,
      child: Container(
        margin: margin,
        width: size.width,
        height: size.height,
        // ★ はみ出し許可
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // ===== 島本体（砂→草） =====
            Positioned.fill(
              child: Container(
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
                    child: Container(
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
                  ),
                ),
              ),
            ),

            // ===== 旗（ClipRRect の外側なので切れない） =====
            if (meta.flagAsset.isNotEmpty)
              Positioned(
                left: flagPadding.left, // X：+右 / −左
                top: flagPadding.top, // Y：+下 / −上
                child: Image.asset(
                  meta.flagAsset,
                  width: flagSize,
                  height: flagSize,
                  fit: BoxFit.contain,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
