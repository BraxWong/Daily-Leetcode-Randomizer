import 'package:flutter/material.dart';

class DailyQuestionGenerator extends StatefulWidget {
  @override
  _DailyQuestionGeneratorState createState() => _DailyQuestionGeneratorState();
}

class _DailyQuestionGeneratorState extends State<DailyQuestionGenerator> {
  String todayQuestion = "Press the button below to get today's random question.";
  final controller = TextEditingController();
  bool questionGenerated = false;
  
  void generateQuestion(){
    this.setState(() {
      if(!questionGenerated)
      {
        this.todayQuestion = "You have generated a new question today";
        questionGenerated = true;
      }
      else
      {
        this.todayQuestion = "You have completed the question for today, please come back tomorrow.";
      }
    });
  }

  @override
  Widget build(BuildContext context){
    return Align(
      alignment: Alignment.center,
      child: Padding(padding: EdgeInsets.all(10),
        child:Column(
          children: <Widget>[
            TextField(
              controller: controller,
              enabled: false,
              decoration: InputDecoration(
                labelText: todayQuestion,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: const Text('Show Today\'s\ question'),
              onPressed: this.generateQuestion
            )
          ]
        )
      )
    ); 
  }
}
