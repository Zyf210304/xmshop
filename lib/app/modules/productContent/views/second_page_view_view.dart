import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/product_content_controller.dart';
import '../../../services/screenAdapter.dart';

class SecondPageViewView extends GetView {
  @override
  ProductContentController controller = Get.find();
  Function subHeader;


  SecondPageViewView(this.subHeader,{Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container( 
      key: controller.globalKey2,
      width: ScreenAdapter.width(1080),
      height: ScreenAdapter.width(1080),
      child: Column(
        children: [
          subHeader()
        ],
      ),
    );
  }
}
