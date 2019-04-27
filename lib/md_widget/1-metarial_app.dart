import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'MaterialApp',
      routes: {'/other': (BuildContext context) => OtherPage()},
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  final _widgetOptions = [Text('信息'), Text('通讯录'), Text("发现"), Text('我')];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text('Material演示'),
      ),
      body: _widgetOptions.elementAt(_currentIndex),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/other');
        },
        tooltip: '路由跳转',
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
        elevation: 0.0,
        child: Icon(Icons.arrow_forward),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.amber,
        selectedFontSize: 16.0,
        unselectedFontSize: 16.0,
        //selectedItemColor: Colors.purple,
        //unselectedItemColor: Colors.blueGrey,
        fixedColor: Colors.black,
        showSelectedLabels: true,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.message, color: Colors.blue),
            activeIcon: Icon(Icons.message, color: Colors.red),
            title: Text('信息'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts, color: Colors.blue),
            activeIcon: Icon(Icons.contacts, color: Colors.red),
            title: Text('通讯录'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.looks, color: Colors.blue),
            activeIcon: Icon(Icons.looks, color: Colors.red),
            title: Text('发现'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.blue),
            activeIcon: Icon(Icons.person, color: Colors.red),
            title: Text('我'),
          ),
        ],
        currentIndex: _currentIndex,
        //type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      drawer: _buildDrawer(),
    );
  }

  Drawer _buildDrawer() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('苏大成'),
            accountEmail: Text('3461979@qq.com'),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://randomuser.me/api/portraits/women/17.jpg'),
            ),
            otherAccountsPictures: <Widget>[
              Icon(Icons.camera_alt),
              Icon(Icons.volume_down),
            ],
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              image: DecorationImage(
                image: AssetImage('assets/images/mate_20_pro_3.png'),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('支付'),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('会员'),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('消息'),
          ),
          ListTile(
            leading: Icon(Icons.add_alarm),
            title: Text('闹铃'),
          ),
          ListTile(
            leading: Icon(Icons.airplanemode_inactive),
            title: Text('飞行模式'),
          ),
          AboutListTile(
            icon: Icon(Icons.error),
            child: Text('关于'),
            applicationName: '疯播',
            applicationVersion: '1.0',
          ),
        ],
      ),
    );
  }
}

class OtherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
