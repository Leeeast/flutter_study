import 'dart:ui';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Card',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Card示例'),
        leading: Icon(Icons.card_membership),
      ),
      body: ListView(children: <Widget>[
        buildCard(),
        buildCard(),
      ]),
    );
  }

  Widget buildCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: Card(
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
              ),
              child: Image.network(
                  'https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?ima'
                  'ge&quality=100&size=b4000_4000&sec=1556465067&di=7189488'
                  'a006f061f32bef50c6ea0cab7&src=http://b-ssl.duitang.com/'
                  'uploads/item/201401/16/20140116153839_mHdzS.jpeg',
                  width: window.physicalSize.width,
                  height: 200.0,
                  fit: BoxFit.cover),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    child: Icon(
                      Icons.home,
                      color: Colors.red,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '棒棒的',
                        style: TextStyle(fontSize: 20.0, color: Colors.blue),
                      ),
                      Text(
                        '500',
                        style:
                            TextStyle(fontSize: 14.0, color: Colors.blueAccent),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Column(
                    children: <Widget>[
                      Icon(
                        Icons.favorite,
                        color: Colors.deepPurple,
                      ),
                      Text(
                        '66',
                        style: TextStyle(
                          color: Colors.cyan,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CardView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
