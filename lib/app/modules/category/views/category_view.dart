import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/models/category_model_model.dart';
import 'package:xmshop/app/services/keepAliveWrapper.dart';

import '../controllers/category_controller.dart';

import '../../../services/httpsClient.dart';
import '../../../services/screenAdapter.dart';

class CategoryView extends GetView<CategoryController> {
  const CategoryView({Key? key}) : super(key: key);

  AppBar _appBar() {
    return AppBar(
      title: Container(
        width: ScreenAdapter.width(840),
        height: ScreenAdapter.height(96),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(246, 246, 246, 1),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 4, 0),
            child: Icon(
              Icons.search,
              color: Colors.black45,
            ),
          ),
          Text(
            "手机",
            style: TextStyle(
                color: Colors.black45, fontSize: ScreenAdapter.fontSize(32)),
          ),
        ]),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.message,
              color: Colors.black54,
            ))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
        child: Scaffold(
      appBar: _appBar(),
      body: Row(
        children: [
          SizedBox(
              width: ScreenAdapter.width(280),
              height: double.infinity,
              child: Obx(
                () => ListView.builder(
                    itemCount: controller.leftList.length,
                    itemBuilder: (context, index) {
                      CategoryItemModel model = controller.leftList[index];
                      return SizedBox(
                          width: double.infinity,
                          height: ScreenAdapter.height(180),
                          child: Obx(() => InkWell(
                                onTap: () {
                                  // controller.selectIndex.value = index;
                                  controller.changeIndex(index);
                                },
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        width: ScreenAdapter.width(10),
                                        height: ScreenAdapter.height(46),
                                        color: controller.selectIndex == index
                                            ? Colors.red
                                            : Colors.transparent,
                                      ),
                                    ),
                                    Center(
                                      child: Text(
                                        model.title!,
                                        style: TextStyle(
                                            fontWeight:
                                                controller.selectIndex == index
                                                    ? FontWeight.bold
                                                    : FontWeight.normal),
                                      ),
                                    )
                                  ],
                                ),
                              )));
                    }),
              )),
          Expanded(
              child: Container(
                  height: double.infinity,
                  // color: Colors.black,
                  child: Obx(
                    () => GridView.builder(
                        itemCount: controller.rightList.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: ScreenAdapter.width(40),
                            mainAxisSpacing: ScreenAdapter.width(40),
                            childAspectRatio: 2 / 3),
                        itemBuilder: (context, index) {
                          CategoryItemModel model = controller.rightList[index];
                          return InkWell(
                            onTap: () {
                              Get.toNamed("/product-list",arguments: {"cid":model.sId});
                            },
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  child: Image.network(
                                    HttpClient.replaceUri(model.pic),
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: ScreenAdapter.height(30)),
                                  child: Text(
                                    model.title!,
                                    style: TextStyle(
                                        fontSize: ScreenAdapter.fontSize(36)),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  )))
        ],
      ),
    ));
  }
}
