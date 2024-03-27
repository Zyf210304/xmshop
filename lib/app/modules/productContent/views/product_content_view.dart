import 'dart:async';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/services/httpsClient.dart';

import '../controllers/product_content_controller.dart';
import '../../../services/screenAdapter.dart';
import './first_page_view_view.dart';
import './second_page_view_view.dart';
import './third_page_view_view.dart';
import './cart_item_number_view.dart';

class ProductContentView extends GetView<ProductContentController> {
  const ProductContentView({Key? key}) : super(key: key);



  //action 1 筛选属性 2加入购物车 3立即购买
  showBottomAttr(action) {
    Get.bottomSheet(GetBuilder<ProductContentController>(
        init: controller,
        builder: (controller) {
          return Container(
              padding: EdgeInsets.all(ScreenAdapter.width(20)),
              color: Colors.white,
              width: double.infinity,
              height: ScreenAdapter.height(1200),
              child: Stack(
                children: [
                  //筛选属性
                  ListView(
                    children: [
                    ...controller.pcontent.value.attr!
                        .asMap()
                        .entries
                        .map((element) {
                      return Wrap(
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                top: ScreenAdapter.width(20),
                                left: ScreenAdapter.width(20)),
                            width: ScreenAdapter.width(1040),
                            child: Text(
                              "${element.value.cate}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            width: ScreenAdapter.width(1040),
                            child: Wrap(
                                children: element.value.attrList!
                                    .asMap()
                                    .entries
                                    .map((category) {
                              return InkWell(
                                onTap: () {
                                  controller.changeAttr(
                                      element.key, category.key);
                                },
                                child: Container(
                                    margin: EdgeInsets.only(
                                        right: ScreenAdapter.width(20)),
                                    child: Chip(
                                        padding:
                                            EdgeInsets.fromLTRB(4, 2, 4, 2),
                                        shape: StadiumBorder(),
                                        side: BorderSide(
                                          color: Colors.transparent,
                                        ),
                                        backgroundColor: category
                                                .value["checked"]
                                            ? Colors.red
                                            : Color.fromARGB(31, 233, 213, 213),
                                        label: Text(category.value["title"]))),
                              );
                            }).toList()),
                          ),
                        ],
                      );
                    }).toList(),

                    action != 1 ?   Padding(padding: EdgeInsets.all(ScreenAdapter.width(20)), child:  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      const Text("数量", style: TextStyle(fontWeight: FontWeight.bold),),
                      CartItemNumberView()
                    ],)) : const Text(""),
                      
                    ]
                  ),

                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: ScreenAdapter.getbottomBarHeight(),
                      child: Row(
                        children: [
                          Expanded(
                              child: Container(
                            height: ScreenAdapter.height(120),
                            child: ElevatedButton(
                                onPressed: () {
                                  if (action == 1) {
                                    //筛选
                                    controller.setSelectedAttr();
                                    Get.back();
                                  } else if (action == 2) {
                                    //加入购物车

                                    controller.addCart();
                                  } else {
                                    //立即购买

                                    controller.buy();
                                  }

                                  
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        action == 2
                                            ? const Color.fromARGB(
                                                229, 235, 243, 5)
                                            : const Color.fromRGBO(
                                                253, 1, 0, 0.9)),
                                    foregroundColor:
                                        MaterialStateProperty.all(Colors.white),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)))),
                                child: Text(action == 2
                                    ? "加入购物车"
                                    : action == 3
                                        ? "立即购买"
                                        : "确定")),
                          ))
                        ],
                      )),

                  Positioned(
                      top: 0,
                      right: 2,
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () {
                          Get.back();
                        },
                      ))
                ],
              ));
        }));
  }

  Widget _subHeader() {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: Column(
        children: [
          Row(
              children: controller.subTabsList
                  .map((element) => Obx(() => Expanded(
                        child: InkWell(
                            onTap: () {
                              controller
                                  .changeSubTabsSelectIndex(element["id"]);
                            },
                            child: Container(
                              height: ScreenAdapter.height(120),
                              alignment: Alignment.center,
                              child: Text(
                                "${element["title"]}",
                                style: TextStyle(
                                    color: element["id"] ==
                                            controller
                                                .selectedSubTitleIndex.value
                                        ? Colors.red
                                        : Colors.black38),
                              ),
                            )),
                      )))
                  .toList())
        ],
      ),
    );
  }

  PreferredSize _appBar(BuildContext context) {
    return PreferredSize(
      preferredSize: Size(ScreenAdapter.width(1080), ScreenAdapter.height(120)),
      child: Obx(
        () => AppBar(
          title: SizedBox(
            width: ScreenAdapter.width(400),
            height: ScreenAdapter.width(96),
            // color: Colors.yellow,
            child: (controller.showTabs.value == false)
                ? const Text("")
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: controller.tabsList.asMap().entries.map((entrie) {
                      return Padding(
                        padding: const EdgeInsets.all(5),
                        child: InkWell(
                            onTap: () {
                              controller.changeSelectIndex(entrie.key);

                              //跳转到指定的容器
                              if (entrie.key == 0) {
                                Scrollable.ensureVisible(
                                    controller.globalKey1.currentContext
                                        as BuildContext,
                                    duration:
                                        const Duration(milliseconds: 500));
                              }
                              if (entrie.key == 1) {
                                Scrollable.ensureVisible(
                                    controller.globalKey2.currentContext
                                        as BuildContext,
                                    duration:
                                        const Duration(milliseconds: 500));

                                //修正时间
                                Timer myTimer = Timer(
                                    const Duration(milliseconds: 501), () {
                                  controller.scrollController.jumpTo(
                                      controller.scrollController.offset -
                                          ScreenAdapter.height(120) -
                                          ScreenAdapter.getstatusBarHeigh());
                                });
                              }
                              if (entrie.key == 2) {
                                Scrollable.ensureVisible(
                                    controller.globalKey3.currentContext
                                        as BuildContext,
                                    duration:
                                        const Duration(milliseconds: 500));

                                Timer myTimer = Timer(
                                    const Duration(milliseconds: 501), () {
                                  controller.scrollController.jumpTo(
                                      controller.scrollController.offset -
                                          ScreenAdapter.height(120) -
                                          ScreenAdapter.getstatusBarHeigh());
                                });
                              }
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  entrie.value,
                                  style: TextStyle(
                                      fontSize: ScreenAdapter.fontSize(36)),
                                ),
                                SizedBox(
                                  height: ScreenAdapter.width(10),
                                ),
                                Container(
                                  padding: EdgeInsets.only(
                                      top: ScreenAdapter.width(50)),
                                  width: ScreenAdapter.width(80),
                                  height: 2,
                                  color: entrie.key ==
                                          controller.selectTasIndex.value
                                      ? Colors.red
                                      : Colors.transparent,
                                )
                              ],
                            )),
                      );
                    }).toList(),
                  ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white.withOpacity(controller.opacity.value),
          elevation: 0,
          leading: Container(
              // color: Colors.red,
              alignment: Alignment.center,
              child: Container(
                width: ScreenAdapter.width(90),
                height: ScreenAdapter.width(90),
                child: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      backgroundColor: MaterialStateProperty.all(Colors.grey),
                      foregroundColor: MaterialStateProperty.all(Colors.white),
                      shape: MaterialStateProperty.all(const CircleBorder())),
                  child: const Icon(
                    Icons.arrow_back_ios_new_sharp,
                  ),
                ),
              )),
          actions: [
            SizedBox(
              width: ScreenAdapter.width(90),
              height: ScreenAdapter.width(90),
              child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    backgroundColor: MaterialStateProperty.all(Colors.grey),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(const CircleBorder())),
                child: const Icon(
                  Icons.file_upload_outlined,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: ScreenAdapter.width(90),
              height: ScreenAdapter.width(90),
              child: ElevatedButton(
                onPressed: () {
                  showMenu(
                      color: Colors.black87.withOpacity(0.7),
                      context: context,
                      position: RelativeRect.fromLTRB(
                          ScreenAdapter.width(600),
                          ScreenAdapter.width(240),
                          ScreenAdapter.width(20),
                          ScreenAdapter.width(0)),
                      items: [
                        const PopupMenuItem(
                            child: Row(
                          children: [
                            Icon(
                              Icons.home,
                              color: Colors.white,
                            ),
                            Text(
                              "首页",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        )),
                        const PopupMenuItem(
                            child: Row(
                          children: [
                            Icon(
                              Icons.message,
                              color: Colors.white,
                            ),
                            Text(
                              "消息",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        )),
                        const PopupMenuItem(
                            child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.white,
                            ),
                            Text(
                              "收藏",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ))
                      ]);
                },
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.zero),
                    backgroundColor: MaterialStateProperty.all(Colors.grey),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(const CircleBorder())),
                child: const Icon(
                  Icons.more_horiz_rounded,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      controller: controller.scrollController,
      child: Column(
        children: [
          FirstPageViewView(showBottomAttr),
          SecondPageViewView(_subHeader),
          ThirdPageViewView(),
        ],
      ),
    );
  }

  Widget _bottom(BuildContext context) {
    return Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: Column(
          children: [
            Container(
              height: ScreenAdapter.width(160),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      top: BorderSide(
                          width: ScreenAdapter.width(2),
                          color: Colors.black45))),
              child: Row(
                children: [
                  SizedBox(
                    width: ScreenAdapter.width(200),
                    height: ScreenAdapter.width(160),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.shopping_cart),
                        Text("购物车"),
                      ],
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Container(
                          // margin: const EdgeInsets.only( right :20),
                          child: ElevatedButton(
                        onPressed: () {
                          showBottomAttr(2);
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.yellow),
                            foregroundColor:
                                MaterialStateProperty.all(Colors.white),
                            shape: MaterialStateProperty.all(
                                // BeveledRectangleBorder()
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(20),
                                        right: Radius.circular(0))))),
                        child: const Text("加入购物车"),
                      ))),
                  Expanded(
                      flex: 1,
                      child: Container(
                          margin: const EdgeInsets.only(right: 20),
                          child: ElevatedButton(
                            onPressed: () {
                              showBottomAttr(3);
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.red[400]),
                                foregroundColor:
                                    MaterialStateProperty.all(Colors.white),
                                shape: MaterialStateProperty.all(
                                    // BeveledRectangleBorder()
                                    const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(0),
                                            right: Radius.circular(100))))),
                            child: const Text("立即购买"),
                          ))),
                ],
              ),
            ),
            Container(
              height: context.bottomBarHeight(),
              color: Colors.white,
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //让body内容扩展到 appbar 下面
      extendBodyBehindAppBar: true,

      appBar: _appBar(context),
      body: Stack(
        children: [
          _body(),
          _bottom(context),
          Obx(() => controller.showSubHeaderTabs.value == true
              ? Positioned(
                  top: ScreenAdapter.getstatusBarHeigh() +
                      ScreenAdapter.height(120),
                  left: 0,
                  right: 0,
                  child: _subHeader(),
                )
              : Text(""))
        ],
      ),
    );
  }
}
