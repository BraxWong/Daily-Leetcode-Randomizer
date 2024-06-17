class QuestionCompletionHistory {
  final int id;
  final String question;
  final String user;

  const QuestionCompletionHistory({
    required this.id,
    required this.question,
    required this.user,
  });

  factory QuestionCompletionHistory.fromSqfliteDatabase(Map<String, dynamic> map) => QuestionCompletionHistory(
    id: map['id']?.toInt() ?? 0,
    question: map['question'] ?? '',
    user: map['user'] ?? '',
  );

}
