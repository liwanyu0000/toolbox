// 设置页面（抽屉也使用该页面）
// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../Global/Global.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  // 创建设置选项
  Widget _creatSettingItem(
      {required String title, // 设置名称
      required String dialogTitle, // 设置值名称
      required List<Widget> Function() fun}) {
    // 遍历函数
    return ListTile(
        title: Text(title),
        trailing: const Icon(Icons.keyboard_arrow_right),
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
                List<Widget> list = [];
                for (Color color in Global.themeColorList) {
                  list.add(SimpleDialogOption(
                      onPressed: () {
                        // 修改全局变量
                        Global.themeColor = color;
                        // 提示变量已修改
                        Global.listening.listen();
                        // 退出dialog
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.square,
                        color: color,
                      )));
                }
                return list;
              }),
          const Divider(),
          _creatSettingItem(
              title: "界面背景",
              dialogTitle: "选择背景",
              fun: () {
                List<Widget> list = [];
                for (String imgPath in Global.imgPathList) {
                  list.add(SimpleDialogOption(
                      onPressed: () {
                        Global.imgPath = imgPath;
                        Global.listening.listen();
                        Navigator.pop(context);
                      },
                      child: Image(image: AssetImage(imgPath))));
                }
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
                        Global.listening.listen();
                        Navigator.pop(context);
                      },
                      child: Text(opacity.toString())));
                }
                return list;
              }),
          const Divider(),
          // _creatSettingItem("工具图标尺寸", () {}),
          // const Divider()
        ]);
  }
}
