import 'package:sqflite/sqflite.dart';
import 'database.dart';
import 'UserPointsHistory.dart';

class UserPointsHistoryDB {
  final tableName = 'user_points_history_database.db';

  Future<void> createTable(Database database) async {
    await database.execute('CREATE TABLE IF NOT EXISTS UserPointsHistory(id INTEGER NOT NULL, username TEXT NOT NULL, dailyPoints INTERGER NOT NULL, totalPoints INTERGER NOT NULL, PRIMARY KEY("id" AUTOINCREMENT))');
  }
  
  Future<int> create({required String username}) async {
    final database = await DB(databaseName: this.tableName).database;
    await createTable(database);
    return await database.rawInsert(
      '''INSERT INTO UserPointsHistory (username, dailyPoints, totalPoints) VALUES (?,?,?)''',
      [username, 0, 0],
    );
  }

  Future<UserPointsHistory> getUserPoints(String username) async {
    final database = await DB(databaseName: this.tableName).database;
    await createTable(database);
    final userPoints = await database.rawQuery(
      '''SELECT * from UserPointsHistory WHERE username = ?''',
      [username]
    );
    return UserPointsHistory.fromSqfliteDatabase(userPoints.first); 
  }

  Future<UserPointsHistory> incrementUserDailyPoints(String username) async {
    final database = await DB(databaseName: this.tableName).database;
    await createTable(database);
    await database.rawQuery(
      '''UPDATE UserPointsHistory SET dailyPoints = dailyPoints + 1 WHERE username = ?''',
      [username]
    );
    final userPoints = await database.rawQuery(
      '''SELECT * from UserPointsHistory WHERE username = ?''',
      [username]
    );
    return UserPointsHistory.fromSqfliteDatabase(userPoints.first);
  }

  Future<UserPointsHistory> incrementUserTotalPoints(String username) async {
    final database = await DB(databaseName: this.tableName).database;
    await createTable(database);
    await database.rawQuery(
      '''UPDATE UserPointsHistory SET totalPoints = totalPoints + 1 WHERE username = ?''',
      [username]
    );
    final userPoints = await database.rawQuery(
      '''SELECT * from UserPointsHistory WHERE username = ?''',
      [username]
    );
    return UserPointsHistory.fromSqfliteDatabase(userPoints.first);
  }

  Future<List<UserPointsHistory>> fetchAll() async {
    final database = await DB(databaseName: this.tableName).database;
    await createTable(database);
    final allUserPoints = await database.rawQuery(
      '''SELECT * FROM UserPointsHistory'''
    );
    return allUserPoints.map((userPoints) => UserPointsHistory.fromSqfliteDatabase(userPoints)).toList();
  }
  Future<bool> userInUserPointsHistoryDB(String username) async {
    final userPointsList = await fetchAll(); 
    for (var userPoints in userPointsList){
      if(userPoints.username == username){
        return true;
      }
    }
    return false;
  }
}
