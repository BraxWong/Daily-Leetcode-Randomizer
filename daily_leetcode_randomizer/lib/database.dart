import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'UserDetails.dart';
import 'UserDetailsDB.dart';
import 'QuestionCompletionHistoryDB.dart';

class DB {
  
  final String databaseName;
  Database? _database;

  DB({
    required this.databaseName,
  });

  /*
   * checks if _database is null, if so call initializeDatabase().
   * if it is not null, return _database
   */
  Future<Database> get database async {
    if(_database != null) {
      return _database!;
    }
    _database = await initializeDatabase();
    return _database!;
  }

  /*
   * returns the path to the database
   */
  Future<String> get fullPath async {
    String name = this.databaseName;
    final path = await getDatabasesPath();
    return join(path, name);
  }
  
  /*
   * creates the database if it does not exist
   */
  Future<void> create(Database database, int version) async =>
    await UserDetailsDB().createTable(database);

  /*
   * initializes the database if it is not initialized
   */
  Future<Database> initializeDatabase() async {
    final path = await fullPath;
    var database = await openDatabase(
      path,
      version: 1,
      onCreate: create,
      singleInstance: true,
    );
    return database; 
  }
}
