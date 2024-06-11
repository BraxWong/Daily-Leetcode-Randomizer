import 'package:sqflite/sqflite.dart';
import 'database.dart';
import 'QuestionCompletionHistory.dart';

class QuestionCompletionHistoryDB {

  Future<void> createTable(Database database) async {
    await database.execute('CREATE TABLE IF NOT EXISTS QuestionCompletionHistory(id INTEGER NOT NULL, body TEXT NOT NULL, user TEXT NOT NULL, numOfCompletion INTEGER NOT NULL, userCompleted TEXT NOT NULL, PRIMARY KEY("id" AUTOINCREMENT))');
  }

  Future<int> create({required String body, required String user, required int numOfCompletion, required String userCompleted}) async {
    final database = await DB().database;
    return await database.rawInsert(
      '''INSERT INTO QuestionCompletionHistory (body, user, numOfCompletion, userCompleted) VALUES (?,?,?,?)''',
      [body, user, numOfCompletion, userCompleted],
    );
  }

  Future<List<QuestionCompletionHistory>> fetchAll() async {
    final database = await DB().database;
    final allQuestionCompletionHistory = await database.rawQuery(
      '''SELECT * from QuestionCompletionHistory'''
    );
    return allQuestionCompletionHistory.map((questionCompletionHistory) => QuestionCompletionHistory.fromSqfliteDatabase(questionCompletionHistory)).toList();
  }

}
