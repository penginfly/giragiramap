// signup_view.dart
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// ▼▼▼ Firestoreパッケージをインポート ▼▼▼
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:giragiramap/pages/main_screen.dart'; // メイン画面への遷移のために追加

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

  Future<void> _signUp() async {
    FocusScope.of(context).unfocus();

    try {
      // メールアドレスとパスワードでユーザーを作成
      final userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailC.text,
        password: _passwordC.text,
      );

      // ▼▼▼ ここから変更 ▼▼▼
      final user = userCredential.user;
      if (user != null) {
        // Firestoreの'user'コレクションにデータを保存
        await FirebaseFirestore.instance.collection('user').doc(user.uid).set({
          'userid': user.uid,
          'email': user.email,
          // 'createdAt': FieldValue.serverTimestamp(), // 登録日時も保存すると便利
        });

        // 登録成功後、メイン画面へ直接遷移する
        if (mounted) {
          Navigator.of(context).pushReplacement( // pushReplacementでログイン画面に戻れないようにする
            MaterialPageRoute(builder: (context) => const MainScreen()),
          );
        }
      }
      // ▲▲▲ ここまで変更 ▲▲▲

    } on FirebaseAuthException catch (e) {
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
                  onPressed: _signUp,
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