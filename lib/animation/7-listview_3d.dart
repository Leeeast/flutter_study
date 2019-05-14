import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_study/md_widget/2-dialog.dart';

void main() => (MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var images = [
    'images/mate_20_pro_1.png',
    'images/mate_20_pro_2.png',
    'images/mate_20_pro_3.png',
    'images/mate_20_pro_3.png',
    'images/mate_20_pro_1.png',
    'images/mate_20_pro_2.png',
    'images/mate_20_pro_1.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListWheelScrollView(
          perspective: 0.003,
          diameterRatio: 2.0,
          itemExtent: MediaQuery.of(context).size.height * 0.6,
          children: images.map((m)=>Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: <Widget>[
                Image.asset(m,fit: BoxFit.cover,),
              ],
              Positioned(child: Text('勤有功戏无益',style: TextStyle(color: Colors.cyan,fontSize: 30.0),),)
            ),
          ),
          ),),
        ),
      ),
    );
  }
}
