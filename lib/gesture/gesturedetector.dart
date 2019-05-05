import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('gesturedetecotr'),
      ),
      body: Center(
        child: MyButton(),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('onTap');
      },
      onTapDown: (details) {
        print('onTapDown');
      },
      onTapCancel: () {
        print('onTapCancel');
      },
      onTapUp: (details) {
        print('onTapUp');
      },
      onLongPressMoveUpdate: (details) {
        print('onLongPressMoveUpdate');
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.amberAccent,
        ),
        padding: EdgeInsets.all(20.0),
        child: Text('MyButton'),
      ),
    );
  }
}
