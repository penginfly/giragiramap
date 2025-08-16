// continent_map_demo_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../ui/widgets/continent_chip.dart';
import '../ui/widgets/sparkle_pin.dart';
import '../ui/widgets/interactive_sparkle_pin.dart';
import '../ui/widgets/pin_tooltip.dart';
import '../ui/widgets/pin_creation_modal.dart';
import '../ui/widgets/wavy_background.dart';

class ContinentMapScrollablePage extends StatefulWidget {
  const ContinentMapScrollablePage({super.key});

  @override
  State<ContinentMapScrollablePage> createState() =>
      _ContinentMapScrollablePageState();
}

class _ContinentMapScrollablePageState
    extends State<ContinentMapScrollablePage> {
  final GlobalKey _academicsKey = GlobalKey();
  final GlobalKey _creativityKey = GlobalKey();
  final GlobalKey _careerKey = GlobalKey();
  final GlobalKey _healthKey = GlobalKey();
  static const Size mapSize = Size(2000, 1200);
  static const double pad = 160;
  String? _selectedPinId;

  final Map<String, Offset> _continentPositions = {
    "Academics": const Offset(300, 250),
    "Creativity": const Offset(1300, 300),
    "Career": const Offset(600, 700),
    "Health": const Offset(1350, 750),
  };

  void _onContinentLongPress(
      String category,
      LongPressStartDetails details,
      GlobalKey key,
      ) {
    final RenderBox renderBox =
    key.currentContext!.findRenderObject() as RenderBox;
    final Offset localPosition = renderBox.globalToLocal(
      details.globalPosition,
    );

    _showPinCreationModal(category, localPosition);
  }

  // ピン作成時の処理は変更なし（ログインユーザーのIDを保存するまま）
  void _showPinCreationModal(String category, Offset localPosition) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('ピンを作成するにはログインが必要です。')),
      );
      return;
    }

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
      final pinsCollection = FirebaseFirestore.instance.collection('pins');
      await pinsCollection.add({
        'title': newPinData['title'],
        'description': newPinData['description'],
        'category': newPinData['category'],
        'userId': currentUser.uid, // 正しくログインユーザーのIDが使われる
        'xPosition': newPinData['xPosition'],
        'yPosition': newPinData['yPosition'],
      });
      setState(() {
        _selectedPinId = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

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
              // ... (背景や大陸チップのUI部分は変更なし) ...
              const Positioned.fill(
                child: ColoredBox(color: Color(0xFF87CEEB)),
              ),
              Positioned.fill(child: ColoredBox(color: Color(0xFF87CEEB))),
              Positioned.fill(
                child: TiledWavyBackground(
                  assetPath: 'assets/images/wave.png',
                  tileScale: 0.30,
                  amplitude: 12,
                  overscan: 200,
                  period: const Duration(seconds: 3),
                ),
              ),
              Positioned(
                left: pad,
                top: pad,
                width: mapSize.width,
                height: mapSize.height,
                child: Stack(
                  children: [
                    Positioned(
                      left: _continentPositions["Academics"]!.dx,
                      top: _continentPositions["Academics"]!.dy,
                      child: ContinentChip(
                        key: _academicsKey,
                        label: "Academics",
                        onLongPressStart: (details) {
                          _onContinentLongPress("Academics", details, _academicsKey);
                        },
                      ),
                    ),
                    Positioned(
                      left: _continentPositions["Creativity"]!.dx,
                      top: _continentPositions["Creativity"]!.dy,
                      child: ContinentChip(
                        key: _creativityKey,
                        label: "Creativity",
                        onLongPressStart: (details) {
                          _onContinentLongPress("Creativity", details, _creativityKey);
                        },
                      ),
                    ),
                    Positioned(
                      left: _continentPositions["Career"]!.dx,
                      top: _continentPositions["Career"]!.dy,
                      child: ContinentChip(
                        key: _careerKey,
                        label: "Career",
                        onLongPressStart: (details) {
                          _onContinentLongPress("Career", details, _careerKey);
                        },
                      ),
                    ),
                    Positioned(
                      left: _continentPositions["Health"]!.dx,
                      top: _continentPositions["Health"]!.dy,
                      child: ContinentChip(
                        key: _healthKey,
                        label: "Health",
                        onLongPressStart: (details) {
                          _onContinentLongPress("Health", details, _healthKey);
                        },
                      ),
                    ),

                    // ▼▼▼ ここを変更 ▼▼▼
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('pins')
                      // .where('userId', isEqualTo: currentUser.uid) // ← この行を削除またはコメントアウト
                          .snapshots(),
                      builder: (context, snapshot) {
                        // ... (builder以下のロジックは変更なし) ...
                        if (snapshot.hasError) {
                          return const Center(child: Text('データ取得エラー'));
                        }
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        final pinWidgets = snapshot.data!.docs.map((doc) {
                          final pin = doc.data() as Map<String, dynamic>;
                          final String? pinId = doc.id;
                          final Offset? continentOffset =
                          _continentPositions[pin['category']];

                          if (continentOffset == null || pinId == null) {
                            return const SizedBox.shrink();
                          }

                          final double pinWorldX =
                              continentOffset.dx + pin['xPosition'];
                          final double pinWorldY =
                              continentOffset.dy + pin['yPosition'];
                          final bool isSelected = _selectedPinId == pinId;

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
                                      title: pin['title'],
                                      description: pin['description'],
                                      userId: pin['userId'],
                                    ),
                                  ),
                                InteractiveSparklePin(
                                  pin: SparklePin(
                                    baseSize: 18,
                                    progress: 1.0,
                                    pulse: true,
                                  ),
                                  visualSize: 18,
                                  stemLen: 12,
                                  onTap: () {
                                    setState(() {
                                      _selectedPinId = isSelected ? null : pinId;
                                    });
                                  },
                                ),
                              ],
                            ),
                          );
                        }).toList();
                        return Stack(children: pinWidgets);
                      },
                    ),
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