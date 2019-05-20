import 'package:FlutterStudy/oschina/constants/constants.dart';
import 'package:flutter/material.dart';

class MyMessagePage extends StatefulWidget {
  @override
  _MyMessagePageState createState() => _MyMessagePageState();
}

class _MyMessagePageState extends State<MyMessagePage> {
  List<String> _tabTitles = ['@我', '评论', '私信'];
  List messageList;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabTitles.length,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            '消息中心',
            style: TextStyle(
              color: Color(AppColors.APPBAR),
            ),
          ),
          iconTheme: IconThemeData(color: Color(AppColors.APPBAR)),
          bottom: TabBar(
              tabs: _tabTitles
                  .map((title) => Tab(
                        text: title,
                      ))
                  .toList()),
        ),
        body: TabBarView(children: [
          Center(
            child: Text('暂无内容'),
          ),
          Center(
            child: Text('暂无内容'),
          ),
          Center(
            child: Text('暂无内容'),
          ),
          _buildMessageList(),
        ]),
      ),
    );
  }
  _buildMessageList(){
    if(messageList == null){

    }
  }
}
