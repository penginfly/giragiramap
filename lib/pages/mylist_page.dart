// lib/pages/mylist_page.dart
import 'package:flutter/material.dart';
import '../data/dummy_data.dart';

class MyListPage extends StatelessWidget {
  const MyListPage({super.key});

  final String currentUserId = 'user_a_id';

  @override
  Widget build(BuildContext context) {
    final myPins = dummyPins
        .where((p) => p['userId'] == currentUserId)
        .toList();

    // ← Scaffoldなし。リスト本体だけ返す
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
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
    );
  }
}
