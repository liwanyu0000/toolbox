// ignore_for_file: file_names, no_logic_in_create_state
// 基础工具容器，工具按钮
import 'package:flutter/material.dart';
import '../Global/Global.dart';
import '../Global/HttpRequest.dart';

// 创建工具列表
List<Widget> creatToolList(List<Widget> widgetList) {
  List<Widget> list = [];
  for (Widget widgst in widgetList) {
    list.add(SizedBox(
        width: double.parse(Global.icons["size"] ?? "80"),
        height: double.parse(Global.icons["size"] ?? "80"),
        child: widgst));
  }
  return list;
}

// 创建装工具图标的box
Widget creatToolBox(String title, List<Widget> widgetList,
    {CrossAxisAlignment alignment = CrossAxisAlignment.start}) {
  return Column(crossAxisAlignment: alignment, children: [
    Text(title,
        style: TextStyle(
            color: Global.themeColor,
            fontSize: double.parse(Global.icons['size'] ?? "80") / 3)),
    Divider(height: 20, thickness: 3, color: Global.themeColor),
    Center(
        child: Wrap(
            spacing: 10, runSpacing: 10, children: creatToolList(widgetList))),
    Divider(height: 20, thickness: 10, color: Global.themeColor)
  ]);
}

// 创建收藏按钮
Widget ceratStarButton(String toolTypeName, int index,
    {double? size, Color? color}) {
  return SizedBox(
      width: size ?? double.parse(Global.icons["size"] ?? "80") * 0.3,
      height: size ?? double.parse(Global.icons["size"] ?? "80") * 0.3,
      child: RawMaterialButton(
          onPressed: () {
            // 更改收藏状态
            Global.toolList[toolTypeName]![index].setStar();
            // 修改数据库
            HttpRequest.post("/updateToolInfo", {
              "key": "isStar",
              "vaule": (Global.toolList[toolTypeName]![index].isStar ? 1 : 0)
                  .toString(),
              "id": Global.toolList[toolTypeName]![index].id.toString()
            });
            // 重新加载收藏工具列表
            getStarToolList();
            // 通知页面刷新
            Global.listening.listen();
          },
          child: Icon(
              Global.toolList[toolTypeName]![index].isStar
                  ? Icons.star
                  : Icons.star_border,
              color: color ?? Global.themeColor,
              size: size ?? double.parse(Global.icons["size"] ?? "80") * 0.3)));
}

// 创建删除按钮
Widget creatDeleteButton(String toolTypeName, int index, {double? size}) {
  return SizedBox(
      width: size ?? double.parse(Global.icons["size"] ?? "80") * 0.3,
      height: size ?? double.parse(Global.icons["size"] ?? "80") * 0.3,
      child: RawMaterialButton(
          onPressed: () {
            // 重置浏览次数
            Global.toolList[toolTypeName]![index].noSee();
            // 修改数据库
            HttpRequest.post("/updateToolInfo", {
              "key": " seeCount",
              "vaule": "0",
              "id": Global.toolList[toolTypeName]![index].id.toString()
            });
            // 重新获取浏览列表
            getSeeToolList();
            // 通知页面刷新
            Global.listening.listen();
          },
          child: Icon(
            Icons.delete,
            color: Colors.red,
            size: size ?? double.parse(Global.icons["size"] ?? "80") * 0.3,
          )));
}

// 工具图标（本质是一个按钮）
class ToolButton extends StatelessWidget {
  const ToolButton(
    this.toolTypeName,
    this.index,
    this.topRightIcon, {
    super.key,
  });
  final String toolTypeName;
  final int index;
  final Widget topRightIcon;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      // 点击跳转页面
      onPressed: () {
        // 修改浏览次数
        Global.toolList[toolTypeName]![index].see();
        // 重新加载浏览列表(当seeCount等于1时才执行)
        if (Global.toolList[toolTypeName]![index].seeCount == 1) {
          getSeeToolList();
          // 界面刷新
          Global.listening.listen();
        }
        // 修改数据库
        HttpRequest.post("/updateToolInfo", {
          "key": " seeCount",
          "vaule": (Global.toolList[toolTypeName]![index].seeCount).toString(),
          "id": Global.toolList[toolTypeName]![index].id.toString()
        });
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => BasicToolRouter(toolTypeName, index)),
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          // 图标
          Align(
              alignment: Alignment.topCenter,
              child: Icon(Global.toolList[toolTypeName]?[index].icon,
                  size: double.parse(Global.icons["size"] ?? "80") * 0.7)),
          // 文字
          Align(
              alignment: Alignment.bottomCenter,
              child: Text(Global.toolList[toolTypeName]![index].name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Global.themeColor,
                      fontSize:
                          double.parse(Global.icons["size"] ?? "80") * 0.2))),
          // 是否收藏
          Align(alignment: Alignment.topRight, child: topRightIcon)
        ],
      ),
    );
  }
}

// 基础工具页面
class BasicToolRouter extends StatefulWidget {
  const BasicToolRouter(this.toolTypeName, this.index, {super.key});
  final String toolTypeName;
  final int index;
  @override
  State<BasicToolRouter> createState() =>
      _BasicToolRouterState(toolTypeName, index);
}

class _BasicToolRouterState extends State<BasicToolRouter> {
  _BasicToolRouterState(this.toolTypeName, this.index);
  final String toolTypeName;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Global.themeColor,
            title:
                Center(child: Text(Global.toolList[toolTypeName]![index].name)),
            actions: [
              ceratStarButton(toolTypeName, index,
                  size: 30, color: Colors.white)
            ]),
        body: Global.toolList[toolTypeName]![index].className);
  }
}
