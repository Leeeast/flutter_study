import 'dart:convert';

import 'package:FlutterStudy/oschina/constants/constants.dart'
    show AppColors, AppInfos, AppUrls;
import 'package:FlutterStudy/oschina/utils/data_utils.dart';
import 'package:FlutterStudy/oschina/utils/net_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginWebPage extends StatefulWidget {
  @override
  _LoginWebPageState createState() => _LoginWebPageState();
}

class _LoginWebPageState extends State<LoginWebPage> {
  FlutterWebviewPlugin _flutterWebviewPlugin = FlutterWebviewPlugin();
  bool isLoading = true;

  @override
  void initState() {
    //监听url变化
    _flutterWebviewPlugin.onUrlChanged.listen((url) {
      print('LoginWebPage onUrlChanged: $url');
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      //http://live.sinashow.com/?code=7YDIg7&state=
      if (url != null && url.length > 0 && url.contains('?code=')) {
        //登录成功
        //提取授权码
        String code = url.split('code=')[1].split('&')[0];
        Map<String, dynamic> params = Map<String, dynamic>();
        params['client_id'] = AppInfos.CLIENT_ID;
        params['client_secret'] = AppInfos.CLIENT_SECRET;
        params['grant_type'] = 'authorization_code';
        params['redirect_uri'] = AppInfos.REDIRECT_URI;
        params['code'] = '$code';
        params['dataType'] = 'json';
        NetUtils.get(AppUrls.OAUTH2_TOKEN, params).then((data) {
          //{"access_token":"aa105aaf-ca4f-4458-822d-1ae6a1fa33f9","refresh_token":"daae8b80-3ca6-4514-a8ae-acb3a82c951c","uid":2006874,"token_type":"bearer","expires_in":510070}
          print('$data');
          if (data != null) {
            Map<String, dynamic> map = json.decode(data);
            if (map != null && map.isNotEmpty) {
              if (map['error'] != '404') {
                //保存token等信息
                DataUtils.saveLoginInfo(map);
              } else {
                Fluttertoast.showToast(
                    msg: "登录失败",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIos: 1,
                    backgroundColor: Colors.black54,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
              //弹出当前路由，并返回refresh通知我的界面刷新数据
              Navigator.pop(context, 'refresh');
            }
          }
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _flutterWebviewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _appBarTitle = [
      Text(
        '登录开源中国',
        style: TextStyle(color: Color(AppColors.APPBAR)),
      )
    ];
    if (isLoading) {
      _appBarTitle.add(SizedBox(
        width: 10.0,
      ));
      _appBarTitle.add(CupertinoActivityIndicator());
    }
    //
    return WebviewScaffold(
      url: AppUrls.OAUTH2_AUTHORIZE +
          '?response_type=code&client_id=' +
          AppInfos.CLIENT_ID +
          '&redirect_uri=' +
          AppInfos.REDIRECT_URI,
      appBar: AppBar(
        title: Row(
          children: _appBarTitle,
        ),
      ),
      //允许执行JS
      withJavascript: true,
      //允许本地存储
      withLocalStorage: true,
      //允许网页缩放
      withZoom: true,
    );
  }
}
