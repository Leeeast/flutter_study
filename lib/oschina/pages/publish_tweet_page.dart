import 'dart:convert';
import 'dart:io';

import 'package:FlutterStudy/oschina/constants/constants.dart';
import 'package:FlutterStudy/oschina/utils/data_utils.dart';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class PublishTweetPage extends StatefulWidget {
  @override
  _PublishTweetPageState createState() => _PublishTweetPageState();
}

class _PublishTweetPageState extends State<PublishTweetPage> {
  Future<File> _imageFile;
  List<File> fileList = List<File>();
  bool isLoading = false;
  TextEditingController _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false, //防止键盘弹出 导致超出屏幕
      appBar: AppBar(
        title: Text(
          '弹一弹',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        actions: <Widget>[
          Builder(builder: (context) {
            return FlatButton(
                onPressed: () {
                  //发送动弹
                  DataUtils.getAccessToken().then((token) {
                    _publishTweet(context, token);
                  });
                },
                child: Text(
                  '发送',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ));
          })
        ],
      ),
      body: FutureBuilder(
          future: _imageFile,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data != null &&
                _imageFile != null) {
              fileList.add(snapshot.data);
              _imageFile = null;
            }
            return _bodyWidget();
          }),
    );
  }

  Widget _bodyWidget() {
    List<Widget> _body = [
      ListView(
        children: <Widget>[
//        输入框
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: '今天想动弹什么？',
                hintStyle: TextStyle(color: Color(0xaaaaaaaa)),
                border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.all(const Radius.circular(10.0))),
              ),
              maxLines: 6,
              maxLength: 150,
            ),
          ),
          GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              children: List.generate(fileList.length + 1, (index) {
                if (index == fileList.length) {
                  return Builder(
                    builder: (context) {
                      return GestureDetector(
                        onTap: () {
                          //选择图片
                          _pickImage(context);
                        },
                        child: Image.asset('assets/images/ic_add_pics.png'),
                      );
                    },
                  );
                }
                return GestureDetector(
                  onTap: () {
                    //取消图片
                    setState(() {
                      fileList.removeAt(index);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.file(
                      fileList[index],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }))
        ],
      )
    ];
    return Stack(
      children: _body,
    );
  }

  void _publishTweet(BuildContext context, String token) async {
    if (token == null) {
      _showSnackBar(context, "未登录！");
      return;
    }
    String tweetContent = _controller.text;
    if (tweetContent == null || tweetContent.isEmpty) {
      //未输入动弹内容
      _showSnackBar(context, '请输入动弹内容！');
      return;
    }
    Map<String, String> params = new Map();
    params['msg'] = tweetContent;
    params['access_token'] = token;
    print('动弹内容：$tweetContent');

    var multipartRequest =
        http.MultipartRequest('POST', Uri.parse(AppUrls.TWEET_PUB));
    multipartRequest.fields.addAll(params);
    if (fileList.length > 0) {
      for (File file in fileList) {
        var stream = http.ByteStream(DelegatingStream.typed(file.openRead()));
        var length = await file.length();
        print('${file.path}');
        var fileName = file.path.substring(file.path.lastIndexOf('/') + 1);
        multipartRequest.files
            .add(http.MultipartFile('img', stream, length, filename: fileName));
      }
    }
    setState(() {
      isLoading = true;
    });
    var streamResponse = await multipartRequest.send();
    streamResponse.stream.transform(utf8.decoder).listen((response) {
      print('response: $response');
      setState(() {
        isLoading = false;
      });
      if (response != null) {
        var decode = json.decode(response);
        var errorCode = decode['error'];
        if (mounted) {
          setState(() {
            if (errorCode != null && errorCode == '200') {
              fileList.clear();
              _controller.clear();
              _showSnackBar(context, '发布成功!');
            } else {
              _showSnackBar(context, '发布失败: ${decode['error_description']}');
            }
          });
        }
      }
    });
  }

  void _showSnackBar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(message),
      duration: Duration(milliseconds: 500),
    ));
  }

  void _pickImage(BuildContext context) {
    // 如果已添加了9张图片，则提示不允许添加更多
    num size = fileList.length;
    if (size >= 9) {
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: new Text("最多只能添加9张图片！"),
      ));
      return;
    }
    showModalBottomSheet<void>(
        context: context,
        builder: (context) {
          return new Container(
              height: 121.0,
              child: new Column(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      if (mounted) {
                        setState(() {
                          _imageFile =
                              ImagePicker.pickImage(source: ImageSource.camera);
                          print('_imageFile:$_imageFile');
                        });
                      }
                    },
                    child: Container(
                      height: 60.0,
                      child: Center(
                        child: Text(
                          '相机拍照',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),
                  new Divider(
                    height: 1.0,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      if (mounted) {
                        setState(() {
                          _imageFile = ImagePicker.pickImage(
                              source: ImageSource.gallery);
                        });
                      }
                    },
                    child: Container(
                      height: 60.0,
                      child: Center(
                        child: Text(
                          '图库选择照片',
                          style: TextStyle(fontSize: 20.0),
                        ),
                      ),
                    ),
                  ),
                ],
              ));
        });
  }
}
