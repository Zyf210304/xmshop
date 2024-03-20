import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tabs_controller.dart';

class TabsView extends GetView<TabsController> {
  const TabsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: PageView(
            controller: controller.pageController,
            children: controller.pages,
            onPageChanged: (index) {
              controller.setCurrentIndex(index);
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
              fixedColor: Colors.red,
              currentIndex: controller.currentIndex.value,
              onTap: (index) {
                // controller.setCurrentIndex(index);
                controller.pageController.jumpToPage(index);
              },
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                    backgroundColor: Colors.blue,
                    icon: Icon(Icons.home),
                    label: "首页"),
                BottomNavigationBarItem(
                    backgroundColor: Colors.green,
                    icon: Icon(Icons.category),
                    label: "分类"),
                BottomNavigationBarItem(
                    backgroundColor: Colors.white,
                    icon: Icon(Icons.room_service),
                    label: "服务"),
                BottomNavigationBarItem(
                    backgroundColor: Colors.amber,
                    icon: Icon(Icons.shopping_cart),
                    label: "购物车"),
                BottomNavigationBarItem(
                    backgroundColor: Colors.purple,
                    icon: Icon(Icons.people),
                    label: "我的"),
              ]),
        ));
  }
}
