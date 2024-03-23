import 'dart:math';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/models/plist_model.dart';
import 'package:xmshop/app/services/screenAdapter.dart';

import '../controllers/home_controller.dart';
import '../../../services/keepAliveWrapper.dart';
import '../../../services/ityingFonts.dart';

import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

//顶部导航
  Widget _appBar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Obx(() => AppBar(
            leading: controller.flag.value
                ? const Text("")
                : Icon(ItyingFonts.xiaomi,
                    color: controller.flag.value == true
                        ? Colors.black45
                        : Colors.white),
            leadingWidth: controller.flag.value ? 0 : ScreenAdapter.width(140),
            title: InkWell(
              onTap: () {
                Get.toNamed("/search");
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: controller.flag.value
                    ? ScreenAdapter.width(800)
                    : ScreenAdapter.width(620),
                height: ScreenAdapter.height(96),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(246, 246, 246, 1),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 4, 0),
                        child: Icon(
                          Icons.search,
                          color: Colors.black45,
                        ),
                      ),
                      Text(
                        "手机",
                        style: TextStyle(
                            color: Colors.black45,
                            fontSize: ScreenAdapter.fontSize(32)),
                      ),
                    ]),
              ),
            ),
            centerTitle: true,
            backgroundColor: controller.flag.value == true
                ? Colors.white
                : Colors.transparent,
            elevation: 0,
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.qr_code,
                    color: controller.flag.value == true
                        ? Colors.black45
                        : Colors.white,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.message,
                    color: controller.flag.value == true
                        ? Colors.black45
                        : Colors.white,
                  ))
            ],
          )),
    );
  }

//轮播图
  Widget _focus() {
    return SizedBox(
      width: ScreenAdapter.width(1080),
      height: ScreenAdapter.height(682),
      child: Obx(() => Swiper(
            itemBuilder: (context, index) {
              String picUrl =
                  "https://miapp.itying.com/${controller.swiperlist[index].pic}";

              return Image.network(
                picUrl.replaceAll("\\", "/"),
                fit: BoxFit.cover,
              );
            },
            itemCount: controller.swiperlist.length,

            pagination: const SwiperPagination(
                //指示条
                builder: SwiperPagination.rect),
            autoplay: true,
            loop: true,
            duration: 1000,
            // control: const SwiperControl(), //箭头
          )),
    );
  }

//banner
  Widget _banner() {
    return SizedBox(
      width: ScreenAdapter.width(1080),
      height: ScreenAdapter.height(92),
      child: Image.asset("assets/images/xiaomiBanner.png"),
    );
  }

//分类
  Widget _category() {
    return SizedBox(
        // padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        width: ScreenAdapter.width(1080),
        height: ScreenAdapter.height(520),
        // color: Colors.yellow,
        child: Obx(
          () => Swiper(
            itemCount: controller.cartogoryList.length ~/ 10,
            itemBuilder: (context, index) {
              return GridView.builder(
                  itemCount: 10,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    childAspectRatio: 0.8,
                    crossAxisSpacing: ScreenAdapter.width(20),
                    mainAxisSpacing: ScreenAdapter.height(20),
                  ),
                  itemBuilder: (context, row) {
                    String picUrl =
                        "https://miapp.itying.com/${controller.cartogoryList[index * 10 + row].pic}";
                    return Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          height: ScreenAdapter.width(140),
                          width: ScreenAdapter.width(140),
                          child: Image.network(
                            picUrl.replaceAll("\\", "/"),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Container(
                            padding:
                                EdgeInsets.only(top: ScreenAdapter.width(5)),
                            child: Text(
                                "${controller.cartogoryList[index * 10 + row].title}")),
                      ],
                    );
                  });
            },

            pagination: SwiperPagination(
                margin: const EdgeInsets.all(0.0),
                builder: SwiperCustomPagination(
                    builder: (BuildContext context, SwiperPluginConfig config) {
                  return ConstrainedBox(
                    constraints:
                        BoxConstraints.expand(height: ScreenAdapter.height(20)),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: const RectSwiperPaginationBuilder(
                              color: Colors.black12,
                              activeColor: Colors.black,
                            ).build(context, config),
                          ),
                        )
                      ],
                    ),
                  );
                })),
            // control: const SwiperControl(), //箭头
          ),
        ));
  }

//banner
  Widget _banner2() {
    return Padding(
      padding: EdgeInsets.fromLTRB(ScreenAdapter.width(20),
          ScreenAdapter.height(30), ScreenAdapter.width(20), 0),
      // padding:  const EdgeInsets.fromLTRB(0, 0, 0, 0),
      // color: Colors.red,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            // color: Colors.red,
            image: const DecorationImage(
                image: AssetImage("assets/images/xiaomiBanner2.png"),
                fit: BoxFit.cover)),
        height: ScreenAdapter.height(420),
      ),
    );
  }

