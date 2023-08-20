// ignore_for_file: file_names
// 主页
import 'package:flutter/material.dart';
import '../BasicWidget/BasicToolBox.dart';
import '../Global/Global.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //响应监听
  @override
  void initState() {
    super.initState();
    Global.listening.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  List<Widget> _getWidgetLisst(List<Map> list, {bool isTopRightIcon = true}) {
    return list.map((vaule) {
      if (isTopRightIcon) {
        return ToolButton(vaule["toolTypeName"], vaule["index"],
            ceratStarButton(vaule["toolTypeName"], vaule["index"]));
      } else {
        return ToolButton(vaule["toolTypeName"], vaule["index"],
            creatDeleteButton(vaule["toolTypeName"], vaule["index"]));
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      children: [
        creatToolBox(
            "最近浏览", _getWidgetLisst(Global.seeToolList, isTopRightIcon: false)),
        creatToolBox("我的收藏", _getWidgetLisst(Global.starToolList))
      ],
    );
  }
}
