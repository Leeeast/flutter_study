import 'package:flutter/material.dart';
import 'package:flutter_study/md_widget/2-dialog.dart';
void main()=>runApp(MaterialApp(
  home: HomePage(),
));
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Transform(
          transform: Matrix4.identity(),
        ),
      ),
    );
  }
}
