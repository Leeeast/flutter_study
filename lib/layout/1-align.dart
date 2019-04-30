import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center(
        child: Align(
          alignment: Alignment.topRight,
          child: Container(
            width: 200.0,
            height: 200.0,
            color: Colors.brown,
          ),
        ),
      ),
    );
  }
}
