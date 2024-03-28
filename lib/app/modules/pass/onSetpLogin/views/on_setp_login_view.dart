import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/on_setp_login_controller.dart';

class OnSetpLoginView extends GetView<OnSetpLoginController> {
  const OnSetpLoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OnSetpLoginView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'OnSetpLoginView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
