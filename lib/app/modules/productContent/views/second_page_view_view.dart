import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:get/get.dart';

import '../controllers/product_content_controller.dart';
import '../../../services/screenAdapter.dart';

class SecondPageViewView extends GetView {
  @override
  ProductContentController controller = Get.find();
  Function subHeader;

  SecondPageViewView(this.subHeader, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      key: controller.globalKey2,
      width: ScreenAdapter.width(1080),
      // height: ScreenAdapter.width(1080),
      child: Obx(() =>controller.pcontent.value.sId  != null ?  Column(
            children: [
              subHeader(),
              controller.selectedSubTitleIndex.value == 1
                  ? SizedBox(
                      child: Html(
                      data: controller.pcontent.value.content,
                      style: {
                        "body": Style(backgroundColor: Colors.white),
                        "p": Style(fontSize: FontSize.large)
                      },
                      onLinkTap: (url, attributes, element) {
                        print(url);
                      },
                    ))
                  : SizedBox(
                      child: Html(
                      data: controller.pcontent.value.specs,
                      style: {
                        "body": Style(backgroundColor: Colors.white),
                        "p": Style(fontSize: FontSize.large)
                      },
                      onLinkTap: (url, attributes, element) {
                        print(url);
                      },
                    ))
            ],
          ) : const Center(child: CircularProgressIndicator())),
    );
  }
}
