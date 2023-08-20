// ignore_for_file: file_names
import 'package:flutter/material.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage(this.msg, this.icons, {super.key});
  final String msg;
  final IconData icons;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ERROR',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('ERROR'),
          ),
          body: Center(
            child: Column(children: [Icon(icons, size: 80), Text(msg)]),
          )),
    );
  }
}
