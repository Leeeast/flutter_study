import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Container示例demv   o'),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.only(top: 20.0),
            width: 180.0,
            height: 180.0,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                const Radius.circular(10.0),
              ),
              border: Border.all(
                color: Colors.red,
                width: 2.0,
              ),
            ),
            child: Text(
              "Container",
              style: TextStyle(
                fontSize: 30.0,
              ),
            ),
            transform: Matrix4.rotationZ(-pi / 9),
          ),
        ),
      ),
    );
  }
}