//热销商品
  Widget _bestSelling() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(ScreenAdapter.width(20),
              ScreenAdapter.height(30), ScreenAdapter.width(20), 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "热销甄选",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenAdapter.fontSize(46)),
              ),
              Text(
                "更多手机 >",
                style: TextStyle(fontSize: ScreenAdapter.fontSize(38)),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(ScreenAdapter.width(20),
              ScreenAdapter.height(30), ScreenAdapter.width(20), 0),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    height: ScreenAdapter.height(738),
                    // color: Colors.red,
                    child: Obx(() => Swiper(
                          itemBuilder: (context, index) {
                            String picUrl =
                                "https://miapp.itying.com/${controller.bestSellingSwipeList[index].pic}";

                            return Image.network(
                              picUrl.replaceAll("\\", "/"),
                              fit: BoxFit.cover,
                            );
                          },
                          itemCount: controller.bestSellingSwipeList.length,

                          pagination: const SwiperPagination(
                              //指示条
                              builder: SwiperPagination.rect),
                          autoplay: true,
                          loop: true,
                          duration: 1000,
                          // control: const SwiperControl(), //箭头
                        )),
                  )),
              SizedBox(
                width: ScreenAdapter.width(20),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                      height: ScreenAdapter.height(738),
                      child: Obx(
                        () => Column(
                          //map循环遍历 获取 key
                          children: controller.sellingPist
                              .asMap()
                              .entries
                              .map((entrie) {
                            var element = entrie.value;
                            String picUrl =
                                "https://miapp.itying.com/${element.pic}";

                            return Expanded(
                                flex: 1,
                                child: Container(
                                  color: const Color.fromRGBO(246, 246, 246, 1),
                                  margin: EdgeInsets.only(
                                      bottom: ScreenAdapter.height(
                                          entrie.key == 2 ? 0 : 20)),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 3,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                element.title!,
                                                style: TextStyle(
                                                    fontSize:
                                                        ScreenAdapter.fontSize(
                                                            38),
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.left,
                                              ),
                                              Text(
                                                element.subTitle!,
                                                style: TextStyle(
                                                    fontSize:
                                                        ScreenAdapter.fontSize(
                                                            28)),
                                              ),
                                              Text(
                                                "￥${element.price}元",
                                                style: TextStyle(
                                                    fontSize:
                                                        ScreenAdapter.fontSize(
                                                            34)),
                                              ),
                                            ],
                                          )),
                                      Expanded(
                                          flex: 2,
                                          child: Image.network(
                                            picUrl.replaceAll("\\", "/"),
                                            fit: BoxFit.fitHeight,
                                          )),
                                    ],
                                  ),
                                ));
                          }).toList(),
                        ),
                      ))),
            ],
          ),
        )
      ],
    );
  }

  Widget _bestGoods() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(ScreenAdapter.width(20),
              ScreenAdapter.height(30), ScreenAdapter.width(20), 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "省心优惠",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: ScreenAdapter.fontSize(46)),
              ),
              Text(
                "全部优惠 >",
                style: TextStyle(fontSize: ScreenAdapter.fontSize(38)),
              )
            ],
          ),
        ),
        Container(
            color: const Color.fromRGBO(246, 246, 246, 1),
            padding: EdgeInsets.all(ScreenAdapter.width(20)),
            child: Obx(
              () => MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: ScreenAdapter.width(20),
                crossAxisSpacing: ScreenAdapter.width(20),
                itemCount: controller.bestPlist.length,
                shrinkWrap: true, //收缩 让元素宽度自适应
                physics: const NeverScrollableScrollPhysics(), //禁止左右滑动
                itemBuilder: (context, index) {
                  PlistItemModel model = controller.bestPlist[index];
                  String picUrl = "https://miapp.itying.com/${model.pic}";

                  return Container(
                    // height: ScreenAdapter.height(100 + 150 *Random().nextDouble()),
                    // color: Colors.red,
                    padding: EdgeInsets.all(ScreenAdapter.width(20)),
                    decoration: BoxDecoration(
                        // border: Border.all(color: Colors.yellow, width: 1,),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Column(
                      children: [
                        Container(
                          child: Image.network(
                            picUrl.replaceAll("\\", "/"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(ScreenAdapter.width(10)),
                          width: double.infinity,
                          child: Text(
                            model.title!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: ScreenAdapter.fontSize(36)),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(ScreenAdapter.width(10)),
                          width: double.infinity,
                          child: Text(
                            model.subTitle!,
                            style:
                                TextStyle(fontSize: ScreenAdapter.fontSize(32)),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(ScreenAdapter.width(10)),
                          width: double.infinity,
                          child: Text(
                            "￥${model.price}",
                            style: TextStyle(
                                fontSize: ScreenAdapter.fontSize(34),
                                color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ))
      ],
    );
  }

  Widget _homeBody() {
    return Positioned(
        top: -60,
        left: 0,
        right: 0,
        bottom: 0,
        //  "https://www.itying.com/images/focus/focus02.png",
        child: ListView(
          controller: controller.scrollController,
          children: [
            _focus(),
            _banner(),
            _category(),
            _banner2(),
            _bestSelling(),
            _bestGoods(),
          ],
        ));
  }
  // https://miapp.itying.com/api/bestCate

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
        child: Scaffold(
      body: Stack(
        children: [
          _homeBody(),
          _appBar(),
        ],
      ),
    ));
  }
}
