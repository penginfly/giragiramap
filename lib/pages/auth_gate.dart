// auth_gate.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'login_page.dart'; // あなたのログイン画面
import 'main_screen.dart'; // あなたのホーム画面

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      // ユーザーのログイン状態を監視するストリーム
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // ユーザー情報があれば（ログイン済み）
        if (snapshot.hasData) {
          // ホーム画面を表示
          return const MainScreen();
        }

        // ユーザー情報がなければ（未ログイン）
        // ログイン画面を表示
        return const LoginView();
      },
    );
  }
}