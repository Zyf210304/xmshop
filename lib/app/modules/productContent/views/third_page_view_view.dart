import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../controllers/product_content_controller.dart';
import '../../../services/screenAdapter.dart';

class ThirdPageViewView extends GetView {
  @override
  ProductContentController controller = Get.find();
  ThirdPageViewView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      key: controller.globalKey3,
      width: ScreenAdapter.width(1080),
      height: ScreenAdapter.width(3400),
      color: Colors.blue,
      child: Text("推荐\n1\n2\n3\n1\n2\n3"),
    );
  }
}
