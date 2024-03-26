import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../services/screenAdapter.dart';
import './cart_item_number_view.dart';

class CartItemView extends GetView {
  const CartItemView({Key? key}) : super(key: key);
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
              "https://www.itying.com/images/shouji.png",
              fit: BoxFit.fitHeight,
            ),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "小米11",
                style: TextStyle(
                    fontSize: ScreenAdapter.fontSize(36),
                    fontWeight: FontWeight.bold),
              ),
              const Row(
                children: [
                  Chip(
                      padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                      shape: StadiumBorder(),
                      side: BorderSide(
                        color: Colors.transparent,
                      ),
                      backgroundColor: Color.fromARGB(31, 233, 213, 213),
                      label: Text("选择属性")),
                  Chip(
                      padding: EdgeInsets.fromLTRB(4, 2, 4, 2),
                      shape: StadiumBorder(),
                      side: BorderSide(
                        color: Colors.transparent,
                      ),
                      backgroundColor: Color.fromARGB(31, 233, 213, 213),
                      label: Text("选择属性")),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "89.9",
                    style: TextStyle(
                        fontSize: ScreenAdapter.fontSize(58),
                        color: Colors.red),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: CartItemNumberView(),
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
