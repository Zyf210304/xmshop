import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../services/screenAdapter.dart';
import '../controllers/product_content_controller.dart';

class CartItemNumberView extends GetView {

  @override
  ProductContentController controller = Get.find();

  CartItemNumberView({Key? key}) : super(key: key);

  

  

  Widget _left() {
    return InkWell(
      onTap: () {
        controller.changeBuyNumber(false);
      },
      child: Container(
      alignment: Alignment.center,
      width: ScreenAdapter.width(80),
      height: ScreenAdapter.width(80),
      child: const Text("-"),
    ),
    );
  }

  Widget _center() {
    return Obx(() => Container(
      decoration: const BoxDecoration(
          border: Border(
              left: BorderSide(color: Colors.black26),
              right: BorderSide(color: Colors.black26))),
      alignment: Alignment.center,
      width: ScreenAdapter.width(80),
      height: ScreenAdapter.width(80),
      child:  Text("${controller.buyNumber}"),
    ));
  }

  Widget _right() {
    return InkWell(
      onTap: () {
        controller.changeBuyNumber(true);
      },
      child: Container(
      alignment: Alignment.center,
      width: ScreenAdapter.width(80),
      height: ScreenAdapter.width(80),
      child: const Text("+"),
    ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenAdapter.width(244),
      height: ScreenAdapter.width(80),
      decoration: BoxDecoration(
        border:
            Border.all(width: ScreenAdapter.width(2), color: Colors.black26),
        color: Colors.black12,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          _left(),
          _center(),
          _right(),
        ],
      ),
    );
  }
}
