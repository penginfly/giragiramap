// lib/pages/main_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'mylist_page.dart';
import 'continent_map_demo_page.dart';
import 'user_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1; // 真ん中のMapを初期表示

  final _pages = const [
    MyListPage(), // 0: My Pins
    ContinentMapScrollablePage(), // 1: Map
    UserPage(), // 2: User
  ];

  // AppBarタイトル用の雲画像
  static const _titleImages = <String>[
    'assets/images/mypins_cloud.png', // My Pins
    'assets/images/map_cloud.png', // Map
    'assets/images/user_cloud.png', // User
  ];

  static const _fallbackLabels = <String>['My Pins', 'Map', 'User'];

  // ナビゲーション用 透過PNG（背景なし）
  static const _btnUser = 'assets/icons/icon_home.png';
  static const _btnList = 'assets/icons/icon_list.png';
  static const _btnMapBig = 'assets/icons/icon_map.png';

  Widget _buildAppBarTitle() {
    final path = _titleImages[_selectedIndex];
    return SizedBox(
      key: ValueKey(path),
      height: 100, // 雲タイトルを大きめに
      child: Image.asset(
        path,
        fit: BoxFit.contain,
        errorBuilder: (_, __, ___) => Text(_fallbackLabels[_selectedIndex]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 本文をAppBarの背面まで広げる（雲とボタンだけが上に重なる）
      extendBodyBehindAppBar: true,

      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 140, // 雲タイトルと同じ高さに左/右ボタンを揃える
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle.dark,

        // 左上：ユーザーボタン（家アイコンを大きめに表示）
        leadingWidth: 96, // ← 余裕を持たせる
        leading: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: _TapImageButton(
            path: _btnUser,
            size: 56, // ← 家のアイコンサイズ
            onTap: () => setState(() => _selectedIndex = 2), // User
          ),
        ),

        // 右上：リストボタン（小さめに表示）
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: _TapImageButton(
              path: _btnList,
              size: 64, // ← リストのアイコンサイズ
              onTap: () => setState(() => _selectedIndex = 0), // My Pins
            ),
          ),
        ],

        // 中央：雲タイトル（選択中ページに合わせて切替）
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: _buildAppBarTitle(),
        ),
      ),

      body: Stack(
        children: [
          // ページ本体
          IndexedStack(index: _selectedIndex, children: _pages),

          // 下中央：大きいMapボタン（透過画像）
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: _TapImageButton(
                  path: _btnMapBig,
                  size: 120, // 大きめに
                  onTap: () => setState(() => _selectedIndex = 1), // Map
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// 画像だけでタップできる透明ボタン
class _TapImageButton extends StatelessWidget {
  final String path;
  final double size;
  final VoidCallback onTap;
  const _TapImageButton({
    required this.path,
    required this.onTap,
    this.size = 56,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency, // 背景なし
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(size / 2),
        child: SizedBox(
          width: size,
          height: size,
          child: Image.asset(path, fit: BoxFit.contain),
        ),
      ),
    );
  }
}
