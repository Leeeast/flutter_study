import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("ListView实例"),
          ),
          body:
              //NormalListView(),
              //HorizontalListVIew(),
              ListView.builder(
            itemCount: 100,
            itemBuilder: (context, index) {
              print(index);
              if (index.isOdd) {
                return Divider(
                  color: Colors.pinkAccent,
                  height: 30,
                  indent: 25,
                );
              }
              return ListTile(
                leading: Icon(Icons.all_inclusive),
                title: Text('$index号技术可以'),
                subtitle: Text("活不赖"),
                trailing: Icon(Icons.arrow_forward),
              );
            },
          )),
    );
  }
}

class HorizontalListVIew extends StatelessWidget {
  const HorizontalListVIew({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: List.generate(500, (index) {
        return Text(
          '$index',
          style: TextStyle(
            fontSize: 18,
            color: Colors.deepPurple,
          ),
        );
      }),
    );
  }
}

class NormalListView extends StatelessWidget {
  const NormalListView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.favorite),
          title: Text('favorite'),
          subtitle: Text('subtitle'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        Divider(
          color: Colors.cyan,
          height: 5,
          indent: 0.5,
        ),
        ListTile(
          leading: Icon(Icons.favorite),
          title: Text('favorite'),
          subtitle: Text('subtitle'),
          trailing: Icon(Icons.arrow_forward_ios),
        ),
        Divider(
          color: Colors.cyan,
          height: 5,
          indent: 0.5,
        ),
      ],
    );
  }
}
