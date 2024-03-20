import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

import '../../../services/keepAliveWrapper.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  KeepAliveWrapper(child: Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: ListView.builder(
            itemCount: 15,
            itemBuilder:(context, index) {
            return ListTile(title: Text("list --- $index"),);
          } ),
    ));
  }
}
