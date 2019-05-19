import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Offset _offset = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(_offset.dx * 0.01)
            ..rotateY(_offset.dy * 0.01)
            ..rotateZ(_offset.dy * 0.01),
          child: GestureDetector(
            onPanUpdate: (detail) {
              setState(() {
                _offset += detail.delta;
              });
            },
            onDoubleTap: () {
              setState(() {
                _offset = Offset.zero;
              });
            },
            child: Container(
              width: 200.0,
              height: 200.0,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }
}
