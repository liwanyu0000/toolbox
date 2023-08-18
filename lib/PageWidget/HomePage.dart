// ignore_for_file: file_names
// 主页
import 'package:flutter/material.dart';
// import '../Global/Global.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Home"));
    // return Container();
  }
}

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const Center(child: Text("HomePage"));
//   }
// }
