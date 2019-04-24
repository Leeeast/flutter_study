import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Text实例"),
        ),
        body: Builder(builder: (BuildContext context) {
          return Center(
            child: Column(
              children: <Widget>[
                Icon(Icons.person),
                Container(
                  height: 10.0,
                  color: Colors.blueAccent,
                ),
                IconButton(
                  icon: Icon(Icons.error),
                  onPressed: () {
                    var snackBar = SnackBar(
                      content: Text("SnackBar"),
                    );
                    Scaffold.of(context).showSnackBar(snackBar);
                  },
                ),
                RaisedButton(
                  onPressed: () {},
                  child: Text(
                    "RaisedButton",
                    style: TextStyle(
                      color: Colors.pink,
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
