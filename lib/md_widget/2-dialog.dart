import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dialog',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePaeState createState() => _HomePaeState();
}

class _HomePaeState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dialog'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Builder(builder: (BuildContext c) {
              return SimpleDialog(
                title: Text('对话框标题'),
                children: <Widget>[
                  SimpleDialogOption(
                    child: Text('Option1'),
                    onPressed: () {
                      Scaffold.of(c).showSnackBar(
                        new SnackBar(
                          content: Text('l'),
                          duration: Duration(milliseconds: 1000),
                        ),
                      );
                    },
                  )
                ],
              );
            }),
            RaisedButton(
              child: Text('删除'),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('提示'),
                      content: SingleChildScrollView(
                        child: ListBody(
                          children: <Widget>[
                            Text('是否删除'),
                            Text('删除后不可恢复'),
                          ],
                        ),
                      ),
                      actions: <Widget>[
                        FlatButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.arrow_forward),
                          label: Text('确定删除'),
                        ),
                        FlatButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('取消'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
