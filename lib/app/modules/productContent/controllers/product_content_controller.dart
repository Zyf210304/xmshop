import 'dart:math';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../services/screenAdapter.dart';
import '../../../models/pcount_model.dart';
import '../../../services/httpsClient.dart';

class ProductContentController extends GetxController {
  //TODO: Implement ProductContentController

  var flag = false.obs;
  final ScrollController scrollController = ScrollController();
  GlobalKey globalKey1 = GlobalKey();
  GlobalKey globalKey2 = GlobalKey();
  GlobalKey globalKey3 = GlobalKey();
  HttpClient httpsClient = HttpClient();

  //数据
  var pcontent = PcountItemModel().obs;

  //导航栏背景透明度
  var opacity = 0.0.obs;
  //是否显示tabs
  var showTabs = false.obs;

  //导航栏菜单
  // var tabsList = <Map>[{"id":1, "title":"商品"},{"id":2, "title":"详情"},{"id":3, "title":"推荐"}];
  var tabsList = ["商品", "详情", "推荐"];
  var selectTasIndex = 0.obs;

  //商品种类选择
  var pcontentAttr = <PcontentAttrModel>[].obs;
  //保存筛选属性值
  var selectedAttr = "".obs;

  //container的位置
  var gk2postion = 0.0;
  var gk3postion = 0.0;

  //判断首页是否显示浮动导航
  var showSubHeaderTabs = false.obs;
  var needRefreshSubTabsHeight = true;
  //浮动导航菜单
  List<Map> subTabsList = [
    {"id": 1, "title": "商品介绍"},
    {"id": 2, "title": "规格参数"},
  ];
  //浮动显示导航选中位置
  var selectedSubTitleIndex = 1.obs;

  //购买的数量
  var buyNumber = 1.obs;

  @override
  void onInit() {
    super.onInit();

    addScrollControllerListener();

    //获取商品详情数据
    getPcontenttData();


    // setSelectedAttr();
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
      //获取元素位置位置
      if (gk2postion == 0 || needRefreshSubTabsHeight) {
        getContainerPosition(scrollController.offset);
        needRefreshSubTabsHeight = false;
      }

      //显示隐藏 详情切换
      if (scrollController.offset > gk2postion &&
          scrollController.offset < gk3postion) {
        
        if (showSubHeaderTabs.value == false) {
          showSubHeaderTabs.value = true;
          selectTasIndex.value = 1;
          print("----------1");
          update();
        }
      } else if (scrollController.offset < gk2postion) {
        if (showSubHeaderTabs.value == true) {
          showSubHeaderTabs.value = false;
          selectTasIndex.value = 0;
          print("----------0");
          update();
        }
      } else if(scrollController.offset > gk3postion) {
        if (showSubHeaderTabs.value == true) {
          showSubHeaderTabs.value = false;
          selectTasIndex.value = 2;
          print("----------2");
          update();
        }
      }

      //显示隐藏顶部tab
      if (scrollController.position.pixels <= 100) {
        opacity.value = (scrollController.position.pixels > 0
                ? scrollController.offset
                : 0) /
            100;
        if (showTabs.value == true) {
          showTabs.value = false;
        }
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

  //获取元素的位置  globalKey3.currentContext!.findRenderObject()  可以获取渲染属性 要在渲染完成获取  获取渲染的高度是距离顶部的高度
  getContainerPosition(height) {
    //获取渲染的高度是距离顶部的高度  还要控制 顶部高度
    var needChangeHeight = height -
        (ScreenAdapter.getstatusBarHeigh() + ScreenAdapter.height(120));

    RenderBox box2 = globalKey2.currentContext!.findRenderObject() as RenderBox;
    gk2postion = box2.localToGlobal(Offset.zero).dy + needChangeHeight;

    RenderBox box3 = globalKey3.currentContext!.findRenderObject() as RenderBox;
    gk3postion = box3.localToGlobal(Offset.zero).dy + needChangeHeight;

    print(gk2postion);
    print(gk3postion);
  }

  changeSelectIndex(index) {
    selectTasIndex.value = index;
    update();
  }

  getPcontenttData() async {
    var response =
        await httpsClient.get("api/pcontent?id=${Get.arguments["id"]}");
    if (response != null) {
      var tempData = PcountModel.fromJson(response.data);
      pcontent.value = tempData.result!;
      pcontentAttr.value = pcontent.value.attr!;
      initAttr(pcontentAttr);
      // print(pcontentAttr);
      setSelectedAttr();
      update();
    }
  }

  //初始化 数据
  initAttr(List<PcontentAttrModel> attr) {
    for (var i = 0; i < attr.length; i++) {
      for (var j = 0; j < attr[i].list!.length; j++) {
        attr[i].attrList!.add({
          "title": attr[i].list![j],
          "checked": j == 0,
        });
      }
    }
  }

  changeAttr(keyIndex, valueIndex) {
    PcontentAttrModel model = pcontentAttr[keyIndex];
    for (var i = 0; i < model.attrList!.length; i++) {
      Map map = model.attrList![i];
      map["checked"] = i == valueIndex;
    }
    needRefreshSubTabsHeight = true;
    print(model.attrList);
    update();
  }

  //保存筛选属性值
  setSelectedAttr() {
    List tempList = [];
    for (var i = 0; i < pcontentAttr.length; i++) {
      for (var j = 0; j < pcontentAttr[i].attrList!.length; j++) {

        if(pcontentAttr[i].attrList![j]["checked"]) {
            tempList.add(pcontentAttr[i].attrList![j]["title"]);
        }
      }
    }

    selectedAttr.value =tempList.join(",");
    update();
    
  }

  // 切换顶部浮动导航位置
  changeSubTabsSelectIndex(index) {
    selectedSubTitleIndex.value = index;
    needRefreshSubTabsHeight = true;
    scrollController.jumpTo(gk2postion);
    update();
  }

  //改变数量
  changeBuyNumber(isAdd) {
    if (isAdd == true) {
      buyNumber.value ++;
    } else {
      if (buyNumber > 1) {
        buyNumber.value --;
      }
    }
  }
  
}
