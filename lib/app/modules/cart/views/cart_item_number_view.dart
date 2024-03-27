import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../services/screenAdapter.dart';

class CartItemNumberView extends GetView {
  final Map cartItem;

  const CartItemNumberView(this.cartItem,{Key? key}) : super(key: key);

  Widget _left() {
    return Container(
      alignment: Alignment.center,
      width: ScreenAdapter.width(80),
      child: const Text("-"),
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
    return Container(
      alignment: Alignment.center,
      width: ScreenAdapter.width(80),
      child: const Text("+"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenAdapter.width(244),
      height: ScreenAdapter.width(60),
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
