// 设置页面（抽屉也使用该页面）
// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../Global/Global.dart';
import '../Global/HttpRequest.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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

  // 创建设置选项
  Widget _creatSettingItem(
      {required String title, // 设置名称
      required String dialogTitle, // 设置值名称
      required List<Widget> Function() fun}) {
    // 遍历函数
    return ListTile(
        title: Text(
          title,
          style: TextStyle(color: Global.themeColor, fontSize: 30),
        ),
        trailing: Icon(
          Icons.keyboard_arrow_right,
          color: Global.themeColor,
        ),
        // 创建dialog
        onTap: () async {
          await showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(title: Text(dialogTitle), children: fun());
              });
        },
        contentPadding: const EdgeInsets.all(5)); // 设置边距
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
        // 设置内边距
        padding: const EdgeInsets.all(10),
        // 设置每条List的分隔符
        children: [
          // 分割线
          const Divider(),
          _creatSettingItem(
              title: "界面颜色",
              dialogTitle: "选择颜色",
              fun: () {
                List<Widget> list = Global.themeColorList.map((vaule) {
                  return SimpleDialogOption(
                      onPressed: () {
                        // 修改全局变量
                        Global.themeColor = vaule;
                        // 修改数据库
                        HttpRequest.post("/updateThemeInfo", {
                          "key": "themeColor",
                          "vaule": Global.themeColor.value.toString()
                        });
                        // 提示变量已修改
                        Global.listening.listen();
                        // 退出dialog
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.square,
                        color: vaule,
                      ));
                }).toList();
                return list;
              }),
          const Divider(),
          _creatSettingItem(
              title: "界面背景",
              dialogTitle: "选择背景",
              fun: () {
                List<Widget> list = Global.imgPathList.map((vaule) {
                  return SimpleDialogOption(
                      onPressed: () {
                        Global.imgPath = vaule;
                        HttpRequest.post("/updateThemeInfo",
                            {"key": "img", "vaule": Global.imgPath});
                        Global.listening.listen();
                        Navigator.pop(context);
                      },
                      child: Image(image: AssetImage(vaule)));
                }).toList();
                return list;
              }),
          const Divider(),
          _creatSettingItem(
              title: "图像透明度",
              dialogTitle: "值",
              fun: () {
                List<Widget> list = [];
                for (double opacity in [
                  0,
                  0.1,
                  0.2,
                  0.3,
                  0.4,
                  0.5,
                  0.6,
                  0.7,
                  0.8,
                  0.9,
                  1.0
                ]) {
                  list.add(SimpleDialogOption(
                      onPressed: () {
                        Global.opacity = opacity;
                        HttpRequest.post("/updateThemeInfo", {
                          "key": "opacity",
                          "vaule": Global.opacity.toString()
                        });
                        Global.listening.listen();
                        Navigator.pop(context);
                      },
                      child: Text(opacity.toString())));
                }
                return list;
              }),
          const Divider(),
          _creatSettingItem(
              title: "图标尺寸",
              dialogTitle: "选择尺寸",
              fun: () {
                List<Widget> list = Global.iconsList.map((vaule) {
                  return SimpleDialogOption(
                      onPressed: () {
                        Global.icons = vaule;
                        HttpRequest.post("/updateThemeInfo", {
                          "key": "size",
                          "vaule": Global.icons['size'] ?? '60'
                        });
                        Global.listening.listen();
                        Navigator.pop(context);
                      },
                      child: Text(vaule["name"] ?? ""));
                }).toList();
                return list;
              }),
          const Divider()
        ]);
  }
}
