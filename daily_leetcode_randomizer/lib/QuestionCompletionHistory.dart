class QuestionCompletionHistory {
  String body;
  String user;
  int numOfCompletion = 0;
  bool userCompleted = false;

  QuestionCompletionHistory(this.body, this.user);

  void questionCompleted() {
    this.userCompleted = !this.userCompleted;
    if(this.userCompleted){
      this.numOfCompletion +=1;
    } else {
      this.numOfCompletion -=1;
    }
  }
}
