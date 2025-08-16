// continent_map_demo_page.dart
import 'package:flutter/material.dart';
import '../ui/widgets/continent_chip.dart';
import '../ui/widgets/sparkle_pin.dart';
import '../ui/widgets/interactive_sparkle_pin.dart';
import '../ui/widgets/pin_tooltip.dart';
import '../../data/dummy_data.dart';
import '../ui/widgets/pin_creation_modal.dart';
import '../ui/widgets/wavy_background.dart'; // ← 追加

class ContinentMapScrollablePage extends StatefulWidget {
  const ContinentMapScrollablePage({super.key});

  @override
  State<ContinentMapScrollablePage> createState() =>
      _ContinentMapScrollablePageState();
}

class _ContinentMapScrollablePageState
    extends State<ContinentMapScrollablePage> {
  // 大陸の座標など（変更なし）
  final GlobalKey _academicsKey = GlobalKey();
  final GlobalKey _creativityKey = GlobalKey();
  final GlobalKey _careerKey = GlobalKey();
  final GlobalKey _healthKey = GlobalKey();

  static const Size mapSize = Size(2000, 1200);
  static const double pad = 160;
  String? _selectedPinId;

  final Map<String, Offset> _continentPositions = const {
    "Academics": Offset(300, 250),
    "Creativity": Offset(1300, 300),
    "Career": Offset(600, 700),
    "Health": Offset(1350, 750),
  };

  // 大陸長押し → モーダル起動（変更なし）
  void _onContinentLongPress(
    String category,
    LongPressStartDetails details,
    GlobalKey key,
  ) {
    final renderBox = key.currentContext!.findRenderObject() as RenderBox;
    final localPosition = renderBox.globalToLocal(details.globalPosition);
    _showPinCreationModal(category, localPosition);
  }

  Future<void> _showPinCreationModal(
    String category,
    Offset localPosition,
  ) async {
    final newPinData = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return PinCreationModal(
          category: category,
          initialPosition: localPosition,
        );
      },
    );

    if (newPinData != null) {
      setState(() => dummyPins.add(newPinData));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              // ← ここを差し替え：1枚画像を左右スライドで“波”
              const Positioned.fill(
                child: TiledWavyBackground(
                  assetPath: "assets/images/wave.png",
                  amplitude: 8, // 揺れ幅
                  period: Duration(seconds: 4), // 往復4秒
                  tileScale: 0.3, // 波の粒を細かく
                ),
              ),

              // マップ本体（大陸・ピンはそのまま）
              Positioned(
                left: pad,
                top: pad,
                width: mapSize.width,
                height: mapSize.height,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // 大陸チップ群（変えてません）
                    Positioned(
                      left: _continentPositions["Academics"]!.dx,
                      top: _continentPositions["Academics"]!.dy,
                      child: ContinentChip(
                        key: _academicsKey,
                        label: "Academics",
                        onLongPressStart: (details) => _onContinentLongPress(
                          "Academics",
                          details,
                          _academicsKey,
                        ),
                      ),
                    ),
                    Positioned(
                      left: _continentPositions["Creativity"]!.dx,
                      top: _continentPositions["Creativity"]!.dy,
                      child: ContinentChip(
                        key: _creativityKey,
                        label: "Creativity",
                        onLongPressStart: (details) => _onContinentLongPress(
                          "Creativity",
                          details,
                          _creativityKey,
                        ),
                      ),
                    ),
                    Positioned(
                      left: _continentPositions["Career"]!.dx,
                      top: _continentPositions["Career"]!.dy,
                      child: ContinentChip(
                        key: _careerKey,
                        label: "Career",
                        onLongPressStart: (details) => _onContinentLongPress(
                          "Career",
                          details,
                          _careerKey,
                        ),
                      ),
                    ),
                    Positioned(
                      left: _continentPositions["Health"]!.dx,
                      top: _continentPositions["Health"]!.dy,
                      child: ContinentChip(
                        key: _healthKey,
                        label: "Health",
                        onLongPressStart: (details) => _onContinentLongPress(
                          "Health",
                          details,
                          _healthKey,
                        ),
                      ),
                    ),

                    // ピン & 吹き出し（dummyPins から描画）
                    ...dummyPins.map((pin) {
                      final cat = pin['category'] as String?;
                      if (cat == null) return const SizedBox.shrink();
                      final continentOffset = _continentPositions[cat];
                      if (continentOffset == null)
                        return const SizedBox.shrink();

                      final double pinWorldX =
                          continentOffset.dx +
                          (pin['xPosition'] as num).toDouble();
                      final double pinWorldY =
                          continentOffset.dy +
                          (pin['yPosition'] as num).toDouble();

                      final String id = '${pin['userId']}${pin['title']}';
                      final bool isSelected = _selectedPinId == id;

                      return Positioned(
                        left: pinWorldX,
                        top: pinWorldY,
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          clipBehavior: Clip.none,
                          children: [
                            if (isSelected)
                              Positioned(
                                bottom: 40,
                                child: PinTooltip(
                                  title: pin['title'] as String? ?? '',
                                  description:
                                      pin['description'] as String? ?? '',
                                  userId: pin['userId'] as String? ?? '',
                                ),
                              ),
                            InteractiveSparklePin(
                              pin: const SparklePin(
                                baseSize: 18,
                                progress: 1.0,
                                pulse: true,
                              ),
                              visualSize: 18,
                              stemLen: 12,
                              onTap: () {
                                setState(() {
                                  _selectedPinId = isSelected ? null : id;
                                });
                                debugPrint('ピン: ${pin['title']} をタップ');
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
