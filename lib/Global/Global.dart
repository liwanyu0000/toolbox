// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../PageWidget/AllToolPage.dart';
import '../PageWidget/HomePage.dart';
import '../PageWidget/SettingPage.dart';
import './HttpRequest.dart';
import '../ToolRouter/NonToolRouter.dart';
import '../ToolRouter//Timer/TimerToolRouter.dart';

class Global {
  // 页面索引
  static int pageIndex = 1;
  // 页面信息
  static List pageInfoList = [
    {"title": "all tool", "page": const AllToolPage()},
    {"title": "home", "page": const HomePage()},
    {"title": "setting", "page": const SettingPage()}
  ];
  // 主题颜色
  static Color themeColor = Colors.blue;
  static List themeColorList = [
    Colors.red[300],
    Colors.green,
    Colors.blue,
    Colors.pink,
    Colors.orange,
    Colors.yellow,
    Colors.black,
  ];
  // 背景图像
  static String imgPath = "images/1.jpg";
  static List imgPathList = [
    "images/1.jpg",
    "images/2.jpg",
    "images/3.jpg",
    "images/4.jpg",
    "images/5.jpg",
    "images/6.jpg",
    "images/7.jpg",
    "images/8.png",
    "images/9.jpg",
    "images/10.jpg",
    "images/11.png",
    "images/12.jpg",
    "images/13.jpg",
  ];
  // 图像透明度
  static double opacity = 0.5;
  // 图标尺寸
  static Map<String, String> icons = {"name": "小图标", 'size': "80"};
  static List<Map<String, String>> iconsList = [
    {"name": "超小图标", 'size': "60"},
    {"name": "小图标", 'size': "70"},
    {"name": "中等图标", 'size': "80"},
    {"name": "大图标", 'size': "90"},
    {"name": "超大图标", 'size': "100"},
  ];
  // 开始监听监听
  static Listening listening = Listening();
  // className与ToolRouter的映射
  static Map<String, Widget> getToolRouter = {"Timer": const TimerToolRouter()};
  // 图标映射
  static Map<String, IconData> getIcon = {"Timer": Icons.timer};
  // 工具列表
  static Map<String, List<Tool>> toolList = {};
  // 收藏管理列表
  static List<Map> starToolList = [];
  // 最近浏览列表
  static List<Map> seeToolList = [];
}

// 继承ChangeNotifier实现变量监听
class Listening extends ChangeNotifier {
  // 通知
  listen() {
    notifyListeners();
  }
}

// 工具类
class Tool {
  Tool(
      {required this.id,
      required this.name,
      required this.isStar,
      required this.seeCount,
      required this.className,
      required this.icon});
  setStar() => isStar = !isStar; //更改收藏主题
  see() => seeCount++; // 更改浏览次数
  noSee() => seeCount = 0; // 重置浏览次数
  int id; // 数据库中的id
  String name; // 工具名称
  bool isStar; // 是否收藏
  int seeCount; // 浏览次数
  Widget className; // 对应的ToolRouter
  IconData icon; // 工具图标
}

// 获取工具列表
getToolList() async {
  var toolList = await HttpRequest.get("/gettool");
  if (toolList != "error") {
    // 将字符串转为Json
    var toolLists = stringToJson(toolList);
    for (Map tool in toolLists) {
      // 如果key不存在, 创建空list
      if (!Global.toolList.containsKey(tool["typename"])) {
        Global.toolList[tool["typename"]] = [];
      }
      Global.toolList[tool["typename"]]?.add(Tool(
          id: tool["id"],
          name: tool["name"],
          isStar: tool["isStar"] == 0 ? false : true,
          seeCount: tool["seeCount"],
          className:
              Global.getToolRouter[tool["className"]] ?? const NonToolRouter(),
          icon: Global.getIcon[tool["icon"]] ?? Icons.question_mark_rounded));
    }
    return true;
  } else {
    return false;
  }
}

// 获取收藏工具列表
getStarToolList() {
  // 置空starToolList
  Global.starToolList = [];
  Global.toolList.forEach((key, value) {
    for (int i = 0; i < value.length; i++) {
      if (value[i].isStar) {
        Global.starToolList.add({"toolTypeName": key, "index": i});
      }
    }
  });
}

// 获取最近浏览工具列表
getSeeToolList() {
  // 置空starToolList
  Global.seeToolList = [];
  Global.toolList.forEach((key, value) {
    for (int i = 0; i < value.length; i++) {
      if (value[i].seeCount > 0) {
        Global.seeToolList.add({"toolTypeName": key, "index": i});
      }
    }
  });
}
