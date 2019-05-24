import 'dart:math';

import 'package:FlutterStudy/oschina/constants/constants.dart' show AppColors;
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'dart:async';
import 'package:vibration/vibration.dart';

class ShakePage extends StatefulWidget {
  @override
  _ShakePageState createState() => _ShakePageState();
}

class _ShakePageState extends State<ShakePage> {
  bool isShaked = false;
  int _currentIndex = 0;
  StreamSubscription _streamSubscription;
  static const int SHAKE_TIMEOUT = 500;
  static const double SHAKE_SHRESHOLD = 3.25;
  var _lastTime = 0;

  @override
  void initState() {
    _streamSubscription =
        accelerometerEvents.listen((AccelerometerEvent event) {
      var now = DateTime.now().millisecondsSinceEpoch;
      if ((now - _lastTime) > SHAKE_TIMEOUT) {
        var x = event.x;
        var y = event.y;
        var z = event.z;
        double acce = sqrt(x * x + y * y + z * z) - 9.8;
        if (acce > SHAKE_SHRESHOLD) {
          //手机晃动了
          Vibration.vibrate();
          _lastTime = now;
          if (!mounted) {
            return;
          }
          setState(() {
            isShaked = true;
          });
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _streamSubscription.cancel();
    super.dispose();
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
            Text(isShaked
                ? _currentIndex == 0 ? '活动已经结束' : "有一条资讯还在路上"
                : _currentIndex == 0 ? '摇一摇获取礼品' : '摇一摇获取资讯'),
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
            isShaked = false;
          });
        },
      ),
    );
  }
}
