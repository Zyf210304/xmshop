import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/product_content_controller.dart';
import '../../../services/screenAdapter.dart';

class SecondPageViewView extends GetView {
  @override
  ProductContentController controller = Get.find();

  SecondPageViewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      key: controller.globalKey2,
      width: ScreenAdapter.width(1080),
      height: ScreenAdapter.width(1900),
      color: Colors.yellow,
      child: Text("详情\n1\n2\n3\n1\n2\n3"),
    );
  }
}
