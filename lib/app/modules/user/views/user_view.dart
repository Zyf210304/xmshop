import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/services/httpsClient.dart';
import 'package:xmshop/app/widget/passButton.dart';
import '../../../services/screenAdapter.dart';
import '../controllers/user_controller.dart';

class UserView extends GetView<UserController> {
  const UserView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(246, 246, 246, 1),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("会员码"),
              IconButton(onPressed: () {}, icon: Icon(Icons.qr_code_outlined)),
              IconButton(onPressed: () {}, icon: Icon(Icons.settings_outlined)),
              IconButton(onPressed: () {}, icon: Icon(Icons.message_outlined)),
            ],
          )
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(ScreenAdapter.height(20)),
        children: [
          //登录注册
          Obx(() => controller.isLogin == false
              ? Row(
                  children: [
                    SizedBox(
                      width: ScreenAdapter.width(40),
                    ),
                    SizedBox(
                      width: ScreenAdapter.width(150),
                      height: ScreenAdapter.width(150),
                      child: CircleAvatar(
                        radius: ScreenAdapter.width(75),
                        backgroundImage:
                            const AssetImage("assets/images/user.png"),
                      ),
                    ),
                    SizedBox(
                      width: ScreenAdapter.width(40),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed("/code-login-step-one");
                      },
                      child: Text(
                        "登录/注册",
                        style: TextStyle(fontSize: ScreenAdapter.fontSize(46)),
                      ),
                    ),
                    SizedBox(
                      width: ScreenAdapter.width(40),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: ScreenAdapter.fontSize(36),
                      color: Colors.black45,
                    )
                  ],
                )
              : Row(
                  children: [
                    SizedBox(
                      width: ScreenAdapter.width(40),
                    ),
                    SizedBox(
                      width: ScreenAdapter.width(150),
                      height: ScreenAdapter.width(150),
                      child: CircleAvatar(
                        radius: ScreenAdapter.width(75),
                        backgroundImage:
                            const AssetImage("assets/images/user.png"),
                      ),
                    ),
                    SizedBox(
                      width: ScreenAdapter.width(40),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "${controller.userInfo.value.username}",
                          style:
                              TextStyle(fontSize: ScreenAdapter.fontSize(46)),
                        ),
                        Text("高级会员"),
                      ],
                    ),
                  ],
                )),

          //用户资金信息
          Obx(() => Container(
            height: ScreenAdapter.height(180),
            margin: EdgeInsets.only(top: ScreenAdapter.height(60)),
            child: Row(
                children: ["米金", "优惠券", "红包", "最高额度", "钱包"]
                    .asMap()
                    .entries
                    .map((e) => Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            e.key == 4
                                ? Container(
                                    alignment: Alignment.center,
                                    height: ScreenAdapter.width(120),
                                    child: Icon(Icons.wallet),
                                  )
                                : Text(
                                    controller.moneyValue.value[e.key],
                                    style: TextStyle(
                                        fontSize: ScreenAdapter.fontSize(50),
                                        fontWeight: FontWeight.bold),
                                  ),
                            Text(
                              e.value,
                              style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(34),
                                  color: Colors.black87),
                            ),
                          ],
                        )))
                    .toList()),
          )),

          //新人礼
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: ScreenAdapter.height(50)),
            child: Container(
              width: ScreenAdapter.width(1008),
              height: ScreenAdapter.width(300),
              decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage("assets/images/user_ad1.png"),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(ScreenAdapter.width(20)),
              ),
            ),
          ),

          //订单
          Container(
            margin: EdgeInsets.fromLTRB(
                ScreenAdapter.width(20),
                ScreenAdapter.width(20),
                ScreenAdapter.width(20),
                ScreenAdapter.width(20)),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ScreenAdapter.width(20))),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    "收藏",
                    "",
                    "足迹",
                    "",
                    "关注",
                  ].asMap().entries.map((e) {
                    if (e.key % 2 == 1) {
                      return Container(
                        height: 20,
                        width: 1,
                        color: Colors.grey,
                      );
                    } else {
                      return Expanded(
                          flex: 1,
                          child: Container(
                              height: 40,
                              alignment: Alignment.center,
                              child: Text(
                                e.value,
                                style: TextStyle(color: Colors.black54),
                              )));
                    }
                  }).toList(),
                ),
                const Divider(
                  color: Colors.black38,
                  endIndent: 10,
                  indent: 10,
                  height: 0.5,
                ),
                Row(
                    children: ["代付款", "待收货", "待评价", "退货/售后", "全部订单"]
                        .asMap()
                        .entries
                        .map((e) => Expanded(
                            flex: 1,
                            child: Container(
                              height: 80,
                              alignment: Alignment.center,
                              child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Icon(
                                      Icons.payment_rounded,
                                      color: Colors.black,
                                    ),
                                    Text(
                                      e.value,
                                      style: TextStyle(
                                          fontSize: ScreenAdapter.fontSize(30),
                                          color: Colors.black87),
                                    ),
                                  ],
                                ),
                              ),
                            )))
                        .toList()),
              ],
            ),
          ),

          //服务
          Container(
            margin: EdgeInsets.fromLTRB(ScreenAdapter.width(20), 0,
                ScreenAdapter.width(20), ScreenAdapter.width(20)),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ScreenAdapter.width(20))),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(ScreenAdapter.height(20)),
                      child: Text(
                        "  服务",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: ScreenAdapter.fontSize(44),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const Text(
                      "更多 >  ",
                      style: TextStyle(color: Colors.black26),
                    )
                  ],
                ),
                GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 4,
                    childAspectRatio: 1.25,
                    children: controller.servicesTitleArr
                        .asMap()
                        .entries
                        .map((e) => Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  controller.servicesIcon[e.key],
                                  color: Colors.black,
                                ),
                                Text(
                                  e.value,
                                  style: TextStyle(
                                      fontSize: ScreenAdapter.fontSize(30),
                                      color: Colors.black87),
                                ),
                              ],
                            ))
                        .toList()),
              ],
            ),
          ),

          //推荐
          //新人礼
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: ScreenAdapter.height(50)),
            child: Container(
              width: ScreenAdapter.width(1008),
              height: ScreenAdapter.width(300),
              decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage("assets/images/user_ad1.png"),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(ScreenAdapter.width(20)),
              ),
            ),
          ),

          //退出按钮
          PassButton(
              text: "退出登录",
              onPressed: () {
                controller.loginOut();
              })
        ],
      ),
    );
  }
}
