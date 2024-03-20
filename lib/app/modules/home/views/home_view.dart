import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Obx(() {
            return Text(
              '${controller.count}',
              style: const TextStyle(fontSize: 20),
            );
          }),
          SizedBox(height: 40),
          ElevatedButton(onPressed: () {
            Get.toNamed('/user');
          }, child: Text("跳转按钮"))
        ],
      )),
    );
  }
}
