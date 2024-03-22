import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'package:xmshop/app/models/category_model_model.dart';
import 'package:xmshop/app/models/plist_model.dart';
import 'package:xmshop/app/models/shop.dart';
import '../../../models/focus_model.dart';
import '../../../services/httpsClient.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  var flag = false.obs;

  final ScrollController scrollController = ScrollController();

  var swiperlist = <FocusItemModel>[].obs; //需要定义成响应式
  var cartogoryList = <CategoryItemModel>[].obs;
  var bestSellingSwipeList = <FocusItemModel>[].obs;
  var sellingPist = <PlistItemModel>[].obs;
  var bestPlist = <PlistItemModel>[].obs;
  HttpClient httpsClient = HttpClient();

  @override
  void onInit() {
    super.onInit();

    addScrollControllerListener();

    //请求轮播图接口
    getFocusData();

    //请求分类接口
    getCategoryData();

    //甄选
    getBsetSellingSwiperData();

    //获取甄选里面的商品
    getHotPlistData();

    //获取热门商品
    getBestPlistData();
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
    var response = await httpsClient.get("api/focus");
    if (response != null) {}
    var focus = FocusModel.fromJson(response.data);
    swiperlist.value = focus.result!;
    update();
  }

  getBsetSellingSwiperData() async {
    var response = await httpsClient.get("api/focus?position=2");
    if (response != null) {
      var sellingList = FocusModel.fromJson(response.data);
      bestSellingSwipeList.value = sellingList.result!;

      update();
    }
  }

  getCategoryData() async {
    var response = await httpsClient.get("api/bestCate");
    if (response != null) {
      var catogry = CategoryModel.fromJson(response.data);
      cartogoryList.value = catogry.result!;
      update();
    }
  }

  getHotPlistData() async {
    var response = await httpsClient.get("api/plist?is_hot=1");
    if (response != null) {
      var cellingPlist = PlistModel.fromJson(response.data);
      sellingPist.value = cellingPlist.result!;
      update();
    }
  }

  getBestPlistData() async {
    var response = await httpsClient.get("api/plist?is_best=1");
    if (response != null) {
      var plist = PlistModel.fromJson(response.data);
      bestPlist.value = plist.result!;
      update();
    }
  }
}
