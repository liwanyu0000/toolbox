// ignore_for_file: file_names, no_logic_in_create_state

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:toolbox/Global/Global.dart';

// 格式化时间mm:ss.xxx
class TimerTextFormatter {
  static String format(int milliseconds) {
    int hundreds = (milliseconds / 10).truncate();
    int seconds = (hundreds / 100).truncate();
    int minutes = (seconds / 60).truncate();
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');
    String hundredsStr = (hundreds % 100).toString().padLeft(2, '0');
    return "$minutesStr:$secondsStr.$hundredsStr";
  }
}

class TimerText extends StatefulWidget {
  const TimerText(this.stopwatch, {super.key});
  final Stopwatch stopwatch;

  @override
  State<TimerText> createState() => _TimerTextState(stopwatch);
}

class _TimerTextState extends State<TimerText> {
  late Timer timer;
  final Stopwatch stopwatch;
  _TimerTextState(this.stopwatch) {
    timer = Timer.periodic(const Duration(milliseconds: 30), callback);
  }

  void callback(Timer timer) {
    // 当在秒表页面时并且stopwatch在运行时才刷新页面
    if (mounted && stopwatch.isRunning) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text(TimerTextFormatter.format(stopwatch.elapsedMilliseconds),
        style: TextStyle(
            fontSize: 60.0, fontFamily: "Open Sans", color: Global.themeColor));
  }
}
