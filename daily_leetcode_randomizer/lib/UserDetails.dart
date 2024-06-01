class UserDetails {
  final int id;
  final String username;
  final String password;

  const UserDetails({
    required this.id,
    required this.username,
    required this.password,
  });

  factory UserDetails.fromSqfliteDatabase(Map<String, dynamic> map) => UserDetails(
    id: map['id']?.toInt() ?? 0,
    username: map['username'] ?? '',
    password: map['password'] ?? ''
  );

  @override
  String toString() {
    return 'UserDetails{id: $id, name: $username, password: $password}';
  }
}


