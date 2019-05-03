import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CupertinoButton',
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'CupertinoButton',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        body: Builder(builder: (BuildContext context) {
          return Center(
            child: CupertinoButton(
                child: Text('CupertinoButton'),
                color: Colors.blue,
                onPressed: () {
                  var snackBar = SnackBar(content: Text('SnackBar'));
                  Scaffold.of(context).showSnackBar(snackBar);
                }),
          );
        }),
      ),
    );
  }
}
