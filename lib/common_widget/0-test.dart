import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      title: '测试',
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('测试'),
        backgroundColor: Colors.brown,
        iconTheme: IconThemeData(color: Colors.deepPurple),
      ),
      body: Container(
        alignment: Alignment.topLeft,
        width: double.infinity,
        height: double.infinity,
        color: Colors.blue,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              '普洱',
              textAlign: TextAlign.center,
              style:
                  TextStyle(color: Colors.red, backgroundColor: Colors.amber),
            ),
            Text(
              '铁观音',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.deepOrangeAccent),
            ),
            Text(
              '庐州六安茶,六安瓜片',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.purpleAccent, backgroundColor: Colors.cyan),
            )
          ],
        ),
      ),
    );
  }
}
