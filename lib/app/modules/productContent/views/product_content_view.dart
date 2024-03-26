import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/services/httpsClient.dart';

import '../controllers/product_content_controller.dart';
import '../../../services/screenAdapter.dart';
import './first_page_view_view.dart';
import './second_page_view_view.dart';
import './third_page_view_view.dart';

class ProductContentView extends GetView<ProductContentController> {
  const ProductContentView({Key? key}) : super(key: key);

  showBottomAttr() {
    Get.bottomSheet(GetBuilder<ProductContentController>(
        init: controller,
        builder: (controller) {
          return Container(
            padding: EdgeInsets.all(ScreenAdapter.width(20)),
            color: Colors.white,
            width: double.infinity,
            height: ScreenAdapter.height(1200),
            child: ListView(
              children: controller.pcontent.value.attr!
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
                            controller.changeAttr(element.key, category.key);
                          },
                          child: Container(
                              margin: EdgeInsets.only(
                                  right: ScreenAdapter.width(20)),
                              child: Chip(
                                  padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                                  shape: StadiumBorder(),
                                  side: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                  backgroundColor: category.value["checked"]
                                      ? Colors.red
                                      : Color.fromARGB(31, 233, 213, 213),
                                  label: Text(category.value["title"]))),
                        );
                      }).toList()),
                    ),
                  ],
                );
              }).toList(),
            ),
          );
        }));
  }

  Widget _subHeader() {
    return Container(
      alignment: Alignment.center,
      color: Colors.white,
       child: Column(
        children: [
          Row(
            children: [ 
              Expanded(child: Container(height: ScreenAdapter.height(120), alignment: Alignment.center, child: const Text("商品介绍", style: TextStyle(color: Colors.red),),)),
              Expanded(child: Container(height: ScreenAdapter.height(120), alignment: Alignment.center, child: const Text("规格参数",),))
            ],
          )
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
                                        const Duration(milliseconds: 1000));
                              }
                              if (entrie.key == 1) {
                                Scrollable.ensureVisible(
                                    controller.globalKey2.currentContext
                                        as BuildContext,
                                    duration:
                                        const Duration(milliseconds: 1000));
                              }
                              if (entrie.key == 2) {
                                Scrollable.ensureVisible(
                                    controller.globalKey3.currentContext
                                        as BuildContext,
                                    duration:
                                        const Duration(milliseconds: 1000));
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
                          showBottomAttr();
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
                              showBottomAttr();
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
          Obx(() => controller.showSubHeaderTabs.value == true ? Positioned(
            top: ScreenAdapter.getstatusBarHeigh() + ScreenAdapter.height(120),
            left: 0,
            right: 0,
            child:  _subHeader(),) : Text(""))
        ],
      ),
    );
  }
}
