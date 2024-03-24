import 'dart:math';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ProductContentController extends GetxController {
  //TODO: Implement ProductContentController

  var flag = false.obs;
  final ScrollController scrollController = ScrollController();
  GlobalKey globalKey1 = GlobalKey();
  GlobalKey globalKey2 = GlobalKey();
  GlobalKey globalKey3 = GlobalKey();

  //导航栏背景透明度
  var opacity = 0.0.obs;
  //是否显示tabs
  var showTabs = false.obs;

  //导航栏菜单
  // var tabsList = <Map>[{"id":1, "title":"商品"},{"id":2, "title":"详情"},{"id":3, "title":"推荐"}];
  var tabsList = ["商品","详情","推荐"];
  var selectTasIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    addScrollControllerListener();
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
      
      // if (scrollController.keepScrollOffset) {
      //   print("滚动变化-----${scrollController.offset}");
      // }
      // if (!scrollController.keepScrollOffset) {
      //   print("滚动结束-----${scrollController.offset}");
      // }

      if (scrollController.position.pixels <= 100) {
        opacity.value =  (scrollController.position.pixels > 0 ? scrollController.offset : 0) / 100;
        if (showTabs.value == true) {
          // print("--------- 显示tab");
          showTabs.value = false;
        }
        // print("------${opacity.value}-------- ${scrollController.offset}");
        update();
      } else {
        if (opacity.value < 1) {
          opacity.value = 1;
          update();
        }
        if (showTabs.value == false) {
          showTabs.value = true;
          update();
        }
      }
    });
  }

  changeSelectIndex(index) {
    selectTasIndex.value = index;
    update();
  }

  
}