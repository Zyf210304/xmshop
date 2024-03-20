import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';



class HomeController extends GetxController {
  //TODO: Implement HomeController

  var flag = false.obs;

  final ScrollController scrollController = ScrollController();

  var swiperlist = [].obs; //需要定义成响应式

  @override
  void onInit() {
    super.onInit();
    
    addScrollControllerListener();

    //请求轮播图接口
    getFocusData();

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void addScrollControllerListener() {
    scrollController.addListener(() {

      if (scrollController.position.pixels > 10) {
        if (flag.value == false) {
          flag.value = true;
          update();
        }
      } 
      if (scrollController.position.pixels <= 10) {
        if (flag.value == true) {
          flag.value = false;
        }
      }
    });
  }

  getFocusData() async{
    var response = await Dio().get("https://miapp.itying.com/api/focus");
    // print(response.data);
    swiperlist.value = response.data["result"];
    update();
  }


}
