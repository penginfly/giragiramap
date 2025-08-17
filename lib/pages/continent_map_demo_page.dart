// continent_map_demo_page.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../ui/widgets/continent_chip.dart'; // ← 旗のみ表示版に更新済みのものを使用
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
  // ==== 島メタ（旗だけ） ====
  // アセット名は手元のファイルに合わせて調整してください
  static const islands = <IslandMeta>[
    IslandMeta(flagAsset: 'assets/flags/flag_academics.png'), // 0
    IslandMeta(flagAsset: 'assets/flags/flag_creativity.png'), // 1
    IslandMeta(flagAsset: 'assets/flags/flag_career.png'), // 2
    IslandMeta(flagAsset: 'assets/flags/flag_health.png'), // 3
  ];

  // Firestore で使うカテゴリ文字列（従来互換）
  static const categories = <String>[
    'Academics',
    'Creativity',
    'Career',
    'Health',
  ];

  // キー（長押し位置計算用）
  final GlobalKey _academicsKey = GlobalKey();
  final GlobalKey _creativityKey = GlobalKey();
  final GlobalKey _careerKey = GlobalKey();
  final GlobalKey _healthKey = GlobalKey();

  // マップサイズ＆余白
  static const Size mapSize = Size(2000, 1200);
  static const double pad = 160;

  String? _selectedPinId;

  // 島の基準座標（左上）
  final Map<String, Offset> _continentPositions = const {
    'Academics': Offset(300, 0),
    'Creativity': Offset(1300, 400),
    'Career': Offset(600, 700),
    'Health': Offset(1500, 900),
  };

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
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('ピンを作成するにはログインが必要です。')));
      return;
    }

    final newPinData = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) =>
          PinCreationModal(category: category, initialPosition: localPosition),
    );

    if (newPinData != null) {
      await FirebaseFirestore.instance.collection('pins').add({
        'title': newPinData['title'],
        'description': newPinData['description'],
        'category': newPinData['category'], // categories のいずれか
        'userId': currentUser.uid,
        'xPosition': newPinData['xPosition'],
        'yPosition': newPinData['yPosition'],
      });
      setState(() => _selectedPinId = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ベース色（波タイルの隙間が見えても目立たない海色）
      backgroundColor: const Color(0xFF87CEEB),
      body: InteractiveViewer(
        minScale: 0.5,
        maxScale: 2.5,
        constrained: false,
        boundaryMargin: EdgeInsets.zero,
        clipBehavior: Clip.none,
        child: SizedBox(
          width: mapSize.width + pad * 2,
          height: mapSize.height + pad * 2,
          child: Stack(
            children: [
              // ==== 海の背景：タイルを左右に揺らす ====
              Positioned.fill(
                child: TiledWavyBackground(
                  assetPath: 'assets/images/wave.png',
                  tileScale: 0.30,
                  amplitude: 12,
                  overscan: 200,
                  period: const Duration(seconds: 3),
                ),
              ),

              // ==== マップ本体（島＆ピン）====
              Positioned(
                left: pad,
                top: pad,
                width: mapSize.width,
                height: mapSize.height,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // --- 島（テキスト無し／旗だけ） ---
                    Positioned(
                      left: _continentPositions['Academics']!.dx,
                      top: _continentPositions['Academics']!.dy,
                      child: ContinentChip(
                        key: _academicsKey,
                        islandIndex: 0, // ← インデックスで指定
                        islands: islands,
                        onLongPressStart: (d) => _onContinentLongPress(
                          categories[0], // 'Academics'
                          d,
                          _academicsKey,
                        ),
                        tileScale: 0.32,
                        radius: 48,
                        size: const Size(520, 360),
                        flagSize: 300, // 旗サイズ調整OK
                        flagPadding: const EdgeInsets.fromLTRB(-30, -180, 0, 0),
                      ),
                    ),
                    Positioned(
                      left: _continentPositions['Creativity']!.dx,
                      top: _continentPositions['Creativity']!.dy,
                      child: ContinentChip(
                        key: _creativityKey,
                        islandIndex: 1,
                        islands: islands,
                        onLongPressStart: (d) => _onContinentLongPress(
                          categories[1],
                          d,
                          _creativityKey,
                        ),
                        tileScale: 0.32,
                        radius: 48,
                        size: const Size(520, 360),
                        flagSize: 300,
                        flagPadding: const EdgeInsets.fromLTRB(-30, -180, 0, 0),
                      ),
                    ),
                    Positioned(
                      left: _continentPositions['Career']!.dx,
                      top: _continentPositions['Career']!.dy,
                      child: ContinentChip(
                        key: _careerKey,
                        islandIndex: 2,
                        islands: islands,
                        onLongPressStart: (d) =>
                            _onContinentLongPress(categories[2], d, _careerKey),
                        tileScale: 0.32,
                        radius: 48,
                        size: const Size(520, 360),
                        flagSize: 300,
                        flagPadding: const EdgeInsets.fromLTRB(-30, -180, 0, 0),
                      ),
                    ),
                    Positioned(
                      left: _continentPositions['Health']!.dx,
                      top: _continentPositions['Health']!.dy,
                      child: ContinentChip(
                        key: _healthKey,
                        islandIndex: 3,
                        islands: islands,
                        onLongPressStart: (d) =>
                            _onContinentLongPress(categories[3], d, _healthKey),
                        tileScale: 0.32,
                        radius: 48,
                        size: const Size(520, 360),
                        flagSize: 300,
                        flagPadding: const EdgeInsets.fromLTRB(-30, -180, 0, 0),
                      ),
                    ),

                    // --- Firestoreのピンを描画 ---
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
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        final pinWidgets = snapshot.data!.docs.map((doc) {
                          final pin = doc.data() as Map<String, dynamic>;
                          final pinId = doc.id;

                          final continentOffset =
                              _continentPositions[pin['category']];
                          if (continentOffset == null) {
                            // 未知カテゴリはスキップ
                            return const SizedBox.shrink();
                          }

                          final double pinWorldX =
                              continentOffset.dx +
                              (pin['xPosition'] as num).toDouble();
                          final double pinWorldY =
                              continentOffset.dy +
                              (pin['yPosition'] as num).toDouble();
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
                                      title: pin['title'] ?? '',
                                      description: pin['description'] ?? '',
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
                                      _selectedPinId = isSelected
                                          ? null
                                          : pinId;
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
