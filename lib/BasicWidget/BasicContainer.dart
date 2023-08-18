// ignore_for_file: file_names

import 'package:flutter/material.dart';
import '../Global/Global.dart';

// 基础页面（统一背景图像）
creatBasicContainer(Widget widgets) {
  return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Global.imgPath),
              opacity: Global.opacity,
              fit: BoxFit.cover)),
      child: widgets);
}
