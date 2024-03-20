import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  var flag = false.obs;

  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
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

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
