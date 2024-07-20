import 'package:flutter/material.dart';
import 'QuestionCompletionHistory.dart';
import 'QuestionCompletionHistoryDB.dart';
import "popUpWindow.dart";

class QuestionCompletionHistoryScreen extends StatefulWidget {
  List<QuestionCompletionHistory> history = [];

  String username = "";

  QuestionCompletionHistoryScreen(this.history, this.username);

  @override
  _QuestionCompletionHistoryScreenState createState() => _QuestionCompletionHistoryScreenState();

}

class _QuestionCompletionHistoryScreenState extends State<QuestionCompletionHistoryScreen> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
          title: Text(this.widget.username + '\'s\ Question Completion History')
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Expanded(child: QuestionList(this.widget.history, this.widget.username))
        ]
      )      
    );
  }
}

class QuestionList extends StatefulWidget {
  List<QuestionCompletionHistory> questionList;
  String username = "";

  QuestionList(this.questionList, this.username);
  @override
  _QuestionListState createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {

  void questionCompleted(QuestionCompletionHistory question) {
    this.setState((){
      FocusScope.of(context).unfocus();
      int currentQuestionListLength = this.widget.questionList.length;
      QuestionCompletionHistoryDB().deleteQuestionByUsername(this.widget.username, question.question).then((list) {
        this.widget.questionList.clear();
        this.widget.questionList = list;
        if(currentQuestionListLength > this.widget.questionList.length) {
          PopUpWindow().showPopUpWindow(context, "History removed", question.question + " has been removed from the history.");
        } else {
          PopUpWindow().showPopUpWindow(context, "Error", question.question + " is not found within the history.");
        }
      }); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: this.widget.questionList.length,
      //have context and index, use index to display specific item
      //itemBuilder allows you to dictate how the item is going to be displayed
      itemBuilder: (context, index) {
        var question = this.widget.questionList[index];
        return Card(
          child: Row(
            children: <Widget>[Expanded(child: ListTile(title: Text(question.question), 
                                                        subtitle: Text(question.user))),
                               Row(children: <Widget>[IconButton(
                                                        icon: Icon(Icons.check),
                                                        onPressed: () => questionCompleted(question),
                                                      )]                 
                               )]
          )
        );
      },
    );
  }
}
