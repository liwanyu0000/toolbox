// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:toolbox/BasicWidget/BasicContainer.dart';
import 'package:toolbox/Global/Global.dart';
import 'package:toolbox/Global/HttpRequest.dart';
import 'Diarr.dart';

class DiaryToolRouter extends StatefulWidget {
  const DiaryToolRouter({super.key});

  @override
  State<DiaryToolRouter> createState() => _DiaryToolRouterState();
}

class _DiaryToolRouterState extends State<DiaryToolRouter> {
  //响应监听
  @override
  void initState() {
    super.initState();
    Diary.getDiary();
    Global.listening.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return creatBasicContainer(Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const EditDiary()));
            },
            icon: Icon(
              Icons.add_circle,
              color: Global.themeColor,
              size: 50,
            )),
        Expanded(
          child: ListView.builder(
            itemCount: Diary.diaryList.length,
            padding: const EdgeInsets.all(20),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Row(children: [
                      Text(Diary.diaryList[index].title),
                      Icon(
                          Diary.weatherIconList[
                              Diary.diaryList[index].weatherIcon],
                          color: Colors.amber[800],
                          size: 30),
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditDiary(index: index)),
                            );
                          },
                          icon: const Icon(Icons.edit)),
                      IconButton(
                          onPressed: () {
                            HttpRequest.post("/deleteDiaryInfo",
                                {"id": Diary.diaryList[index].id.toString()});
                            Diary.getDiary();
                          },
                          icon: const Icon(Icons.delete))
                    ]),
                    Text(Diary.diaryList[index].content),
                    Text(Diary.diaryList[index].creatTime)
                  ]));
            },
          ),
        )
      ],
    ));
  }
}
