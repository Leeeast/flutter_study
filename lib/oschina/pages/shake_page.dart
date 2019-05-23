import 'package:FlutterStudy/oschina/constants/constants.dart' show AppColors;
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';

class ShakePage extends StatefulWidget {
  @override
  _ShakePageState createState() => _ShakePageState();
}

class _ShakePageState extends State<ShakePage> {
  bool isShake = false;
  int _currentIndex = 0;

  @override
  void initState() {
    accelerometerEvents.listen((AccelerometerEvent event) {
      // Do something with the event.
    });
    gyroscopeEvents.listen((GyroscopeEvent event) {
      // Do something with the event.
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '摇一摇',
          style: TextStyle(color: Color(AppColors.APPBAR)),
        ),
        iconTheme: IconThemeData(color: Color(AppColors.APPBAR)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/shake.png',
              width: 120.0,
              height: 120.0,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text('摇一摇获取礼品'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.card_giftcard), title: Text('礼品')),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment), title: Text('资讯')),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          if (!mounted) return;
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
