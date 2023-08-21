// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:toolbox/BasicWidget/BasicContainer.dart';
import 'package:toolbox/Global/Global.dart';
import 'package:toolbox/Global/HttpRequest.dart';
import 'package:toolbox/Global/DiaryIcon.dart';

class Diary {
  // 获取日志列表
  static getDiary() async {
    var strDiaryList = await HttpRequest.get("/getDiaryInfo");
    if (strDiaryList != "error") {
      diaryList = [];
      var diaryListTmp = stringToJson(strDiaryList);
      for (Map diary in diaryListTmp) {
        diaryList.add(Diary(
            id: diary['id'],
            title: diary["title"],
            content: diary["content"],
            creatTime: diary["create_time"],
            weatherIcon: diary["weather"]));
      }
    }
    Global.listening.listen();
  }

  // 日记列表
  static List<Diary> diaryList = [];
  // 天气图标列表
  static List<IconData> weatherIconList = [
    DiaryIcon.qingtian,
    DiaryIcon.yintian,
    DiaryIcon.xiaoyu,
    DiaryIcon.baoyu,
    DiaryIcon.dongyu,
    DiaryIcon.leiyu,
    DiaryIcon.zhenyu,
    DiaryIcon.dayu,
    DiaryIcon.daxue,
    DiaryIcon.wumai
  ];
  Diary(
      {required this.id,
      required this.title,
      required this.content,
      required this.creatTime,
      required this.weatherIcon});
  int id; // id
  String title; //标题
  String content; //内容
  String creatTime; // 创建时间
  int weatherIcon; // 天气图标
}

class EditDiary extends StatefulWidget {
  const EditDiary({this.index = -1, super.key});
  final int index;
  @override
  State<EditDiary> createState() =>
      // ignore: no_logic_in_create_state
      _EditDiaryState(index);
}

class _EditDiaryState extends State<EditDiary> {
  _EditDiaryState(this.index) {
    if (index == -1) {
      _inputDiaryTitle = "";
      _inputDiaryContent = "";
      _inputDiaryWeather = 0;
    } else {
      _inputDiaryTitle = Diary.diaryList[index].title;
      _inputDiaryContent = Diary.diaryList[index].content;
      _inputDiaryWeather = Diary.diaryList[index].weatherIcon;
    }
  }
  final int index;
  // ignore: prefer_final_fields
  late String _inputDiaryTitle;
  // ignore: prefer_final_fields
  late String _inputDiaryContent;
  late int _inputDiaryWeather;
  List<DropdownMenuItem<int>> _creatItem() {
    List<DropdownMenuItem<int>> list = [];
    for (int i = 0; i < Diary.weatherIconList.length; i++) {
      list.add(DropdownMenuItem(
          value: i,
          child: Icon(Diary.weatherIconList[i],
              color: Colors.amber[800], size: 30)));
    }
    return list;
  }

  _showError() async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("ERROR"),
            content: const Text("标题不能为空"),
            actions: <Widget>[
              TextButton(
                  child: const Text("OK"),
                  onPressed: () => Navigator.pop(context, "cancel"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Global.themeColor,
            title: const Center(child: Text("编辑日记")),
            actions: [
              IconButton(
                  onPressed: index == -1
                      ? () async {
                          if (_inputDiaryTitle == "") {
                            _showError();
                            return;
                          }
                          HttpRequest.post("/insertDiaryInfo", {
                            "title": _inputDiaryTitle,
                            "content": _inputDiaryContent,
                            "weather": _inputDiaryWeather.toString()
                          });
                          Diary.getDiary();
                          Navigator.pop(context);
                        }
                      : () {
                          if (_inputDiaryTitle == "") {
                            _showError();
                            return;
                          }
                          Diary.diaryList[index].title = _inputDiaryTitle;
                          Diary.diaryList[index].content = _inputDiaryContent;
                          Diary.diaryList[index].weatherIcon =
                              _inputDiaryWeather;
                          HttpRequest.post("/updateDiaryInfo", {
                            "id": Diary.diaryList[index].id.toString(),
                            "title": Diary.diaryList[index].title,
                            "content": Diary.diaryList[index].content,
                            "weather":
                                Diary.diaryList[index].weatherIcon.toString()
                          });
                          Navigator.pop(context);
                          Global.listening.listen();
                        },
                  icon: const Icon(Icons.save))
            ]),
        body: creatBasicContainer(
            ListView(padding: const EdgeInsets.all(20), children: [
          TextField(
              decoration: InputDecoration(
                  label: const Text("标题"),
                  hintText: _inputDiaryTitle == "" ? "请输入标题" : ""),
              controller: TextEditingController(text: _inputDiaryTitle),
              onChanged: (text) {
                _inputDiaryTitle = text;
              }),
          Row(children: [
            const Text("天气"),
            DropdownButton(
              items: _creatItem(),
              onChanged: (value) {
                setState(() {
                  _inputDiaryWeather = value!;
                });
              },
              value: _inputDiaryWeather,
            )
          ]),
          TextField(
              decoration: InputDecoration(
                  label: const Text("内容"),
                  hintText: _inputDiaryContent == "" ? "请输入内容" : ""),
              maxLines: null,
              controller: TextEditingController(text: _inputDiaryContent),
              onChanged: (text) {
                _inputDiaryContent = text;
              })
        ])));
  }
}
