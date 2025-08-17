// lib/pages/user_page.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'auth_gate.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    Future<void> signOut() async {
      await FirebaseAuth.instance.signOut();

      // mountedチェックは残したまま、中の処理を変更
      if (context.mounted) {
        // 現在の画面をすべて破棄し、新たにAuthGateを起動する
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const AuthGate()),
              (route) => false, // falseを返すことで、すべての古い画面を削除する
        );
      }
    }

    // Scaffoldを削除し、Centerを直接返す
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(user?.email ?? 'ゲスト'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: signOut,
            child: const Text('サインアウト'),
          ),
        ],
      ),
    );
  }
}