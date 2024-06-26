import 'package:sqflite/sqflite.dart';
import 'database.dart';
import 'QuestionCompletionHistory.dart';

class QuestionCompletionHistoryDB {
  final String tableName = 'question_completion_history_database.db';
  Future<void> createTable(Database database) async {
    await database.execute('CREATE TABLE IF NOT EXISTS QuestionCompletionHistory(id INTEGER NOT NULL, question TEXT NOT NULL, user TEXT NOT NULL, PRIMARY KEY("id" AUTOINCREMENT))');
  }

  Future<int> create({required String question, required String user}) async {
    final database = await DB(databaseName: this.tableName).database;
    await createTable(database);
    return await database.rawInsert(
      '''INSERT INTO QuestionCompletionHistory (question, user) VALUES (?,?)''',
      [question, user],
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

}
