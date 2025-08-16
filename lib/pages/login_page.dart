import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'signup_view.dart';
import 'continent_map_demo_page.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailC = TextEditingController();
  final _passwordC = TextEditingController();
  bool _obscure = true;

  // ログイン処理を実行する関数
  Future<void> _signIn() async {
    // キーボードを閉じる
    FocusScope.of(context).unfocus();

    try {
      // メールアドレスとパスワードでサインイン
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailC.text,
        password: _passwordC.text,
      );

      if (mounted) { // mountedチェックを追加するとより安全
        Navigator.pushReplacement( // pushReplacementを使うとログイン画面に戻れなくなる
          context,
          MaterialPageRoute(builder: (context) => const ContinentMapScrollablePage()),
        );
      }

      // ログイン成功後の処理（画面遷移など）はここに書く
      // この時点ではprintで成功したことだけ確認
      print('ログインに成功しました！');

    } on FirebaseAuthException catch (e) {
      // エラーハンドリング
      String errorMessage = 'ログインに失敗しました。';
      if (e.code == 'user-not-found') {
        errorMessage = '指定されたメールアドレスのユーザーは見つかりません。';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'パスワードが間違っています。';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'メールアドレスの形式が正しくありません。';
      }

      // 画面下部にエラーメッセージを表示
      if (mounted) { // widgetが有効な場合のみ実行
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
  void dispose() {
    _emailC.dispose();
    _passwordC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // 親(MainScreen)がScaffold + BottomNavを持つので、ここは“中身だけ”
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 460),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ロゴ・タイトル（見た目だけ）
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(.08),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.public,
                  size: 44,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Welcome back',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'ログインして続けましょう',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(.7),
                ),
              ),
              const SizedBox(height: 24),

              // 入力フォーム（見た目だけ・バリデーション無し）
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(color: theme.dividerColor.withOpacity(.2)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      TextField(
                        controller: _emailC,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'メールアドレス',
                          prefixIcon: Icon(Icons.alternate_email),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 14),
                      TextField(
                        controller: _passwordC,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _obscure,
                        decoration: InputDecoration(
                          labelText: 'パスワード',
                          prefixIcon: const Icon(Icons.lock_outline),
                          border: const OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () =>
                                setState(() => _obscure = !_obscure),
                            icon: Icon(
                              _obscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: FilledButton(
                          onPressed: _signIn, // ダミー（後で実装差し替え）
                          child: const Text('ログイン'),
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextButton(
                        onPressed: () {}, // ダミー
                        child: const Text('パスワードをお忘れですか？'),
                      ),
                    ],
                  ),
                ),
              ),
/*
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Divider(color: theme.dividerColor.withOpacity(.4)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'または',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.textTheme.bodySmall?.color?.withOpacity(
                          .7,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(color: theme.dividerColor.withOpacity(.4)),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // ソーシャルログイン（見た目だけ）
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton.icon(
                  icon: const Icon(Icons.login),
                  label: const Text('Googleでログイン'),
                  onPressed: () {}, // ダミー
                ),
              ),
              const SizedBox(height: 10),
              if (Theme.of(context).platform == TargetPlatform.iOS)
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.apple),
                    label: const Text('Appleでログイン'),
                    onPressed: () {}, // ダミー
                  ),
                ),
*/
              const SizedBox(height: 20),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 8,
                children: [
                  Text('アカウントをお持ちでない方は', style: theme.textTheme.bodyMedium),
                  TextButton(
                      onPressed: () {
                          // SignUpView画面に遷移させる
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const SignUpView(),
                            ),
                          );
                        },
                        child: const Text('新規登録')
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
