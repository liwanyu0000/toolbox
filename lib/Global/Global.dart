// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../PageWidget/AllToolPage.dart';
import '../PageWidget/HomePage.dart';
import '../PageWidget/SettingPage.dart';

class Global {
  // 页面索引
  static int pageIndex = 1;
  // 页面信息
  static List pageInfoList = [
    {"title": "all tool", "page": AllToolPage()},
    {"title": "home", "page": HomePage()},
    {"title": "setting", "page": SettingPage()}
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
  // 监听一些变量
  static Listening listening = Listening();
}

// 继承ChangeNotifier实现变量监听
class Listening extends ChangeNotifier {
  // 通知
  listen() {
    notifyListeners();
  }
}
