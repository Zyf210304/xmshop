import 'dart:ffi';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/search_controller.dart';

import '../../../services/screenAdapter.dart';

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
            autofocus: true,
            style: TextStyle(fontSize: ScreenAdapter.fontSize(36)),
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(0), //输入框居中
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                )),
          )),
      centerTitle: true,
      backgroundColor: Colors.white,
      elevation: 0,
      actions: [
        TextButton(
            onPressed: () {
              print("搜索");
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
        Row(
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
                onPressed: () {},
                icon: const Icon(Icons.delete_forever_outlined)),
          ],
        ),
        Wrap(
          children: List.filled(6, "shouji").map((e) {
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
            IconButton(onPressed: () {}, icon: const Icon(Icons.refresh)),
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
                              text: const TextSpan(
                                  text: "K50 至尊版 骄龙8+ 牛逼  ",
                                  style: TextStyle(color: Colors.black54),
                                  children: [
                                    TextSpan(
                                      text: " 热 ",
                                      style: TextStyle(
                                          color: Colors.red,
                                          // backgroundColor: Colors.green,
                                          // decorationStyle: TextDecorationStyle.wavy
                                            

                                      )
                                    )
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
