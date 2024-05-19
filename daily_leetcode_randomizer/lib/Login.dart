import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login')
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
  TextEditingController usernameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final ButtonStyle style = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
  @override
  Widget build(BuildContext context){
    return Align(alignment: Alignment.center,
                 child: Padding(padding: EdgeInsets.all(10), 
                    child: Column(
                      children: <Widget>[
                        TextField(
                          controller: usernameController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person
                            ),
                            labelText: "Username",
                          ),                    
                        ),
                        TextField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.password
                            ),
                            labelText: "Password",
                          ),
                        ),
                        ElevatedButton(
                          style: style,
                          onPressed: () {},
                          child: const Text('Enabled'),
                        )                 
                      ]
                    )
                ));
  }
}
