import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('stack'),
      ),
      body: Center(
//        child: buildPositionedStack(),
//        child: buildAlignmentStack(),
        child: buildIndexedStack(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _index = Random().nextInt(2) % 2;
          });
        },
      ),
    );
  }

  Stack buildIndexedStack() {
    return IndexedStack(
      index: _index,
      alignment: Alignment(1.2, -1.2),
      children: <Widget>[
        Container(
          color: Colors.red,
          width: 200.0,
          height: 200.0,
        ),
        CircleAvatar(
          radius: 20.0,
          backgroundColor: Colors.purple,
        )
      ],
    );
  }

  Stack buildAlignmentStack() {
    return Stack(
      alignment: Alignment(1.2, -1.2),
      children: <Widget>[
        Container(
          color: Colors.red,
          width: 200.0,
          height: 200.0,
        ),
        CircleAvatar(
          radius: 20.0,
          backgroundColor: Colors.purple,
        )
      ],
    );
  }

  Stack buildPositionedStack() {
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.greenAccent,
          width: 200.0,
          height: 200.0,
        ),
        Positioned(
            top: 10.0,
            child: CircleAvatar(
              radius: 20.0,
              backgroundColor: Colors.deepPurple,
            )),
      ],
    );
  }
}
