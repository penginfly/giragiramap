// continent_map_demo_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../ui/widgets/continent_chip.dart';
import '../ui/widgets/sparkle_pin.dart';
import '../ui/widgets/interactive_sparkle_pin.dart';
import '../ui/widgets/pin_tooltip.dart';
import '../ui/widgets/pin_creation_modal.dart';
import '../../data/dummy_data.dart'; // ダミーデータはまだ使用

class ContinentMapScrollablePage extends StatefulWidget {
  const ContinentMapScrollablePage({super.key});

  @override
  State<ContinentMapScrollablePage> createState() =>
      _ContinentMapScrollablePageState();
}

class _ContinentMapScrollablePageState
    extends State<ContinentMapScrollablePage> {
  // GlobalKeyの定義
  final GlobalKey _academicsKey = GlobalKey();
  final GlobalKey _creativityKey = GlobalKey();
  final GlobalKey _careerKey = GlobalKey();
  final GlobalKey _healthKey = GlobalKey();
  static const Size mapSize = Size(2000, 1200);
  static const double pad = 160;
  String? _selectedPinId;

  // 大陸ごとのワールド座標をMapで定義
  final Map<String, Offset> _continentPositions = {
    "Academics": const Offset(300, 250),
    "Creativity": const Offset(1300, 300),
    "Career": const Offset(600, 700),
    "Health": const Offset(1350, 750),
  };

  // onLongPress コールバックで呼び出される関数
  void _onContinentLongPress(
      String category,
      LongPressStartDetails details,
      GlobalKey key,
      ) {
    final RenderBox renderBox =
    key.currentContext!.findRenderObject() as RenderBox;
    final Offset localPosition = renderBox.globalToLocal(details.globalPosition);

    print('長押しされた大陸: $category');
    print('大陸内のローカル座標: $localPosition');

    _showPinCreationModal(category, localPosition);
  }

  // モーダル画面を表示する関数
  void _showPinCreationModal(String category, Offset localPosition) async {
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
      // ★ Firebaseにデータを追加するロジック
      final pinsCollection = FirebaseFirestore.instance.collection('pins');
      await pinsCollection.add({
        'title': newPinData['title'],
        'description': newPinData['description'],
        'category': newPinData['category'],
        'userId': 'user_a_id', // 仮のユーザーID
        'xPosition': newPinData['xPosition'],
        'yPosition': newPinData['yPosition'],
      });
      setState(() {
        _selectedPinId = null; // 新しいピン作成後は吹き出しを閉じる
      });
    }
  }

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
                      child: ContinentChip(
                        key: _academicsKey,
                        label: "Academics",
                        onLongPressStart: (details) {
                          _onContinentLongPress(
                              "Academics", details, _academicsKey);
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
                          _onContinentLongPress(
                              "Creativity", details, _creativityKey);
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

                    // ★ StreamBuilderを使用してFirebaseからピンを読み込む
                    StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('pins')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const Center(child: Text('データ取得エラー'));
                        }
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        // Firestoreから取得したドキュメントをピンウィジェットに変換
                        final pinWidgets = snapshot.data!.docs.map((doc) {
                          final pin = doc.data() as Map<String, dynamic>;
                          // ★★★ この行を追加 ★★★
                          print("Firestore category: '${pin['category']}'");

                          final String? pinId =
                              doc.id; // ドキュメントIDをピンのIDとして使用
                          final Offset? continentOffset =
                          _continentPositions[pin['category']];

                          // ★★★ この行も追加 ★★★
                          if (continentOffset == null) {
                            print(
                                " continentOffset is null for category: '${pin['category']}'");
                          }

                          if (continentOffset == null || pinId == null) {
                            return const SizedBox.shrink();
                          }

                          // ピンの描画時
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
                                    debugPrint(
                                        'ピンがタップされました: ${pin['title']}');
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