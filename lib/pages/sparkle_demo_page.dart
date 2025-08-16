import 'package:flutter/material.dart';
import '../ui/widgets/sparkle_pin.dart';
import '../ui/widgets/interactive_sparkle_pin.dart';

class SparkleDemoPage extends StatefulWidget {
  const SparkleDemoPage({super.key});

  @override
  State<SparkleDemoPage> createState() => _SparkleDemoPageState();
}

class _SparkleDemoPageState extends State<SparkleDemoPage> {
  double _progress = 0.5;
  bool _pulse = true;

  // タップされた座標（プレイグラウンド内のローカル座標）
  Offset? _pinPos;

  @override
  Widget build(BuildContext context) {
    // 見た目の直径とステム長（SparklePin側と対応）
    final baseSize = 24.0;
    final stemLen = baseSize * 0.55;
    final hitPadding = 18.0;

    // ピンの先端をタップ位置に合わせるためのオフセット
    // left は「中央合わせ」なので baseSize/2
    // top は「先端合わせ」なので (baseSize + stemLen)
    double anchorLeft(double x) => x - baseSize / 2;
    double anchorTop(double y) => y - (baseSize + stemLen);

    return Scaffold(
      appBar: AppBar(title: const Text('SparklePin Demo')),
      body: Column(
        children: [
          // ==== タップしてピンを置くプレイグラウンド ====
          Container(
            color: const Color(0xFFF5F5F7),
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: 280, // お好みで
              child: Stack(
                children: [
                  // タップ検出レイヤー（全面）
                  Positioned.fill(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTapDown: (details) {
                        setState(() {
                          _pinPos = details.localPosition;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Pin placed at: '
                              '${details.localPosition.dx.toStringAsFixed(0)}, '
                              '${details.localPosition.dy.toStringAsFixed(0)}',
                            ),
                            duration: const Duration(milliseconds: 700),
                          ),
                        );
                      },
                    ),
                  ),

                  // ピン（置かれていれば表示）
                  if (_pinPos != null)
                    Positioned(
                      left: anchorLeft(_pinPos!.dx),
                      top: anchorTop(_pinPos!.dy),
                      child: InteractiveSparklePin(
                        visualSize: baseSize,
                        stemLen: stemLen,
                        hitPadding: hitPadding,
                        showDropShadow: true,
                        // ここでタップ時の再配置にしてもOK（今回は置きっぱなし）
                        onTap: () => debugPrint('Pin tapped!'),
                        pin: SparklePin(
                          baseSize: baseSize,
                          progress: _progress,
                          pulse: _pulse,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // ==== コントロールUI ====
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text('Size progress'),
                    Expanded(
                      child: Slider(
                        value: _progress,
                        min: 0,
                        max: 1,
                        onChanged: (v) => setState(() => _progress = v),
                      ),
                    ),
                    Text(_progress.toStringAsFixed(2)),
                  ],
                ),
                SwitchListTile(
                  title: const Text('Pulse (鼓動アニメ)'),
                  value: _pulse,
                  onChanged: (v) => setState(() => _pulse = v),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => setState(() => _pinPos = null),
                      child: const Text('Clear pin'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
