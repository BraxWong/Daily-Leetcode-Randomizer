import 'package:sqflite/sqflite.dart';
import 'database.dart';
import 'UserDetails.dart';

class UserDetailsDB {
  final tableName = 'user_details_database.db';
  
  Future<void> createTable(Database database) async {
    await database.execute('CREATE TABLE IF NOT EXISTS UserDetails(id INTEGER NOT NULL, username TEXT NOT NULL, password TEXT NOT NULL, PRIMARY KEY("id" AUTOINCREMENT))');    
  }

  Future<int> create({required String username, required String password}) async {
    final database = await DB(databaseName: this.tableName).database; 
    if(UserDetails(id: 1, username: username, password: password).checkPasswordStrength(password)){
      return await database.rawInsert(
        '''INSERT INTO UserDetails (username, password) VALUES (?,?)''',
        [username, password],
      );
    } else {
      print("Password has to consist a lower, upper case, and special character, it has to be 8 characters and longer.");
      return -1;
    }
  }

  Future<List<UserDetails>> fetchAll() async {
    final database = await DB(databaseName: this.tableName).database;
    final allUserDetails = await database.rawQuery(
      '''SELECT * from UserDetails'''
    );
    return allUserDetails.map((userDetails) => UserDetails.fromSqfliteDatabase(userDetails)).toList();
  }

  Future<UserDetails> fetchById(int id) async {
    final database = await DB(databaseName: this.tableName).database;
    final userDetails = await database.rawQuery(
      '''SELECT * from UserDetails WHERE ID = ?''',
      [id]
    );
    return UserDetails.fromSqfliteDatabase(userDetails.first);
  }

  Future<bool> usernameExistsInDB(String username) async {
    final userDetailsList = await fetchAll();
    for(var userDetails in userDetailsList){
      if(userDetails.username == username){
        return true;
      }
    }
    return false;
  }

  Future<bool> checkLoginCredentials(String username, String password) async {
    final userDetailsList = await fetchAll();
    for(var userDetails in userDetailsList) {
      if(userDetails.username == username && userDetails.password == password){
        return true;
      }
    }
    return false;
  }
}
