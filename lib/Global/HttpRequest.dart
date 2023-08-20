// ignore_for_file: file_names

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

dynamic stringToJson(String str) {
  return convert.jsonDecode(str);
}

class HttpRequest {
  //创建client实例
  static final _client = http.Client();
  static get(String url) async {
    http.Response response = await _client
        .get(Uri(scheme: "http", host: "liwanyu.top", path: "/api$url"))
        .timeout(const Duration(seconds: 2));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return "error";
    }
  }

  static post(String url, Map<String, String> bodyParams) async {
    await _client
        .post(Uri(scheme: "http", host: "liwanyu.top", path: "/api$url"),
            body: bodyParams,
            headers: {"content-type": "application/x-www-form-urlencoded"})
        .then((http.Response response) {})
        .catchError((error) {});
  }
}
