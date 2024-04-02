import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../services/screenAdapter.dart';

import '../controllers/checkout_controller.dart';
import '../../../models/pcount_model.dart';



class CheckoutView extends GetView<CheckoutController> {
  Widget checkoutItem(value) {
    return Container(
      margin: EdgeInsets.only(bottom: ScreenAdapter.width(40)),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 20),
            width: ScreenAdapter.width(140),
            child: Image.network(
              value["pic"],
              fit: BoxFit.fitHeight,
            ),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                "${value["title"]}",
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 4,
              ),
              Text("${value["selectedAttr"]}"),
              const SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "￥${value["price"]}",
                    style: TextStyle(color: Colors.red),
                  ),
                  Text("x${value["count"]}")
                ],
              )
            ],
          )),
        ],
      ),
    );
  }

  Widget _body() {
    return ListView(
      padding: EdgeInsets.all(ScreenAdapter.width(40)),
      children: [
        Obx(() => controller.addressList.isEmpty
            ? Container(
                padding: EdgeInsets.fromLTRB(
                    0, ScreenAdapter.width(20), 0, ScreenAdapter.width(20)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(ScreenAdapter.width(20))),
                child: ListTile(
                  onTap: () {
                    Get.toNamed("/address-list");
                  },
                  leading: const Icon(Icons.add_location),
                  title: const Text("增加收货地址"),
                  trailing: const Icon(Icons.navigate_next),
                ),
              )
            : InkWell(
              onTap: () {
                Get.toNamed("/address-list");
              },
              child: Container(
                margin: EdgeInsets.only(top: ScreenAdapter.width(40)),
                padding: EdgeInsets.fromLTRB(ScreenAdapter.width(40),
                    ScreenAdapter.width(30), 0, ScreenAdapter.width(30)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.circular(ScreenAdapter.width(20))),
                child: Row(
                  children: [
                     Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text("${controller.addressList[0].name} ${controller.addressList[0].phone} "),
                        const SizedBox(
                          height: 10,
                        ),
                        Text("${controller.addressList[0].address}"),
                      ],
                    )),
                    Container(
                      margin: const EdgeInsets.only(right: 20),
                      width: ScreenAdapter.width(100),
                      child: const Center(
                        child: Icon(Icons.navigate_next),
                      ),
                    ),
                  ],
                )),
            )),

        //商品信息
        Container(
            margin: EdgeInsets.only(top: ScreenAdapter.width(40)),
            padding: EdgeInsets.fromLTRB(
                ScreenAdapter.width(40),
                ScreenAdapter.width(30),
                ScreenAdapter.width(30),
                ScreenAdapter.width(30)),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ScreenAdapter.width(20))),
            child: Obx(() => Column(
                  children: controller.checkoutList.map((element) {
                    print(element);
                    return checkoutItem(element);
                  }).toList(),
                ))),

        //信息
        Container(
            margin: EdgeInsets.only(
                top: ScreenAdapter.width(40), bottom: ScreenAdapter.width(40)),
            padding: EdgeInsets.fromLTRB(ScreenAdapter.width(40),
                ScreenAdapter.width(30), 0, ScreenAdapter.width(30)),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ScreenAdapter.width(20))),
            child: const Column(
              children: [
                ListTile(
                  title: Text("运费"),
                  trailing: Wrap(children: [Text("包邮")]),
                ),
                //trailing 里面不能用row
                ListTile(
                  title: Text("优惠券"),
                  trailing: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text("无可用"),
                      Icon(Icons.navigate_next),
                    ],
                  ),
                ),
                ListTile(
                  title: Text("卡券"),
                  trailing: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text("无可用"),
                      Icon(Icons.navigate_next),
                    ],
                  ),
                ),
              ],
            )),

        //发票信息
        Container(
          padding: EdgeInsets.fromLTRB(
              0, ScreenAdapter.width(20), 0, ScreenAdapter.width(20)),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(ScreenAdapter.width(20))),
          child: const ListTile(
            leading: Icon(Icons.add_location),
            title: Text("发票"),
            trailing: Icon(Icons.navigate_next),
          ),
        ),

        const SizedBox(
          height: 80,
        ),
      ],
    );
  }

  Widget _bottom() {
    return Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: Container(
          padding: EdgeInsets.fromLTRB(
              20, 20, 20, ScreenAdapter.getbottomBarHeight()),
          width: double.infinity,
          height:
              ScreenAdapter.height(220 + ScreenAdapter.getbottomBarHeight()),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                top: BorderSide(
                    color: Colors.black12, width: ScreenAdapter.height(2))),
          ),
          child: Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text("共${controller.allNumber}件,合计"),
                      Text(
                        "￥${controller.allPrice}",
                        style: TextStyle(
                            fontSize: ScreenAdapter.fontSize(58),
                            color: Colors.red),
                      ),
                    ],
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: () {
                        controller.doCheckout();
                      },
                      child: const Text("去付款"))
                ],
              )),
        ));
  }

  const CheckoutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 245, 245),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('确认订单'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          _body(),
          _bottom(),
        ],
      ),
    );
  }
}
