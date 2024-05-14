import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(), 
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String question = "";

  void searchQuestion(String question) {
    this.setState((){
      this.question = question;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily LeetCode Randomizer')
      ),
      body: Column(
        children: <Widget>[AppSlogan(), SearchLeetCodeQuestion(this.searchQuestion), Text(this.question)]
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
