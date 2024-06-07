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

  bool checkPasswordStrength(String password){
    bool hasUpperCase = false;
    bool hasLowerCase = false;
    final specialSymbolsRegEx = RegExp(r'[!@#$%^&*(),.?":{}|<>]'); 
    password.runes.forEach((int rune) {
      var character = new String.fromCharCode(rune);
      if(character == character.toUpperCase()){
        hasUpperCase = true;
      } else if (character == character.toLowerCase()) {
        hasLowerCase = true;
      } 
    });
    if(hasUpperCase && hasLowerCase && password.length >= 8 && specialSymbolsRegEx.hasMatch(password)){
      return true;
    }
    return false;
  }
}


