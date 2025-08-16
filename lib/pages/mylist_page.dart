import 'package:flutter/material.dart';
import '../data/miki_dummy_data.dart';

class MyListPage extends StatelessWidget {
  const MyListPage({super.key});

  // ★ ここで自分のユーザーIDを指定（本当はFirebaseAuthから取得するのが自然）
  final String currentUserId = 'user_a_id';

  @override
  Widget build(BuildContext context) {
    // 自分のIDのピンだけフィルタリング
    final myPins = dummyPins
        .where((pin) => pin['userId'] == currentUserId)
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text("My Pins")),
      body: ListView.builder(
        itemCount: myPins.length,
        itemBuilder: (context, index) {
          final pin = myPins[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ListTile(
              title: Text(pin['title']),
              subtitle: Text(pin['description']),
              trailing: Text(pin['category']),
            ),
          );
        },
      ),
    );
  }
}
