import 'package:flutter/material.dart';
import 'UserPointsHistoryDB.dart';

class Leaderboard extends StatefulWidget {
  @override
  _LeaderboardState createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  @override
  Widget build(BuildContext context){
    return Table(
      border: TableBorder.all(),
      columnWidths: const <int, TableColumnWidth>{
        0: IntrinsicColumnWidth(),
        1: FlexColumnWidth(),
        2: FixedColumnWidth(64),
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
      ],
    ); 
  }
}
