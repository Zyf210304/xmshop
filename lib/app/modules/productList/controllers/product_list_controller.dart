import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../models/plist_model.dart';
import '../../../services/httpsClient.dart';

class ProductListController extends GetxController {
  //TODO: Implement ProductListController

  ScrollController scrollController = ScrollController();

  var plist = <PlistItemModel>[].obs;
  var page = 1.obs;
  var pageSize = 8;
  bool falg = true;
  var haseData = true.obs;
  HttpClient httpsClient = HttpClient();

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

  void getPlistData() async {
    if (falg && haseData.value) {
      falg = false;
      var response = await httpsClient.get(
          "api/plist?cid=${Get.arguments["cid"]}&page=$page&pageSize=$pageSize");

      if (response != null) {
        var data = PlistModel.fromJson(response.data);

        plist.addAll(data.result!);
        page++;
        falg = true;
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
