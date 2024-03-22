import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/product_list_controller.dart';
import '../../../services/screenAdapter.dart';

class ProductListView extends GetView<ProductListController> {
  const ProductListView({Key? key}) : super(key: key);

  Widget _subHeaderWidget() {
    return Positioned(
        left: 0,
        right: 0,
        top: 0,
        child: Container(
          height: ScreenAdapter.width(120),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  bottom: BorderSide(
                      width: ScreenAdapter.height(2),
                      color: const Color.fromRGBO(233, 233, 233, 0.9)))),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: InkWell(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, ScreenAdapter.height(16), 0,
                        ScreenAdapter.height(16)),
                    child: Text(
                      "综合",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: ScreenAdapter.fontSize(32)),
                    ),
                  ),
                  onTap: () {},
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, ScreenAdapter.height(16), 0,
                        ScreenAdapter.height(16)),
                    child: Text("销量",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: ScreenAdapter.fontSize(32))),
                  ),
                  onTap: () {},
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, ScreenAdapter.height(16), 0,
                        ScreenAdapter.height(16)),
                    child: Text("价格",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: ScreenAdapter.fontSize(32))),
                  ),
                  onTap: () {},
                ),
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, ScreenAdapter.height(16), 0,
                        ScreenAdapter.height(16)),
                    child: Text("筛选",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: ScreenAdapter.fontSize(32))),
                  ),
                  onTap: () {
                    //注意：新版本中ScaffoldState? 为可空类型 注意判断
                  },
                ),
              ),
            ],
          ),
        ));
  }

  AppBar _appBar() {
    return AppBar(
      title: Container(
        width: ScreenAdapter.width(910),
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
    );
  }

  Widget _listView() {
    return ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.fromLTRB(
              ScreenAdapter.width(20),
              0,
              ScreenAdapter.width(20),
              ScreenAdapter.width(20),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(ScreenAdapter.width(40))),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(ScreenAdapter.width(60)),
                  width: ScreenAdapter.width(400),
                  height: ScreenAdapter.height(460),
                  child: Image.network(
                    "https://xiaomi.itying.com/public/upload/5xyr9OTSK1pwJ5ng7YgpKOkd.png_200x200.png",
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: ScreenAdapter.height(20)),
                      child: Text(
                        "手机型号",
                        style: TextStyle(
                            fontSize: ScreenAdapter.fontSize(42),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: ScreenAdapter.height(20)),
                      child: Text(
                        "手机描述信息",
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: ScreenAdapter.fontSize(34),
                        ),
                      ),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(bottom: ScreenAdapter.height(20)),
                      child: Row(children: [
                        Expanded(
                            child: Column(
                          children: [
                            Text(
                              "title",
                              style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(34),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "sub_title",
                              style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(34)),
                            )
                          ],
                        )),
                        const SizedBox(
                          width: 1,
                          height: 40,
                          child: DecoratedBox(
                              decoration: BoxDecoration(color: Colors.grey)),
                        ),
                        Expanded(
                            child: Column(
                          children: [
                            Text(
                              "title",
                              style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(34),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "sub_title",
                              style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(34)),
                            )
                          ],
                        )),
                        const SizedBox(
                          width: 1,
                          height: 40,
                          child: DecoratedBox(
                              decoration: BoxDecoration(color: Colors.grey)),
                        ),
                        Expanded(
                            child: Column(
                          children: [
                            Text(
                              "title",
                              style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(34),
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "sub_title",
                              style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(34)),
                            )
                          ],
                        )),
                      ]),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(bottom: ScreenAdapter.height(20)),
                      child: Text(
                        "价格",
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: ScreenAdapter.fontSize(38),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ))
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    print(Get.arguments);

    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
      appBar: _appBar(),
      body: Stack(
        children: [
          
          Container(
            margin: EdgeInsets.only(top: ScreenAdapter.width(125)),
            child: _listView(),
          ),
           _subHeaderWidget(),
          
        ],
      ),
    );
  }
}
