import 'package:FlutterStudy/oschina/pages/news_detail_page.dart';
import 'package:FlutterStudy/oschina/utils/data_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsListItem extends StatelessWidget {
  final Map<String, dynamic> newsList;

  NewsListItem({this.newsList});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        DataUtils.isLogin().then((isLogin) {
          if (isLogin) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => NewsDetailPage(
                      id: newsList['id'],
                    )));
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.only(left: 20.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Color(0xcccccccc),
              width: 0.5,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                '${newsList['title']}',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                maxLines: 2,
                textAlign: TextAlign.left,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 10.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text(
                    '@${newsList['author']} ${newsList['pubDate'].toString().split(' ')[0]}',
                    style: TextStyle(color: Color(0xaaaaaaaa), fontSize: 14.0),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Icon(
                        Icons.mode_comment,
                        color: Color(0xaaaaaaaa),
                        size: 16.0,
                      ),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        '${newsList['commentCount']}',
                        style:
                            TextStyle(color: Color(0xaaaaaaaa), fontSize: 14.0),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
