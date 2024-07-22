import 'package:sqflite/sqflite.dart';
import 'database.dart';
import 'QuestionCompletionHistory.dart';

class QuestionCompletionHistoryDB {
  final String tableName = 'question_completion_history_db.db';
  Future<void> createTable(Database database) async {
    await database.execute('CREATE TABLE IF NOT EXISTS QuestionCompletionHistory(id INTEGER NOT NULL, question TEXT NOT NULL, user TEXT NOT NULL, numOfCompletion INTEGER NOT NULL, PRIMARY KEY("id" AUTOINCREMENT))');
  }

  Future<int> create({required String question, required String user}) async {
    final database = await DB(databaseName: this.tableName).database;
    await createTable(database);
    return await database.rawInsert(
      '''INSERT INTO QuestionCompletionHistory (question, user, numOfCompletion) VALUES (?,?,?)''',
      [question, user, 1],
    );
  }

  Future<List<QuestionCompletionHistory>> fetchAll() async {
    final database = await DB(databaseName: this.tableName).database;
    await createTable(database);
    final allQuestionCompletionHistory = await database.rawQuery(
      '''SELECT * from QuestionCompletionHistory'''
    );
    return allQuestionCompletionHistory.map((questionCompletionHistory) => QuestionCompletionHistory.fromSqfliteDatabase(questionCompletionHistory)).toList();
  }

  Future<List<QuestionCompletionHistory>> fetchByUsername(String user) async {
    final database = await DB(databaseName: this.tableName).database;
    await createTable(database);
    final allQuestionCompletionHistory = await database.rawQuery(
      '''SELECT * from QuestionCompletionHistory WHERE user = ?''',
      [user]
    );
    return allQuestionCompletionHistory.map((questionCompletionHistory) => QuestionCompletionHistory.fromSqfliteDatabase(questionCompletionHistory)).toList();
  }

  Future<List<QuestionCompletionHistory>> deleteQuestionByUsername(String user, String question) async {
    final database = await DB(databaseName: this.tableName).database;
    await createTable(database);
    await database.rawQuery(
      '''DELETE FROM QuestionCompletionHistory WHERE user = ? AND question = ?''',
      [user, question]
    );
    final allQuestionCompletionHistory = await database.rawQuery(
      '''SELECT * from QuestionCompletionHistory WHERE user = ?''',
      [user]
    );
    return allQuestionCompletionHistory.map((questionCompletionHistory) => QuestionCompletionHistory.fromSqfliteDatabase(questionCompletionHistory)).toList();
  }

  Future<bool> findQuestionByUsername(String user, String question) async {
    final database = await DB(databaseName: this.tableName).database;
    await createTable(database);
    final allQuestionCompletionHistory = await database.rawQuery(
      '''SELECT * from questionCompletionHistory WHERE user = ? AND question = ?''',
      [user, question]
    );
    return allQuestionCompletionHistory.map((questionCompletionHistory) => QuestionCompletionHistory.fromSqfliteDatabase(questionCompletionHistory)).toList().length > 0;
  }

  Future<List<QuestionCompletionHistory>> incrementNumOfCompletion(String user, String question) async {
    final database = await DB(databaseName: this.tableName).database;
    await createTable(database);
    await database.rawQuery(
      '''UPDATE questionCompletionHistory SET numOfCompletion = numOfCompletion + 1 WHERE user = ? AND question = ?''',
      [user, question]
    );
    final allQuestionCompletionHistory = await database.rawQuery(
      '''SELECT * from QuestionCompletionHistory WHERE user = ?''',
      [user]
    );
    return allQuestionCompletionHistory.map((questionCompletionHistory) => QuestionCompletionHistory.fromSqfliteDatabase(questionCompletionHistory)).toList();

  }
}
