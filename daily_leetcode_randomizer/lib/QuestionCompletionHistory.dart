class QuestionCompletionHistory {
  final int id;
  final String body;
  final String user;
  int numOfCompletion = 0;
  bool userCompleted = false;

  const QuestionCompletionHistory({
    required this.id,
    required this.body,
    required this.user,
    required this.numOfCompletion,
    required this.userCompleted,
  });

  factory QuestionCompletionHistory.fromSqfliteDatabase(Map<String, dynamic> map) => QuestionCompletionHistory(
    id: map['id']?.toInt() ?? 0,
    body: map['body'] ?? '',
    user: map['user'] ?? '',
    numOfCompletion: map['numOfCompletion']?.toInt() ?? 0,
    userCompleted: map['userCompleted'] ?? true : false
  );

  void questionCompleted() {
    this.userCompleted = !this.userCompleted;
    if(this.userCompleted){
      this.numOfCompletion +=1;
    } else {
      this.numOfCompletion -=1;
    }
  }
}
