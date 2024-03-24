import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class HttpClient {
  static String domain = "https://miapp.itying.com/";

  static Dio dio = Dio();

  HttpClient() {
    dio.options.baseUrl = domain;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;
  }

  Future get(apiUrl) async {
    try {
      var response = await dio.get(apiUrl);
      print(response.realUri);
      return response;
    } catch (error) {
      print("网络请求异常");
      return null;
    }
  }

  static replaceUri(picUrl) {
    String tempUrl = domain+picUrl;
    return tempUrl.replaceAll("\\", "/");
  }
}

extension screenAbout on BuildContext {

  double bottomBarHeight() {
    
    MediaQueryData mq = MediaQuery.of(this);
    return mq.padding.bottom;
  }

  double statusBarHeight() {
    
    MediaQueryData mq = MediaQuery.of(this);
    return mq.padding.top;
  }

}