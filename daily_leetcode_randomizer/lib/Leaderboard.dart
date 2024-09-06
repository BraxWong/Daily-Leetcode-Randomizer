import 'package:flutter/material.dart';
import 'UserPointsHistoryDB.dart';
import 'UserPointsHistory.dart';

class LeaderboardScreen extends StatefulWidget {
  @override
  _LeaderboardScreenState createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  List<UserPointsHistory> userPointsHistory = [];
  @override
  void initState() {
    super.initState();  
    _getLeaderboardData();
  }

  Future<void> _getLeaderboardData() async {
    userPointsHistory = await UserPointsHistoryDB().fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
      ),
      body: Column(
        children: <Widget>[
          Leaderboard(userPointsHistory)
        ]
      ),
    );
  }
}

class Leaderboard extends StatefulWidget {
  List<UserPointsHistory> userPointsHistory = [];
  Leaderboard(this.userPointsHistory);

  @override
  _LeaderboardState createState() => _LeaderboardState();

}

class _LeaderboardState extends State<Leaderboard> {
  @override
  Widget build(BuildContext context){
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
        ...this.widget.userPointsHistory.asMap().entries.map((entry) {
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
