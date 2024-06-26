import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../services/screenAdapter.dart';
import '../controllers/cart_controller.dart';

class CartItemNumberView extends GetView {

  final Map cartItem;
  @override
  CartController controller = Get.find();

  CartItemNumberView(this.cartItem,{Key? key}) : super(key: key);

  Widget _left() {
    return InkWell(
      onTap: (){
            controller.changNumber(false, cartItem);
      },
      child: Container(
      alignment: Alignment.center,
      width: ScreenAdapter.width(80),
      child: const Text("-"),
    ),
    );
  }

  Widget _center() {
    return Container(
      decoration: const BoxDecoration(
          border: Border(
              left: BorderSide(color: Colors.black26),
              right: BorderSide(color: Colors.black26))),
      alignment: Alignment.center,
      width: ScreenAdapter.width(80),
      child: Text("${cartItem["count"]}"),
    );
  }

  Widget _right() {
    return InkWell(
      onTap: (){
        controller.changNumber(true, cartItem);
      },
      child: Container(
      alignment: Alignment.center,
      width: ScreenAdapter.width(80),
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
