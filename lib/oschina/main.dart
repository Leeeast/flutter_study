import 'package:flutter/material.dart';
import 'constants/constants.dart' show AppColors;
import 'HomePage.dart';

void main() => runApp(OSChina());

class OSChina extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '开源中国',
      theme: ThemeData(primaryColor: Color(AppColors.APP_THEME)),
      home: HomePage(),
    );
  }
}
