import 'package:FlutterStudy/oschina/common/event_bus.dart';
import 'package:FlutterStudy/oschina/constants/constants.dart' show AppColors;
import 'package:FlutterStudy/oschina/utils/data_utils.dart';
import 'package:flutter/material.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '设置',
          style: TextStyle(color: Color(AppColors.APPBAR)),
        ),
        iconTheme: IconThemeData(color: Color(AppColors.APPBAR)),
      ),
      body: Center(
        child: FlatButton(
            onPressed: () {
              //退出登录
              DataUtils.clearLoginInfo().then((_) {
                eventBus.fire(LogoutEvent());
                Navigator.of(context).pop();
              });
            },
            child: Text(
              '退出登录',
              style: TextStyle(fontSize: 25.0),
            )),
      ),
    );
  }
}
