// lib/pages/main_screen.dart
import 'package:flutter/material.dart';
import 'mylist_page.dart';
import 'continent_map_demo_page.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1; // 真ん中のMapを初期表示

  final _pages = const [
    MyListPage(), // 左：リスト（中身だけ）
    ContinentMapScrollablePage(), // 中：マップ（中身だけに揃えるのが◎）
    UserPage(), // 右：ユーザー（中身だけ）
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(['My Pins', 'Map', 'User'][_selectedIndex])),
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.public), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}

class UserPage extends StatelessWidget {
  const UserPage({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text("User Page"));
}
