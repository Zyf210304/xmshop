import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../services/screenAdapter.dart';
import './cart_item_number_view.dart';

class CartItemView extends GetView {
  final Map cartItem;
  const CartItemView(this.cartItem,{Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(ScreenAdapter.width(40),
          ScreenAdapter.width(20), ScreenAdapter.width(40), 0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: const Border(bottom: BorderSide(color: Colors.black12))),
      child: Row(
        children: [
          SizedBox(
            width: ScreenAdapter.width(100),
            child: Checkbox(
                activeColor: Colors.red, value: true, onChanged: (value) {}),
          ),
          Container(
            padding: EdgeInsets.all(ScreenAdapter.width(24)),
            width: ScreenAdapter.width(280),
            child: Image.network(
              cartItem["pic"],
              fit: BoxFit.fitHeight,
            ),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${cartItem["title"]}",
                style: TextStyle(
                    fontSize: ScreenAdapter.fontSize(36),
                    fontWeight: FontWeight.bold),
              ),
               Row(
                children: [
                  Chip(
                      padding: const EdgeInsets.fromLTRB(4, 2, 4, 2),
                      shape: const StadiumBorder(),
                      side: const BorderSide(
                        color: Colors.transparent,
                      ),
                      backgroundColor:const Color.fromARGB(31, 233, 213, 213),
                      label: Text("${cartItem["selectedAttr"]}")),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${cartItem["price"]}",
                    style: TextStyle(
                        fontSize: ScreenAdapter.fontSize(58),
                        color: Colors.red),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: CartItemNumberView(cartItem),
                  )
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
