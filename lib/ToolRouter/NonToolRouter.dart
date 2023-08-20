// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../BasicWidget/BasicContainer.dart';

class NonToolRouter extends StatelessWidget {
  const NonToolRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return creatBasicContainer(const Center(
        child: Text(
      "该页面暂未实现",
      style: TextStyle(fontSize: 30),
    )));
  }
}
