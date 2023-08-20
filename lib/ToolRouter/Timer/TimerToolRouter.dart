// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:toolbox/BasicWidget/BasicContainer.dart';
import 'TimerText.dart';
import 'package:toolbox/Global/Global.dart';

class TimerToolRouter extends StatefulWidget {
  const TimerToolRouter({super.key});

  @override
  State<TimerToolRouter> createState() => _TimerToolRouterState();
}

class _TimerToolRouterState extends State<TimerToolRouter> {
  // 计时器
  Stopwatch stopwatch = Stopwatch();
  // 记录时间的列表
  List<String> history = [];
  @override
  Widget build(BuildContext context) {
    return creatBasicContainer(Column(
      children: <Widget>[
        SizedBox(
            height: 200.0,
            child: Center(
              child: TimerText(stopwatch),
            )),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              FloatingActionButton(
                  backgroundColor: Global.themeColor,
                  onPressed: () {
                    // 暂停或开始
                    setState(() {
                      if (stopwatch.isRunning) {
                        stopwatch.stop();
                      } else {
                        // 开始前, 如果时间是0, 重置记录的时间列表
                        if (stopwatch.elapsedMilliseconds == 0) {
                          history = [];
                        }
                        stopwatch.start();
                      }
                    });
                  },
                  child: Text(stopwatch.isRunning ? "暂停" : "开始",
                      style: const TextStyle(
                          fontSize: 16.0, color: Colors.white))),
              FloatingActionButton(
                  backgroundColor: Global.themeColor,
                  // 注意：同时存在两个FloatingActionButton时, 另一个的heroTag必须覆盖，否则会冲突
                  heroTag: 'other',
                  // 记录或重置
                  onPressed: () {
                    setState(() {
                      if (stopwatch.isRunning) {
                        // 在头部插入新数据
                        history.insert(
                            0,
                            TimerTextFormatter.format(
                                stopwatch.elapsedMilliseconds));
                      } else {
                        stopwatch.reset();
                      }
                    });
                  },
                  child: Text(stopwatch.isRunning ? "记录" : "重置",
                      style:
                          const TextStyle(fontSize: 16.0, color: Colors.white)))
            ]),
        // 必须使用Expanded包裹ListView
        Expanded(
            child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 50),
                itemCount: history.length,
                itemBuilder: (BuildContext context, int index) {
                  return Text(
                    history[index],
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 40, color: Global.themeColor),
                  );
                }))
      ],
    ));
  }
}
