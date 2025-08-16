import 'package:flutter/material.dart';
import '../ui/widgets/continent_chip.dart';

class ContinentMapScrollablePage extends StatefulWidget {
  const ContinentMapScrollablePage({super.key});

  @override
  State<ContinentMapScrollablePage> createState() =>
      _ContinentMapScrollablePageState();
}

class _ContinentMapScrollablePageState
    extends State<ContinentMapScrollablePage> {
  static const Size mapSize = Size(2000, 1200);
  static const double pad = 160; // ← ここが安全余白（Chipの最大サイズより少し大きく）

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF87CEEB), // 外側が見えても海色に
      appBar: AppBar(title: const Text("Continent Map (Pan/Zoom)")),
      body: InteractiveViewer(
        minScale: 0.5,
        maxScale: 2.5,
        constrained: false, // 子のサイズをそのまま使う
        boundaryMargin: const EdgeInsets.all(0), // 端で止める（無限パンにしたいなら all(1000)）
        clipBehavior: Clip.none, // はみ出しも表示OK
        child: SizedBox(
          // 地図サイズ + 両端の安全余白
          width: mapSize.width + pad * 2,
          height: mapSize.height + pad * 2,
          child: Stack(
            children: [
              // まず全体を海色で塗る（白チラ見え防止）
              const Positioned.fill(
                child: ColoredBox(color: Color(0xFF87CEEB)),
              ),

              // 中央に「地図本体エリア」を配置（ここが今までの mapSize）
              Positioned(
                left: pad,
                top: pad,
                width: mapSize.width,
                height: mapSize.height,
                child: Stack(
                  children: [
                    // 背景（画像に差し替え可）
                    const Positioned.fill(
                      child: ColoredBox(color: Color(0xFF87CEEB)),
                      // imageにするなら:
                      // DecoratedBox(
                      //   decoration: const BoxDecoration(
                      //     image: DecorationImage(
                      //       image: AssetImage('assets/maps/ocean.png'),
                      //       fit: BoxFit.cover,
                      //     ),
                      //   ),
                      // ),
                    ),

                    // --- 大陸たち（内側に配置）---
                    const Positioned(
                      left: 300,
                      top: 250,
                      child: ContinentChip(label: "Academics"),
                    ),
                    const Positioned(
                      left: 1300,
                      top: 400,
                      child: ContinentChip(label: "Creativity"),
                    ),
                    const Positioned(
                      left: 700,
                      top: 900,
                      child: ContinentChip(label: "Career"),
                    ),
                    const Positioned(
                      left: 1600,
                      top: 950,
                      child: ContinentChip(label: "Health"),
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
