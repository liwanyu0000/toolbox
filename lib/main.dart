import 'package:flutter/material.dart';
import 'Global/Global.dart';
import 'BasicWidget/BasicContainer.dart';
import 'PageWidget/SettingPage.dart';
import 'PageWidget/ErrorPage.dart';
import 'Global/HttpRequest.dart';

void main(List<String> args) async {
  // 从数据库获取配置信息，更改设置, 如果获取失败，显示网络错误页面
  var themeInfo = await HttpRequest.get("/getThemeInfo");
  var isOK = await getToolList();
  getSeeToolList();
  getStarToolList();
  if (themeInfo != "error" && isOK) {
    Global.themeColor = Color(stringToJson(themeInfo)[0]['themeColor']);
    Global.imgPath = stringToJson(themeInfo)[0]['img'];
    Global.opacity =
        double.parse(stringToJson(themeInfo)[0]['opacity'].toString());
    Global.icons["size"] = stringToJson(themeInfo)[0]['size'].toString();
    runApp(const App());
  } else {
    runApp(const ErrorPage("网络错误", Icons.error));
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  //响应监听
  @override
  void initState() {
    super.initState();
    Global.listening.addListener(() {
      setState(() {});
    });
  }

  // 结束监听
  @override
  void dispose() {
    super.dispose();
    Global.listening.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: '工具箱',
        home: Scaffold(
            appBar: AppBar(
                backgroundColor: Global.themeColor,
                title: Center(
                    child:
                        Text(Global.pageInfoList[Global.pageIndex]["title"]))),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: Global.pageIndex,
                selectedIconTheme: const IconThemeData(size: 30),
                unselectedIconTheme: const IconThemeData(size: 25),
                selectedItemColor: Global.themeColor,
                unselectedItemColor: const Color.fromARGB(255, 155, 152, 152),
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.all_inbox_outlined), label: "全部工具"),
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: "主页"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: "设置")
                ],
                onTap: (index) {
                  setState(() {
                    Global.pageIndex = index;
                  });
                }),
            drawer: const Drawer(width: 250, child: SettingPage()),
            body: creatBasicContainer(
                Global.pageInfoList[Global.pageIndex]["page"])));
  }
}
