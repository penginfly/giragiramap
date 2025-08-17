// lib/pages/user_page.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 現在のユーザー情報を取得
    final user = FirebaseAuth.instance.currentUser;

    // ログアウト処理
    Future<void> signOut() async {
      // AuthGateがログイン画面に遷移させてくれるので、ここでは待機しない
      await FirebaseAuth.instance.signOut();
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ユーザーのメールアドレスを表示（ログインしていない場合は'ゲスト'と表示）
            Text(user?.email ?? 'ゲスト'),
            const SizedBox(height: 24),
            // ログアウトボタン
            ElevatedButton(
              onPressed: signOut, // ログアウト処理を呼び出す
              child: const Text('サインアウト'),
            ),
          ],
        ),
      ),
    );
  }
}