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

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily LeetCode Randomizer')
      ),
      body: Column(
        children: <Widget>[AppSlogan(), SearchLeetCodeQuestion()]
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
            labelText: "Enter the name of a question that you want to practice."
          ),
          onChanged: (text) => this.setQuestion(text), 
        ),
        Text(this.question)
      ]
    );
  }
}
