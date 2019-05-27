import 'dart:convert';

import 'package:FlutterStudy/oschina/common/event_bus.dart';
import 'package:FlutterStudy/oschina/constants/constants.dart';
import 'package:FlutterStudy/oschina/pages/login_web_page.dart';
import 'package:FlutterStudy/oschina/utils/data_utils.dart';
import 'package:FlutterStudy/oschina/utils/net_utils.dart';
import 'package:FlutterStudy/oschina/widgets/tweet_list.item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TweetPage extends StatefulWidget {
  @override
  _TweetPageState createState() => _TweetPageState();
}

class _TweetPageState extends State<TweetPage>
    with SingleTickerProviderStateMixin {
  List _tabTitles = ['最新', '热门', '我的'];
  List latestTweetList;
  List hotTweetList;
  List myTweetList;
  int latestCurPage = 1;
  int hotCurPage = 1;
  int myCurPage = 1;
  int curPage = 1;
  ScrollController _controller = ScrollController();
  TabController _tabController;
  bool isLogin = false;
  int user = 0;
  int myUserId = 0;
  bool noMoreData = false;

  @override
  void initState() {
    super.initState();
    DataUtils.getUserInfo().then((userInfo) {
      myUserId = userInfo.id;
    });
    _tabController = TabController(length: _tabTitles.length, vsync: this);
    _tabController.addListener(() {
      switch (_tabTitles[_tabController.index]) {
        case '最新':
          user = 0;
          break;
        case '热门':
          user = -1;
          break;
        case '我的':
          user = myUserId;
          break;
      }
    });
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;
      var pixels = _controller.position.pixels;
      if (maxScroll == pixels) {
        if (user == 0) {
          latestCurPage++;
          curPage = latestCurPage;
        } else if (user == -1) {
          hotCurPage++;
          curPage = hotCurPage;
        } else {
          myCurPage++;
          curPage = myCurPage;
        }
        getTweetList(isLoadMore: true, user: user);
      }
    });
    DataUtils.isLogin().then((isLogin) {
      if (!mounted) return;
      setState(() {
        this.isLogin = isLogin;
      });
    });
    eventBus.on<LoginEvent>().listen((event) {
      if (!mounted) return;
      setState(() {
        this.isLogin = isLogin;
      });
      getTweetList(isLoadMore: false, user: user);
    });
    eventBus.on<LogoutEvent>().listen((event) {
//      _showUerInfo();
    });
  }

  getTweetList({bool isLoadMore, int user}) {
    DataUtils.isLogin().then((isLogin) {
      if (isLogin) {
        DataUtils.getAccessToken().then((accessToken) {
          if (accessToken == null || accessToken.length == 0) {
            return;
          }
          Map<String, dynamic> params = Map<String, dynamic>();
          params['access_token'] = accessToken;
          params['user'] = user;
          params['page'] = curPage;
          params['pageSize'] = 10;
          params['dataType'] = 'json';
          NetUtils.get(AppUrls.TWEET_LIST, params).then((data) {
            print('TWEET_LIST: $data');
            if (data != null && data.isNotEmpty) {
              List _tweetList;
              try {
                Map<String, dynamic> map = json.decode(data);
                _tweetList = map['tweetlist'];
              } catch (e) {
                print('TWEET_LIST: $e');
              }
              if (!mounted) return;
              if (_tweetList == null || _tweetList.isEmpty) {
                setState(() {
                  noMoreData = true;
                });
              } else {
                setState(() {
                  if (_tweetList.length < 10) {
                    noMoreData = true;
                  } else {
                    noMoreData = false;
                  }
                  if (isLoadMore) {
                    if (user == 0) {
                      latestTweetList.addAll(_tweetList);
                    } else if (user == -1) {
                      hotTweetList.addAll(_tweetList);
                    } else {
                      myTweetList.addAll(_tweetList);
                    }
                  } else {
                    if (user == 0) {
                      latestTweetList = _tweetList;
                    } else if (user == -1) {
                      hotTweetList = _tweetList;
                    } else {
                      myTweetList = _tweetList;
                    }
                  }
                });
              }
            }
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!isLogin) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  '必须登录才能查看动弹信息！\n马上登录',
                  style: TextStyle(color: Color(0xff0000ff)),
                  textAlign: TextAlign.center,
                ),
              ),
              onTap: () async {
                //TODO 跳转登录
                final result = await Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginWebPage()));
                if (result != null && result == 'refresh') {
                  //登录成功
                  eventBus.fire(LoginEvent());
                }
              },
            ),
          ],
        ),
      );
    }
    return Column(
      children: <Widget>[
        Container(
          color: Color(AppColors.APP_THEME),
          child: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              tabs: _tabTitles.map((title) {
                return Tab(text: title);
              }).toList()),
        ),
        Expanded(
            child: TabBarView(
          controller: _tabController,
          children: [
            _buildTweetList(0),
            _buildTweetList(-1),
            _buildTweetList(myUserId)
          ],
        ))
      ],
    );
  }

  Future<int> _pullToRefresh() async {
    curPage = 1;
    getTweetList(isLoadMore: false, user: user);
    return null;
  }

  Widget _buildTweetList(int user) {
    var tweetList =
        user == 0 ? latestTweetList : user == -1 ? hotTweetList : myTweetList;
    if (tweetList == null) {
      getTweetList(isLoadMore: false, user: user);
      return Center(child: new CircularProgressIndicator());
    }
    var tweetListLength = user == 0
        ? latestTweetList.length
        : user == -1 ? hotTweetList.length : myTweetList.length;
    return RefreshIndicator(
      onRefresh: _pullToRefresh,
      child: ListView.separated(
        controller: _controller,
        itemBuilder: (BuildContext context, int index) {
          var tweetListLength = user == 0
              ? latestTweetList.length
              : user == -1 ? hotTweetList.length : myTweetList.length;
          if (index == tweetListLength) {
            if (noMoreData) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text('已经到底了'),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CupertinoActivityIndicator(),
                  SizedBox(
                    width: 20.0,
                  ),
                  Text('正在加载...'),
                ],
              )),
            );
          }
          Map<String, dynamic> tweet = user == 0
              ? latestTweetList[index]
              : user == -1 ? hotTweetList[index] : myTweetList[index];
          return TweetListItem(tweetData: tweet);
        },
        separatorBuilder: (context, index) {
          return Container(
            height: 10.0,
            color: Colors.grey[200],
          );
        },
        itemCount: tweetListLength + 1,
      ),
    );
  }
}
