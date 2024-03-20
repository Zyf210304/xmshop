import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/services/screenAdapter.dart';

import '../controllers/home_controller.dart';
import '../../../services/keepAliveWrapper.dart';
import '../../../services/ityingFonts.dart';

import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
 
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
            title: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: controller.flag.value
                  ? ScreenAdapter.width(800)
                  : ScreenAdapter.width(620),
              height: ScreenAdapter.height(96),
              decoration: BoxDecoration(
                color: const Color.fromARGB(230, 202, 190, 190),
                borderRadius: BorderRadius.circular(30),
              ),
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
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

  Widget _homeBody() {
    return Positioned(
      top: -60,
      left: 0,
      right: 0,
      bottom: 0,
      //  "https://www.itying.com/images/focus/focus02.png",
      child:ListView( 
        controller:  controller.scrollController,
        children: [ 
          Container(
            width: ScreenAdapter.width(1080),
            height:ScreenAdapter.height(682),
            child: Obx(() => Swiper(
              itemBuilder:(context, index) {
                String picUrl = "https://miapp.itying.com/${controller.swiperlist[index]["pic"]}";

                return Image.network(picUrl.replaceAll("\\", "/"), fit: BoxFit.cover,);
              },
              itemCount: controller.swiperlist.length,

              pagination: const SwiperPagination(   //指示条
                  builder: SwiperPagination.rect
              ),     
              autoplay: true,
              loop: true,
              duration: 1000,
              // control: const SwiperControl(), //箭头
            )),
          )
        ],
      )
    );
  }

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
