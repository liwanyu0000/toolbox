import 'package:flutter/material.dart';
import 'Global/Global.dart';
import 'BasicWidget/BasicContainer.dart';
import 'PageWidget/SettingPage.dart';

void main(List<String> args) {
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    Global.listening.addListener(() {
      setState(() {});
    });
  }

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
                    child: Center(
                        child: Text(
                            Global.pageInfoList[Global.pageIndex]["title"])))),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: Global.pageIndex,
                selectedIconTheme: const IconThemeData(size: 30),
                unselectedIconTheme: const IconThemeData(size: 25),
                selectedItemColor: Global.themeColor,
                unselectedItemColor: const Color.fromARGB(255, 64, 56, 56),
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
