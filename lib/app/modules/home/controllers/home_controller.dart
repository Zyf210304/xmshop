import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:xmshop/app/models/category_model_model.dart';
import 'package:xmshop/app/models/shop.dart';
import '../../../models/focus_model.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  var flag = false.obs;

  final ScrollController scrollController = ScrollController();

  var swiperlist = <FocusItemModel>[].obs; //需要定义成响应式
  var cartogoryList = <CategoryItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();

    addScrollControllerListener();

    //请求轮播图接口
    getFocusData();

    //请求分类接口
    getCategoryData();
  }

  void fromatJson() {
    var strData =
        '{"_id":"59f6ef443ce1fb0fb02c7a43","title":"笔记本电脑","status":1,"pic":"public/upload/UObZahqPYzFvx_C9CQjU8KiX.png","url":"12"}';
    var shopModel = ShopModel.fromJson(json.decode(strData));
    print(shopModel.pic);
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

  getFocusData() async {
    var response = await Dio().get("https://miapp.itying.com/api/focus");
    // print(response.data);
    var focus = FocusModel.fromJson(response.data);
    swiperlist.value = focus.result!;

    update();
  }

  getCategoryData() async {
    var response = await Dio().get("https://miapp.itying.com/api/bestCate");
    var catogry = CategoryModel.fromJson(response.data);
    cartogoryList.value = catogry.result!;
    update();
  }
}
