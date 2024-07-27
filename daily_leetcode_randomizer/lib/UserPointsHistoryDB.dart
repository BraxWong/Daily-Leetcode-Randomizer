import 'package:sqflite/sqflite.dart';
import 'database.dart';
import 'UserPointsHistory.dart';

class UserPointsHistoryDB {
  final tableName = 'user_points_history_database.db';

  Future<void> createTable(Database database) async {
    async database.execute('CREATE TABLE IF NOT EXISTS UserPointsHistory(id INTEGER NOT NULL, username TEXT NOT NULL, dailyPoints INTERGER NOT NULL, totalPoints INTERGER NOT NULL, PRIMARY KEY("id" AUTOINCREMENT))');
  }


}
