// lib/pages/mylist_page.dart
import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyListPage extends StatelessWidget {
  const MyListPage({super.key});

  final String currentUserId = 'user_a_id';

  @override
  Widget build(BuildContext context) {
    final myPins = dummyPins
        .where((p) => p['userId'] == currentUserId)
        .toList();

    // ▼▼▼ Start of changes ▼▼▼
    // Wrap the ListView with a Scaffold widget
    return Scaffold(
      // Add an AppBar to the top of the screen
      appBar: AppBar(
        // Add a list of action buttons to the right of the title
        actions: [
          // Add a logout icon button
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout', // Optional: shows a label on long-press
            onPressed: () {
              // Call the signOut method from FirebaseAuth
              FirebaseAuth.instance.signOut();
              // Your AuthGate will automatically handle the screen transition
            },
          ),
        ],
      ),
      // Set the ListView as the main content of the screen
      body: ListView.builder(
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
      ),
    );
    // ▲▲▲ End of changes ▲▲▲
  }
}