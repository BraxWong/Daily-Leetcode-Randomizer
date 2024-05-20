import 'package:flutter/material.dart';
import 'QuestionCompletionHistory.dart';

class MyHomePage extends StatefulWidget {
  String username = "";

  MyHomePage(this.username);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  String question = "";
  List<QuestionCompletionHistory> history = [];

  void searchQuestion(String question) {
    this.setState((){
      this.question = question;
      history.add(new QuestionCompletionHistory(question, this.widget.username));
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily LeetCode Randomizer')
      ),
      body: Column(
        children: <Widget>[AppSlogan(), Expanded(child: QuestionList(this.history)), SearchLeetCodeQuestion(this.searchQuestion)]
      ) 
    );
  }
}

class AppSlogan extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Text('One LeetCode question a day and ace all of your technical interviews');
  }
}

//Taking constructor arguments and setting up override
class SearchLeetCodeQuestion extends StatefulWidget {
  final Function(String) callback;

  /* 
   * SearchLeetCodeQuestion constructor
   */

  SearchLeetCodeQuestion(this.callback);

  @override
  _SearchLeetCodeQuestionState createState() => _SearchLeetCodeQuestionState();
}

/*
 * Handling states and rendering
 */
class _SearchLeetCodeQuestionState extends State<SearchLeetCodeQuestion> {
  /*
   * Used to get the text within the TextField widget
   */
  final controller = TextEditingController();
  String question = "";
  /*
   *when this widget is done, need to clean up everything. Kind of like a destructor.
   */
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void setQuestion(question){
    /*
     * setState is a flutter method that forces flutter to reload
     */
    setState((){
      this.question = question; 
    });
  }

  void send() {
    widget.callback(this.question);
    controller.clear();
  }

  @override
  Widget build(BuildContext context){
    return Column(
      children: <Widget>[
        TextField(
          controller: this.controller,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.message
            ),
            labelText: "Enter the name of a question that you want to practice.",
            suffixIcon: IconButton(
              icon: Icon(Icons.send),
              splashColor: Colors.blue,
              tooltip: "Press send to get the question.",
              onPressed: this.send,
            )
          ),
          onChanged: (text) => this.setQuestion(text), 
        ),
      ]
    );
  }
}

class QuestionList extends StatefulWidget {
  final List<QuestionCompletionHistory> questionList;

  QuestionList(this.questionList);
  @override
  _QuestionListState createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {

  void questionCompleted(QuestionCompletionHistory question) {
    this.setState((){
      question.questionCompleted();
      //Gets rid of the keyboard when the user is done typing
      FocusScope.of(context).unfocus();
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
            children: <Widget>[Expanded(child: ListTile(title: Text(question.body), 
                                                        subtitle: Text(question.user))),
                               Text("Number of completion: " + question.numOfCompletion.toString()),
                               Row(children: <Widget>[IconButton(
                                                        icon: Icon(Icons.check),
                                                        onPressed: () => questionCompleted(question),
                                                        color: question.userCompleted ? Colors.green : Colors.black 
                                                      )]                 
                               )]
          )
        );
      },
    );
  }
}
