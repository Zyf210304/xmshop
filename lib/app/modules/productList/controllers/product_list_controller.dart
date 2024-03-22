import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../models/plist_model.dart';
import '../../../services/httpsClient.dart';

class ProductListController extends GetxController {
  //TODO: Implement ProductListController

  ScrollController scrollController = ScrollController();

  GlobalKey<ScaffoldState> scaffoldGlobalKey = GlobalKey<ScaffoldState>();
  HttpClient httpsClient = HttpClient();

  var plist = <PlistItemModel>[].obs;

  
  var page = 1.obs;
  var pageSize = 8;
  bool flag = true;
  var haseData = true.obs;
  String sort = "";

  /*二级导航数据*/
  List subHeaderList = [
    {
      "id": 1,
      "title": "综合",
      "fileds": "all",
      "sort":
          -1, // 排序     升序：price_1     {price:1}        降序：price_-1   {price:-1}
    },
    {"id": 2, "title": "销量", "fileds": 'salecount', "sort": -1},
    {"id": 3, "title": "价格", "fileds": 'price', "sort": -1},
    {"id": 4, "title": "筛选"}
  ];
  //二级导航选中判断
  RxInt selectHeaderId = 1.obs;
  //主要解决的问题是排序箭头无法更新
  RxInt subHeaderListSort = 0.obs;

  @override
  void onInit() {
    super.onInit();

    //获取商品列表
    getPlistData();

    //监听滚动
    initScrollController();
  }

  initScrollController() {
    scrollController.addListener(() {
      // scrollController.position.pixels; //滚动条下拉高度
      // scrollController.position.maxScrollExtent; //页面高度

      if (scrollController.position.pixels >
          scrollController.position.maxScrollExtent - 20) {
        getPlistData();
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

  void subHeaderChanged(id) {
    if (id == 4) {
      scaffoldGlobalKey.currentState!.openEndDrawer();
    } else {
      //获取sort
      sort =
          "${subHeaderList[id - 1]["fileds"]}_${subHeaderList[id - 1]["sort"]}";
      subHeaderList[id - 1]["sort"] = subHeaderList[id - 1]["sort"] * -1;
      subHeaderListSort.value = subHeaderList[id - 1]["sort"];
      // 刷新数据
      page.value = 1;
      plist.value = [];
      flag = true;
      haseData.value = true;
      //scroll返回顶部
      scrollController.jumpTo(0);
      //网络请求
      getPlistData();
    }
    selectHeaderId.value = id;
    update();
  }

  void getPlistData() async {
    if (flag && haseData.value) {
      flag = false;
      var response = await httpsClient.get(
          "api/plist?cid=${Get.arguments["cid"]}&page=$page&pageSize=$pageSize&sort=$sort");

      if (response != null) {
        var data = PlistModel.fromJson(response.data);

        plist.addAll(data.result!);
        page++;
        flag = true;
        haseData.value = data.result!.length >= 8;
        update();
      } else {
        print("1111111");
      }
    } else {
      return;
    }
  }
}
