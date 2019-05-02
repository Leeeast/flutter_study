import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Align(
            alignment:Alignment(1, 1),
                //Alignment.lerp(Alignment.topCenter, Alignment.topRight, 1),
            child: Container(
              width: 200,
              height: 200,
              color: Colors.cyan,
            ),
          ),
        ),
      ),
    );
  }
}
