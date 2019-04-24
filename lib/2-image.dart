import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              "Image示例",
              style: TextStyle(fontSize: 20, color: Colors.cyanAccent),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              Image.network(
                "https://www.baidu.com/img/bd_logo1.png",
                width: 100.0,
                height: 100.0,
              ),
              Image.asset(
                "assets/images/mate_20_pro_1.png",
                width: 100,
                height: 100,
              ),
              MemoryImageWeidge(),
              FileImageWidget()
            ],
          ),
        ),
      ),
    );
  }
}

class MemoryImageWeidge extends StatefulWidget {
  @override
  _MemoryImageWeidgeState createState() => _MemoryImageWeidgeState();
}

class _MemoryImageWeidgeState extends State<MemoryImageWeidge> {
  Uint8List bytes;

  @override
  void initState() {
    super.initState();
    rootBundle.load("assets/images/mate_20_pro_1.png").then((data) {
      if (mounted) {
        setState(() {
          bytes = data.buffer.asUint8List();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final _decoration = BoxDecoration(
      image: bytes == null ? null : DecorationImage(image: MemoryImage(bytes)),
    );
    return Container(
      width: 100,
      height: 100,
      decoration: _decoration,
    );
  }
}

class FileImageWidget extends StatefulWidget {
  @override
  _FileImageWidgetState createState() => _FileImageWidgetState();
}

class _FileImageWidgetState extends State<FileImageWidget> {
  File _image;

  Future getImg() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Center(
          child: _image == null
              ? Text("未选择图片")
              : Image.file(
                  _image,
                  width: 200,
                  height: 200,
                ),
        ),
        FlatButton(
          onPressed: getImg,
          child: Text(
            'PickImage',
            style: TextStyle(color: Colors.blueAccent),
          ),
        ),
      ],
    );
  }
}
