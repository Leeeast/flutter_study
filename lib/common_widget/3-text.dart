import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(MyApp());

//Text RickText
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Text示例'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '做一家受人尊敬的企业，做一位受人尊敬的老师！是我们动脑学院一直以来的追求！',
                maxLines: 1,
                overflow: TextOverflow.ellipsis, //3小点
                softWrap: true, //自动换行
                style: TextStyle(
                    fontSize: 30.0,
                    decoration: TextDecoration.lineThrough,
                    decorationStyle: TextDecorationStyle.wavy),
              ),
              SizedBox(
                height: 10.0,
              ),
              RichText(
                text: TextSpan(
                  text: '做一家受人尊敬的企业, ',
                  style: TextStyle(color: Color(0xffff0000), fontSize: 20.0),
                  children: <TextSpan>[
                    TextSpan(
                      text: '做一位受人尊敬的老师！是我们',
                    ),
                    TextSpan(
                        text: '动脑学院', //
                        style: TextStyle(color: Color(0xff0000ff)),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {
                            String url = 'https://www.dongnaoedu.com/';
                            if (await canLaunch(url))
                              await launch(url);
                            else
                              throw 'error: $url';
                          }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
