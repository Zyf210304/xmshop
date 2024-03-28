import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/code_login_step_one_controller.dart';

class CodeLoginStepOneView extends GetView<CodeLoginStepOneController> {
  const CodeLoginStepOneView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CodeLoginStepOneView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'CodeLoginStepOneView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
