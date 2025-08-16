// signup_view.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _emailC = TextEditingController();
  final _passwordC = TextEditingController();

  @override
  void dispose() {
    _emailC.dispose();
    _passwordC.dispose();
    super.dispose();
  }

  // 以前作成した登録ロジック
  Future<void> _signUp() async {
    FocusScope.of(context).unfocus(); // キーボードを閉じる

    try {
      // メールアドレスとパスワードでユーザーを作成
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailC.text,
        password: _passwordC.text,
      );

      // 登録成功後、元のログイン画面に戻る
      if (mounted) {
        // 登録完了のメッセージを表示
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('登録が完了しました！')),
        );
        // 現在の画面を閉じて、前の画面（ログイン画面）に戻る
        Navigator.of(context).pop();
      }

    } on FirebaseAuthException catch (e) {
      // エラーハンドリング
      String errorMessage = '登録に失敗しました。';
      if (e.code == 'weak-password') {
        errorMessage = 'パスワードが弱すぎます。';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'このメールアドレスは既に使用されています。';
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // 登録画面専用のScaffold（画面の土台）を用意
    return Scaffold(
      appBar: AppBar(
        title: const Text('新規登録'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
          child: Column(
            children: [
              TextField(
                controller: _emailC,
                decoration: const InputDecoration(
                  labelText: 'メールアドレス',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: _passwordC,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'パスワード',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: FilledButton(
                  onPressed: _signUp, // 作成した登録関数を呼び出す
                  child: const Text('登録する'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}