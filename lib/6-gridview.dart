import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("ListView实例"),
            ),
            body:
//      GridView.count(
//          crossAxisCount: 2,
//          //scrollDirection: Axis.horizontal,
//          childAspectRatio: 3 / 4,
//          children: List.generate(100, (index) {
//            return Container(
//              color: Colors.amber,
//              margin: EdgeInsets.all(10.0),
//              child: Text(
//                'item = $index',
//                style: TextStyle(fontSize: 20.0, color: Colors.teal),
//              ),
//            );
//          })),
                GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      print('$index');
                      return Container(
                        color: Colors.blueAccent,
                        margin: EdgeInsets.all(10.0),
                        child: Text(
                          '$index',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 26,
                          ),
                        ),
                      );
                    })));
  }
}
