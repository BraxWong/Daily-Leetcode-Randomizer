import 'package:flutter/material.dart';

/* ----------------------------------------------------------------------------------------------------------------
 * @Disclaimer: The following class is derived from https://api.flutter.dev/flutter/material/Card-class.html
 * For more information, please visit the official flutter website for the original implementation
 * @Class:MyCard 
 * @Param: String title                 -> Displays the title of the card
 *         List<String> message         -> Displays the message of the card 
 *         IconData icon                -> Displays the icon of the card. 
 * @Description: The MyCard class is used to display a card like object in front of the current screen.
 */

class MyCard extends StatefulWidget{
  String title = "";
  List<String> message = [];
  IconData icon = Icons.circle; 

  MyCard(this.title, this.message, this.icon);

  @override
  _MyCardState createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  
  @override
  Widget build(BuildContext context){
    return SizedBox(
      width: 300,
      height: 100,
      child:Center(
        child: Card(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(this.widget.icon),
                title: Text(this.widget.title),
                subtitle: Text(this.widget.message.join('\n')), 
              ),
            ],
          ),
        ),
      ),
    ); 
  }
}
