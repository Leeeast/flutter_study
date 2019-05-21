import 'package:flutter/material.dart';

class DiscoveryPage extends StatefulWidget {
  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  List<Map<String, IconData>> blocks = [
    {
      '开源众包': Icons.looks,
      '开源软件': Icons.ac_unit,
      '码云推荐': Icons.fiber_smart_record,
      '代码片段': Icons.code,
    },
    {
      '扫一扫': Icons.view_agenda,
      '摇一摇': Icons.vibration,
    },
    {
      '附近程序员': Icons.near_me,
      '码云封面人物': Icons.person,
      '线下活动': Icons.local_activity,
    }
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: blocks.length,
      itemBuilder: (BuildContext context, blockIndex) {
        return Container(
          margin: const EdgeInsets.only(bottom: 30.0),
          decoration: BoxDecoration(
              border: Border(
                  top: BorderSide(width: 0.5, color: Color(0xffcccccc)),
                  bottom: BorderSide(width: 0.5, color: Color(0xffcccccc)))),
          child: ListView.separated(
              //处理滑动冲突
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, mapIndex) {
                return InkWell(
                    onTap: () {},
                    child: Container(
                      height: 60.0,
                      alignment: Alignment.center,
                      child: ListTile(
                        leading:
                            Icon(blocks[blockIndex].values.elementAt(mapIndex)),
                        title:
                            Text(blocks[blockIndex].keys.elementAt(mapIndex)),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ));
              },
              separatorBuilder: (context, index) {
                return Divider(
                    indent: 64.0, height: 1.0, color: Color(0xffcccccc));
              },
              itemCount: blocks[blockIndex].length),
        );
      },
    );
  }
}
