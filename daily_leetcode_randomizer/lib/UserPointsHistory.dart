class UserPointsHistory {
  final int id;
  final String username;
  final int dailyPoints;
  final int totalPoints;

  const UserPointsHistory({
    required this.id,
    required this.username,
    required this.dailyPoints,
    required this.totalPoints
  });

  factory UserPointsHistory.fromSqfliteDatabase(Map<String, dynamic> map) => UserPointsHistory(
    id: map['id']?.toInt() ?? 0,
    username: map['username'] ?? '',
    dailyPoints: map['dailyPoints']?.toInt() ?? 0,
    totalPoints: map['totalPoints']?.toInt() ?? 0
  );

}
