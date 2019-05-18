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
          Container(
        margin: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 2 / 1),
            itemBuilder: (context, index) {
              print('$index');
              return Container(
                color: Colors.blueAccent,
//                        margin: EdgeInsets.fromLTRB(5.0, 0, 5.0, 0),
                child: Text(
                  '$index',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 26,
                  ),
                ),
              );
            }),
      ),
    ));
  }
}
