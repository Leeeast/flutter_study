import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;
  bool reversed = false;
  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = TweenSequence(
      [
        TweenSequenceItem(
          tween: Tween(begin: 0.0, end: -pi / 2),
          weight: 0.5,
        ),
        TweenSequenceItem(
          tween: Tween(begin: pi/2,end: 0.0),
          weight: 0.5,
        ),
      ],
    ).animate(_animationController);
  }
  @override
  void dispose() {
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
