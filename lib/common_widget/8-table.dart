import 'package:flutter/material.dart';

void main() => runApp(HomePage());

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("table"),
        ),
        body: Center(
          child: Table(
            textBaseline: TextBaseline.ideographic,
            columnWidths: const <int, TableColumnWidth>{
              0: FixedColumnWidth(50.0),
              1: FixedColumnWidth(100.0),
              2: FixedColumnWidth(50.0),
              3: FixedColumnWidth(60.0),
            },
            border: TableBorder.all(
              color: Colors.brown,
              width: 2.0,
            ),
            children: const <TableRow>[
              TableRow(children: [
                Text('头像'),
                Text('姓名'),
                Text('年龄'),
                Text('身高'),
              ]),
              TableRow(children: [
                Icon(
                  Icons.person,
                  color: Colors.amber,
                ),
                Text('10号技师'),
                Text('21'),
                Text('168'),
              ]),
              TableRow(children: [
                Icon(
                  Icons.person_outline,
                  color: Colors.blueAccent,
                ),
                Text('10号技师'),
                Text('21'),
                Text('168'),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}
