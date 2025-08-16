// continent_map_demo_page.dart
import 'package:flutter/material.dart';
import '../ui/widgets/continent_chip.dart';
import '../ui/widgets/sparkle_pin.dart';
import '../ui/widgets/interactive_sparkle_pin.dart';
import '../ui/widgets/pin_tooltip.dart'; // ★ 追加: 吹き出しウィジェット
import '../../data/dummy_data.dart';

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

  // 選択されたピンのIDを保持するステート変数
  String? _selectedPinId;

  // 大陸ごとのワールド座標をMapで定義
  final Map<String, Offset> _continentPositions = {
    "Academics": const Offset(300, 250),
    "Creativity": const Offset(1300, 300),
    "Career": const Offset(600, 700),
    "Health": const Offset(1350, 750),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF87CEEB),
      appBar: AppBar(title: const Text("Continent Map (Pan/Zoom)")),
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

                    // ピンと吹き出しを動的に配置
                    ...dummyPins.map((pin) {
                      final Offset? continentOffset = _continentPositions[pin['category']];
                      if (continentOffset == null) {
                        return const SizedBox.shrink();
                      }

                      final double pinWorldX = continentOffset.dx + pin['xPosition'];
                      final double pinWorldY = continentOffset.dy + pin['yPosition'];

                      // ピンのIDを使い、選択されているか判定
                      final bool isSelected = _selectedPinId == pin['userId'] + pin['title'];

                      return Positioned(
                        left: pinWorldX,
                        top: pinWorldY,
                        // Stackでピンと吹き出しを重ねる
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          clipBehavior: Clip.none,
                          children: [
                            // 吹き出し
                            if (isSelected)
                              Positioned(
                                bottom: 40, // ピンからのオフセット
                                child: PinTooltip(
                                  title: pin['title'],
                                  description: pin['description'],
                                  userId: pin['userId'],
                                ),
                              ),

                            // ピン本体
                            InteractiveSparklePin(
                              pin: SparklePin(
                                baseSize: 18,
                                progress: 1.0,
                                pulse: true,
                              ),
                              visualSize: 18,
                              stemLen: 12,
                              onTap: () {
                                // タップされたピンのIDをセット
                                setState(() {
                                  _selectedPinId = isSelected ? null : pin['userId'] + pin['title'];
                                });
                                debugPrint('ピンがタップされました: ${pin['title']}');
                              },
                            ),
                          ],
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