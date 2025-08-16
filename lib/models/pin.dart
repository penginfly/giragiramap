class Pin {
  final String title;
  final String description;
  final String category;
  final String userId;
  final double xPosition;
  final double yPosition;

  Pin({
    required this.title,
    required this.description,
    required this.category,
    required this.userId,
    required this.xPosition,
    required this.yPosition,
  });

  // Firestoreから取得したMapをPinオブジェクトに変換するファクトリコンストラクタ
  factory Pin.fromMap(Map<String, dynamic> data) {
    return Pin(
      title: data['title'],
      description: data['description'],
      category: data['category'],
      userId: data['userId'],
      xPosition: data['xPosition'],
      yPosition: data['yPosition'],
    );
  }
}