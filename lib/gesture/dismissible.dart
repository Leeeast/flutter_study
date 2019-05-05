import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      home: HomePage(),
    ));

class HomePage extends StatelessWidget {
  final List<String> items = List.generate(2000, (index) => 'item $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return Dismissible(
              movementDuration: Duration(milliseconds: 100),
              key: Key(item),
              child: ListTile(
                title: Text('$item'),
              ),
              background: Container(
                color: Colors.amber,
              ),
            );
          }),
    );
  }
}
