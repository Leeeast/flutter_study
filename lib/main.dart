import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Container Demfffo"),
        ),
        body: Center(
          child: Container(
            height: 200.0,
            width: 200.0,
            decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 10.0),
                borderRadius:
                    const BorderRadius.all(const Radius.circular(20.0))),
            child: Text("containercontainercontainercontainerc",
                style: TextStyle(fontSize: 30.0, color: Color(0xff0000ff))),
            transform: Matrix4.rotationZ(pi / 9),
          ),
        ),
      ),
    );
  }
}
