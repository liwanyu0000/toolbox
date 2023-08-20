// ignore_for_file: file_names
// 该页面显示所有工具
import 'package:flutter/material.dart';
import '../Global/Global.dart';
import '../BasicWidget/BasicToolBox.dart';

class AllToolPage extends StatefulWidget {
  const AllToolPage({super.key});

  @override
  State<AllToolPage> createState() => _AllToolPageState();
}

class _AllToolPageState extends State<AllToolPage> {
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

  List<Widget> _getWidgetList(String toolTypeName, List<Tool> list) {
    List<Widget> widgetList = [];
    for (int i = 0; i < list.length; i++) {
      widgetList
          .add(ToolButton(toolTypeName, i, ceratStarButton(toolTypeName, i)));
    }
    return widgetList;
  }

  List<Widget> _getToolBoxList() {
    List<Widget> list = [];
    Global.toolList.forEach((key, value) {
      list.add(creatToolBox(key, _getWidgetList(key, value)));
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      children: _getToolBoxList(),
    );
  }
}
