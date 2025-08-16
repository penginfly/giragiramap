// lib/pages/mylist_page.dart
import 'package:flutter/material.dart';
// Firestoreと連携するためにパッケージをインポート
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyListPage extends StatelessWidget {
  const MyListPage({super.key});

  @override
  Widget build(BuildContext context) {

    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('マイリスト'),
        ),
        body: const Center(
          child: Text('マイリストを表示するにはログインしてください。'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('マイリスト'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      // ▼▼▼ StreamBuilderを使ってFirestoreのデータを購読 ▼▼▼
      body: StreamBuilder<QuerySnapshot>(
        // 'pins'コレクションから、'userId'が上で指定したIDと一致するドキュメントを取得
        stream: FirebaseFirestore.instance
            .collection('pins')
            .where('userId', isEqualTo: currentUser.uid) // ← 固定IDで絞り込み
            .snapshots(),
        builder: (context, snapshot) {
          // データ取得中にエラーが発生した場合
          if (snapshot.hasError) {
            return const Center(child: Text('エラーが発生しました'));
          }
          // データ取得中はローディングインジケーターを表示
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // 該当するデータが1件もなかった場合
          if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text("あなたのピンはまだありません"));
          }

          // データが取得できたらListViewで一覧表示
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: snapshot.data!.docs.length, // ドキュメントの数
            itemBuilder: (context, index) {
              // Firestoreのドキュメントからデータを取得
              final doc = snapshot.data!.docs[index];
              final pin = doc.data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: ListTile(
                  title: Text(pin['title']),
                  subtitle: Text(pin['description']),
                  trailing: Text(pin['category']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}