import 'package:flutter/material.dart';
import 'QuestionCompletionHistory.dart';
import 'DailyQuestionGenerator.dart';
import 'QuestionCompletionHistoryDB.dart';
import 'QuestionCompletionHistoryScreen.dart';
import 'UserPointsHistory.dart';
import 'UserPointsHistoryDB.dart';
import 'Cards.dart';

class MyHomePage extends StatefulWidget {
  String username = "";
  int dailyPoints = 0;
  int totalPoints = 0;

  MyHomePage(this.username, this.dailyPoints, this.totalPoints);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  String question = "";
  List<QuestionCompletionHistory> history = [];

  void searchQuestion(String question) {
    this.setState((){
      this.question = question;
      QuestionCompletionHistoryDB().findQuestionByUsername(this.widget.username, question).then((questionExistsInDatabase) {
        if(questionExistsInDatabase == true) {
          QuestionCompletionHistoryDB().incrementNumOfCompletion(this.widget.username, question).then((list) {
            history = list;
          }); 
        } else {
          QuestionCompletionHistoryDB().create(question: this.question, user: this.widget.username);
          QuestionCompletionHistoryDB().fetchByUsername(this.widget.username).then((list) {
            history = list;
          });    
        }
        UserPointsHistoryDB().incrementUserTotalPoints(this.widget.username).then((userList) {
          print(userList.totalPoints.toString());    
        });
      });
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF42A5F5),
        title: Text('Daily LeetCode Randomizer')
      ),
      body: Column(
        children: <Widget>[SizedBox(height: 20),
                          AppSlogan(),
                          DailyQuestionGenerator(this.widget.username),
                          ElevatedButton(
                            onPressed: () {
                              QuestionCompletionHistoryDB().fetchByUsername(this.widget.username).then((list) {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => QuestionCompletionHistoryScreen(list, this.widget.username)));
                              });
                            },
                            child: const Text('Show question completion history'),
                          ),
                          Container(
                            alignment: Alignment.bottomLeft,
                            child: MyCard(this.widget.username + "'s Progress:", ["Daily LeetCode Points: " + this.widget.dailyPoints.toString(), "Total LeetCode Points: " + this.widget.totalPoints.toString()], Icons.play_arrow_rounded),
                          ),
                          Spacer(),
                          SearchLeetCodeQuestion(this.searchQuestion)
                          ]
      ) 
    );
  }
}

class AppSlogan extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Text('One LeetCode question a day, keep all the rejection letters away.');
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

