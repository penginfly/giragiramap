// continent_map_demo_page.dart
import 'package:flutter/material.dart';
import '../ui/widgets/continent_chip.dart';
import '../ui/widgets/sparkle_pin.dart';
import '../ui/widgets/interactive_sparkle_pin.dart';
import '../../data/dummy_data.dart'; // ダミーデータをインポート

class ContinentMapScrollablePage extends StatefulWidget {
  const ContinentMapScrollablePage({super.key});

  @override
  State<ContinentMapScrollablePage> createState() =>
      _ContinentMapScrollablePageState();
}

class _ContinentMapScrollablePageState
    extends State<ContinentMapScrollablePage> {
  static const Size mapSize = Size(2000, 1200);
  static const double pad = 160;

  // 大陸ごとのワールド座標をMapで定義
  final Map<String, Offset> _continentPositions = {
    "Academics": const Offset(300, 250),
    "Creativity": const Offset(1300, 400),
    "Career": const Offset(700, 900),
    "Health": const Offset(1600, 950),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF87CEEB),
      body: InteractiveViewer(
        minScale: 0.5,
        maxScale: 2.5,
        constrained: false,
        boundaryMargin: const EdgeInsets.all(0),
        clipBehavior: Clip.none,
        child: SizedBox(
          width: mapSize.width + pad * 2,
          height: mapSize.height + pad * 2,
          child: Stack(
            children: [
              const Positioned.fill(
                child: ColoredBox(color: Color(0xFF87CEEB)),
              ),
              Positioned(
                left: pad,
                top: pad,
                width: mapSize.width,
                height: mapSize.height,
                child: Stack(
                  children: [
                    const Positioned.fill(
                      child: ColoredBox(color: Color(0xFF87CEEB)),
                    ),

                    // 大陸チップを配置
                    Positioned(
                      left: _continentPositions["Academics"]!.dx,
                      top: _continentPositions["Academics"]!.dy,
                      child: const ContinentChip(label: "Academics"),
                    ),
                    Positioned(
                      left: _continentPositions["Creativity"]!.dx,
                      top: _continentPositions["Creativity"]!.dy,
                      child: const ContinentChip(label: "Creativity"),
                    ),
                    Positioned(
                      left: _continentPositions["Career"]!.dx,
                      top: _continentPositions["Career"]!.dy,
                      child: const ContinentChip(label: "Career"),
                    ),
                    Positioned(
                      left: _continentPositions["Health"]!.dx,
                      top: _continentPositions["Health"]!.dy,
                      child: const ContinentChip(label: "Health"),
                    ),

                    // ---- ここでローカル座標とワールド座標を組み合わせてピンを動的に配置 ----
                    ...dummyPins.map((pin) {
                      // ピンのカテゴリから、対応する大陸のワールド座標を取得
                      final Offset? continentOffset =
                          _continentPositions[pin['category']];
                      if (continentOffset == null) {
                        return const SizedBox.shrink(); // カテゴリがない場合は何も表示しない
                      }

                      // 大陸のワールド座標 + ピンのローカル座標 = ピンの最終的なワールド座標
                      final double pinWorldX =
                          continentOffset.dx + pin['xPosition'];
                      final double pinWorldY =
                          continentOffset.dy + pin['yPosition'];

                      return Positioned(
                        left: pinWorldX,
                        top: pinWorldY,
                        child: InteractiveSparklePin(
                          pin: SparklePin(
                            baseSize: 18,
                            progress: 1.0,
                            pulse: true,
                          ),
                          visualSize: 18,
                          stemLen: 12,
                          onTap: () {
                            debugPrint('ピンがタップされました: ${pin['title']}');
                          },
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
