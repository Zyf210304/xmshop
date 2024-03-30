

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../cart/views/cart_view.dart';
import '../../category/views/category_view.dart';
import '../../give/views/give_view.dart';
import '../../home/views/home_view.dart';
import '../../user/views/user_view.dart';


class TabsController extends GetxController {

  RxInt currentIndex = 0 .obs;
  PageController pageController= Get.arguments != null ? PageController(initialPage:Get.arguments["initialPage"]) : PageController(initialPage:0);
  // HttpClient httpClient = HttpClient();

  final List<Widget> pages =  [
    const HomeView(),
    const CategoryView(),
    const GiveView(),
    CartView(),
    const UserView()




  ];
  @override
  void onInit() {
    super.onInit();


    if( Get.arguments != null ) {
      currentIndex.value =  Get.arguments["initialPage"];
    }

  }

  @override
  void onClose() {
    super.onClose();
  }

  void setCurrentIndex(index) {
    currentIndex.value = index;
    update();
  }
}
