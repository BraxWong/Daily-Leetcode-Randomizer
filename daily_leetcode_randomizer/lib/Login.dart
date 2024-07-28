import 'package:flutter/material.dart';
import 'dart:async';
import 'package:path/path.dart' as Path;
import 'package:sqflite/sqflite.dart';
import 'HomePage.dart';
import 'database.dart';
import 'UserDetails.dart';
import 'UserDetailsDB.dart';
import 'UserPointsHistory.dart';
import 'UserPointsHistoryDB.dart';
import "popUpWindow.dart";

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Login')
      ),
      body: Body() 
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String username = "";
  String password = "";
  bool passwordVisible = false;
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));


  void login(BuildContext context){
    this.username = usernameController.text;
    this.password = passwordController.text;

    UserDetails userDetails = new UserDetails(id: 1, username: this.username, password: this.password);

    UserDetailsDB().checkLoginCredentials(this.username, this.password).then((loginSuccess) {
      if(loginSuccess) {
        UserPointsHistoryDB().userInUserPointsHistoryDB(this.username).then((userExists) {
          if(userExists == true){
            UserPointsHistoryDB().getUserPoints(this.username).then((userPoints) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(this.username, userPoints.dailyPoints, userPoints.totalPoints)));
            });
          } else {
            UserPointsHistoryDB().create(username: this.username);
            //This is like a stack, if you press back it will navigate to whatever is on top of the stack
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(this.username, 0, 0)));
          }
        });
      } else {
        createNewAccount(username: this.username, password: this.password, context: context);      
      }
    });
  }

  void createNewAccount({required String username, required String password, required BuildContext context}) {
    UserDetailsDB().usernameExistsInDB(this.username).then((usernameExists) {
      if(!usernameExists){
        UserDetailsDB().create(username: this.username, password: this.password).then((validPassword) {
          if(validPassword != -1) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(this.username, 0, 0)));
            PopUpWindow().showPopUpWindow(context, "Create New Account", "Username not found. Creating a new account");
          } else {
            PopUpWindow().showPopUpWindow(context, "Error", "The password has to consist at least 1 lower, upper case, and special character. The password has to be 8 characters long");
          }
        }); 
      } else {
        PopUpWindow().showPopUpWindow(context, "Incorrect Password", "Incorrect password, please try again");
      } 
    });
  }

  @override
  Widget build(BuildContext context){
    return Align(alignment: Alignment.center,
                 child: Padding(padding: EdgeInsets.all(10), 
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            border: new OutlineInputBorder(
                              borderSide: new BorderSide()
                            ),
                            prefixIcon: Icon(
                              Icons.person
                            ),
                            labelText: "Username",
                          ),                    
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: passwordController,
                          obscureText: !this.passwordVisible,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.password
                            ),
                            suffixIcon: IconButton(
                                  icon: Icon(
                                    this.passwordVisible ? Icons.visibility : Icons.visibility_off,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                        this.passwordVisible = !this.passwordVisible;
                                    });
                                  },
                            ),
                            labelText: "Password",
                            border: new OutlineInputBorder(
                                borderSide: new BorderSide()
                            )
                          ),
                        ),
                        SizedBox(height: 16),
                        ElevatedButton(
                          style: style,
                          onPressed: () => login(context),
                          child: const Text('Login'),
                        )                 
                      ]
                    )
                ));
    }
  }
