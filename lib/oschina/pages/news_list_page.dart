import 'dart:convert';

import 'package:FlutterStudy/oschina/common/event_bus.dart';
import 'package:FlutterStudy/oschina/constants/constants.dart' show AppUrls;
import 'package:FlutterStudy/oschina/pages/login_web_page.dart';
import 'package:FlutterStudy/oschina/utils/data_utils.dart';
import 'package:FlutterStudy/oschina/utils/net_utils.dart';
import 'package:FlutterStudy/oschina/widgets/news_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsListPage extends StatefulWidget {
  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage> {
  bool isLogin = false;
  int curPage = 1;
  List newsList;
  ScrollController _scrollController;

  @override
  void initState() {
    DataUtils.isLogin().then((isLogin) {
      if (!mounted) return;
      setState(() {
        this.isLogin = isLogin;
      });
    });
    eventBus.on<LoginEvent>().listen((event) {
      if (!mounted) return;
      setState(() {
        this.isLogin = true;
      });
      getNewsList(false);
    });
    eventBus.on<LogoutEvent>().listen((event) {
      if (!mounted) return;
      setState(() {
        this.isLogin = false;
      });
    });
    _scrollController = ScrollController()
      ..addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          curPage++;
          getNewsList(true);
        }
      });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isLogin) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          InkWell(
            onTap: () async {
              final result = await Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LoginWebPage()));
              if (result != null && result == 'refresh') {
                //login success
                eventBus.fire(LoginEvent());
              }
            },
            child: Column(
              children: <Widget>[
                Text(
                  '由于openapi限制，必须登录才能获取资讯！\n去登录',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )
        ],
      );
    } else {
      return RefreshIndicator(
          child: buildListView(), onRefresh: _pullToRefresh);
    }
  }

  Future<Null> _pullToRefresh() async {
    curPage = 1;
    getNewsList(false);
    return null;
  }

  Widget buildListView() {
    if (newsList == null) {
      getNewsList(false);
      return CupertinoActivityIndicator();
    }
    return ListView.builder(
        itemCount: newsList.length + 1,
        controller: _scrollController,
        itemBuilder: (context, index) {
          if (index == newsList.length) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CupertinoActivityIndicator(),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text('加载中...')
                  ],
                ),
              ),
            );
          }
          return NewsListItem(newsList: newsList[index]);
        });
  }

  getNewsList(bool isLoadMore) async {
    DataUtils.isLogin().then((isLogin) {
      if (isLogin) {
        DataUtils.getAccessToken().then((accessToken) {
          if (accessToken == null && accessToken.isEmpty) {
            return;
          }
          print('curPage:$curPage');
          Map<String, dynamic> params = Map<String, dynamic>();
          params['access_token'] = accessToken;
          params['catalog'] = 1;
          params['page'] = curPage;
          params['pageSize'] = 20;
          params['dataType'] = 'json';
          NetUtils.get(AppUrls.NEWS_LIST, params).then((data) {
            print('NEWS_LIST: $data');
            if (data != null && data.isNotEmpty) {
              Map<String, dynamic> map = json.decode(data);
              List _newsList = map['newslist'];
              if (!mounted) return;
              setState(() {
                if (isLoadMore) {
                  newsList.addAll(_newsList);
                } else {
                  newsList = _newsList;
                }
              });
            }
          });
        });
      }
    });
  }
}
