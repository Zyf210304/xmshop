import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/search_controller.dart';

import '../../../services/screenAdapter.dart';
import '../../../services/searchServices.dart';


class SearchView extends GetView<SearchController1> {
  const SearchView({Key? key}) : super(key: key);

  AppBar _appBar() {
    return AppBar(
      title: Container(
          width: ScreenAdapter.width(840),
          height: ScreenAdapter.height(96),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(246, 246, 246, 1),
            borderRadius: BorderRadius.circular(30),
          ),
          child: TextField(
            // autofocus: true,
            style: TextStyle(fontSize: ScreenAdapter.fontSize(36)),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0), //输入框居中
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                )),
            onChanged: (value){
              controller.keywords = value;
            },
            onSubmitted: (value) {
              controller.keywords = value;

              //保存搜索记录
              SearchServices.setHistoryData(value);

              // Get.toNamed("/product-list", arguments: {"keywords": controller.keywords});
              // 替换路由
              Get.offAndToNamed("/product-list", arguments: {"keywords": controller.keywords});

            }, 
          )),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        TextButton(
            onPressed: () {

              //保存搜索记录
              SearchServices.setHistoryData(controller.keywords);
              // Get.toNamed("/product-list", arguments: {"keywords": controller.keywords});
               Get.offAndToNamed("/product-list", arguments: {"keywords": controller.keywords});
            },
            child: Text(
              "搜索",
              style: TextStyle(
                  fontSize: ScreenAdapter.width(38), color: Colors.black54),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(246, 246, 246, 1),
      appBar: _appBar(),
      body:
          ListView(padding: EdgeInsets.all(ScreenAdapter.width(20)), children: [
        Obx(() => controller.histroyList.isNotEmpty ? Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "搜索历史",
                style: TextStyle(
                    fontSize: ScreenAdapter.fontSize(42),
                    fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
                onPressed: () {
                  Get.bottomSheet(Container(
                color: Colors.white,
                padding: EdgeInsets.all(ScreenAdapter.width(20)),
                width: ScreenAdapter.width(1080),
                height: ScreenAdapter.width(460),
                child: Column(children: [
                  const SizedBox(height: 20,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text("您确定要清空历史记录吗"),
                  ],),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    
                    ElevatedButton(
                      
                      onPressed: (){
                      Get.back();
                    }, child: const Text("取消")),
                    
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                         foregroundColor: MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: (){
                      controller.clearHistoryData();
                      Get.back();
                    }, child: const Text("确定")),
                  ],),
                ]),
              ));

                },
                icon: const Icon(Icons.delete_forever_outlined)),
          ],
        ) : const Text("")),
        Obx(() => Wrap(
          children: controller.histroyList.map((e) {
            return GestureDetector(
              onLongPress: () {
                
                Get.bottomSheet(Container(
                color: Colors.white,
                padding: EdgeInsets.all(ScreenAdapter.width(20)),
                width: ScreenAdapter.width(1080),
                height: ScreenAdapter.width(460),
                child: Column(children: [
                  const SizedBox(height: 20,),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text("您确定删除这个记录吗"),
                  ],),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                    
                    ElevatedButton(
                      
                      onPressed: (){
                      Get.back();
                    }, child: const Text("取消")),
                    
                    ElevatedButton(
                      
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                         foregroundColor: MaterialStateProperty.all(Colors.white),
                      ),
                      onPressed: (){
                      controller.clearHistoryData();
                      Get.back();
                    }, child: const Text("确定")),
                  ],),
                ]),
              ));

              },
              child: Container(
              padding: EdgeInsets.all(ScreenAdapter.width(20)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.white),
              margin: EdgeInsets.fromLTRB(
                  ScreenAdapter.width(30),
                  ScreenAdapter.width(20),
                  ScreenAdapter.width(30),
                  ScreenAdapter.width(20)),
              child: Text(e),
            ),
            );
          }).toList(),
        )),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "猜你喜欢",
                style: TextStyle(
                    fontSize: ScreenAdapter.fontSize(42),
                    fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(onPressed: () {
              
            }, icon: const Icon(Icons.refresh)),
          ],
        ),
        Wrap(
          children: List.filled(6, "手表 小天才").map((e) {
            return Container(
              padding: EdgeInsets.all(ScreenAdapter.width(20)),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.white),
              margin: EdgeInsets.fromLTRB(
                  ScreenAdapter.width(30),
                  ScreenAdapter.width(20),
                  ScreenAdapter.width(30),
                  ScreenAdapter.width(20)),
              child: Text(e),
            );
          }).toList(),
        ),

        const SizedBox(
          height: 20,
        ),
        //热销商品
        Container(
          // height: 200,
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.white),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: ScreenAdapter.height(138),
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/hot_search.png"),
                        fit: BoxFit.cover)),
              ),
              GridView.builder(
                  itemCount: 6,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: ScreenAdapter.width(40),
                      mainAxisSpacing: ScreenAdapter.width(20),
                      childAspectRatio: 3 / 1),
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: ScreenAdapter.width(120),
                          padding: EdgeInsets.all(ScreenAdapter.width(20)),
                          child: Image.network(
                            "https://www.itying.com/images/shouji.png",
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        Expanded(
                            child: Container(
                          padding: EdgeInsets.all(ScreenAdapter.width(10)),
                          child: RichText(
                              text: TextSpan(
                                  text: "K50 至尊版 骄龙8+ 牛逼  ",
                                  style: TextStyle(color: Colors.black54),
                                  children: [
                                WidgetSpan(
                                    child: Image.network(
                                  "https://ts1.cn.mm.bing.net/th/id/R-C.5a5b0c06fd29a679b417d82c26e7a357?rik=wH6RxFCYJnyVGA&riu=http%3a%2f%2fn.sinaimg.cn%2fsinacn20114%2f0%2fw400h400%2f20190314%2fe4f6-hufnxfn3145340.jpg&ehk=SVMJ0At9G9Ml3451tQhy9nbsnj6rbobvxyrKkN0MvBk%3d&risl=&pid=ImgRaw&r=0",
                                  fit: BoxFit.cover,
                                  width: 20,
                                  height: 20,
                                ))
                              ])),
                        ))
                      ],
                    );
                  })
            ],
          ),
        )
      ]),
    );
  }
}
