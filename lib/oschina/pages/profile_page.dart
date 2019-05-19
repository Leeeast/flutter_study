import 'package:FlutterStudy/oschina/common/event_bus.dart';
import 'package:FlutterStudy/oschina/constants/constants.dart' show AppColors;
import 'package:FlutterStudy/oschina/pages/login_web_page.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List menuTitles = [
    '我的消息',
    '阅读记录',
    '我的博客',
    '我的问答',
    '我的活动',
    '我的团队',
    '邀请好友',
  ];
  List menuIcons = [
    Icons.message,
    Icons.chrome_reader_mode,
    Icons.assignment,
    Icons.question_answer,
    Icons.local_activity,
    Icons.people,
    Icons.insert_invitation
  ];

  String userAvatar;
  String userName;

  @override
  void initState() {
    super.initState();
    //尝试现实用户信息
    _showUserInfo();
    eventBus.on<LoginEvent>().listen((event) {
      //获取用户信息&显示
    });
    eventBus.on<LogoutEvent>().listen((event) {
      //退出登录
    });
  }

  _showUserInfo() {
    //todo
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildHeader();
          }
          index -= 1;
          return ListTile(
            leading: Icon(menuIcons[index]),
            title: Text(menuTitles[index]),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              //todo
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: menuTitles.length + 1);
  }

  _login() async {
    final result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => LoginWebPage()));
    if (result != null && result == 'refresh') {
      eventBus.fire(LoginEvent());
    }
  }

  Container _buildHeader() {
    return Container(
      height: 150.0,
      color: Color(AppColors.APP_THEME),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //头像
            GestureDetector(
              child: Container(
                width: 60.0,
                height: 60.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    width: 2.0,
                  ),
                  image: DecorationImage(
                    image: AssetImage('assets/images/ic_avatar_default.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              onTap: () {
                //执行登录
                _login();
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              '点击头像登录',
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
