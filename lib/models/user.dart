// lib/data/user.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String userId;
  final String email;

  User({
    required this.userId,
    required this.email,
  });

  // Firestoreから取得したMapをUserオブジェクトに変換するファクトリコンストラクタ
  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      userId: data['userId'] as String,
      email: data['email'] as String,
    );
  }

  // UserオブジェクトをFirestoreに保存するためのMapに変換
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'email': email,
    };
  }
}