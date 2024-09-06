import 'package:flutter/material.dart';
import 'UserPointsHistoryDB.dart';
import 'UserPointsHistory.dart';

class LeaderboardScreen extends StatefulWidget {
  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
      ),
      body: Column(
        children: <Widget>[
          Leaderboard()
        ]
      ),
    );
  }
}

class Leaderboard extends StatefulWidget {

  @override
  _LeaderboardState createState() => _LeaderboardState();

}

class _LeaderboardState extends State<Leaderboard> {

  List<UserPointsHistory> userPointsHistory=[];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();  
    _getLeaderboardData();
  }

  Future<void> _getLeaderboardData() async {
    userPointsHistory = await UserPointsHistoryDB().fetchAll();
    //The following statement is used to sort the UserPointsHistory List by the object's dailyPoints member variable.
    userPointsHistory.sort((a,b) => a.dailyPoints.compareTo(b.dailyPoints));
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context){
    if (isLoading == true){
      return Center(
        child: CircularProgressIndicator()
      );
    }
    return Table(
      border: TableBorder.all(),
      columnWidths: const <int, TableColumnWidth>{
        0: FixedColumnWidth(300),
      },
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: <TableRow>[
        TableRow(
          children: <Widget>[
            Container(
              height: 32,
              child: const Text('Ranking'),
            ),
            Container(
              height: 32,
              child: const Text('Username'),
            ),
            Container(
              height: 32,
              child: const Text('Daily Points'),
            ),
            Container(
              height: 32,
              child: const Text('Total Points'),
            ),
          ],
        ),
        ...this.userPointsHistory.asMap().entries.map((entry) {
          int index = entry.key;
          var userPoints = entry.value;
          return TableRow(
            children: <Widget>[
              Container(
                height: 32,
                child: Text((index + 1).toString()),
              ),
              Container(
                height: 32,
                child: Text(userPoints.username),
              ),
              Container(
                height: 32,
                child: Text(userPoints.dailyPoints.toString()),
              ),
              Container(
                height: 32,
                child: Text(userPoints.totalPoints.toString()),
              ),
            ],
          );
        }).toList(),      
      ],
    ); 
  }
}
