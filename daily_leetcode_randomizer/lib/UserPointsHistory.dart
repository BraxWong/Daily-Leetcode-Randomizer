class UserPointsHistory {
  final int id;
  final String user;
  final int dailyPoints;
  final int totalPoints;

  const UserPointsHistory({
    required this.id,
    required this.user,
    required this.dailyPoints,
    required this.totalPoints
  });

  factory UserPointsHistory.fromSqfliteDatabase(Map<String, dynamic> map) => UserPointsHistory(
    id: map['id']?.toInt() ?? 0,
    user: map['user'] ?? '',
    dailyPoints: map['dailyPoints']?.toInt() ?? 0,
    totalPoints: map['totalPoints']?.toInt() ?? 0
  );

}
