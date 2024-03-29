import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/code_login_step_one_controller.dart';
import '../../../../services/screenAdapter.dart';
import '../../../../widget/passTextField.dart';
import '../../../../widget/delegetaRichText.dart';
import '../../../../widget/nextBtn.dart';
import '../../../../widget/logo.dart';

class CodeLoginStepOneView extends GetView<CodeLoginStepOneController> {
  const CodeLoginStepOneView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          actions: [
            TextButton(onPressed: () {}, child: Text("帮助")),
          ],
        ),
        body: ListView(
          padding: EdgeInsets.all(ScreenAdapter.width(40)),
          children: [
            const LogoIcon(),
            PassTextField(
              hintText: "请输入手机号码",
              onChanged: (value) {
                print("value");
              },
            ),
            

            DelegateRichText(chooseChanged: (p0) {
              print(p0);
            }),


            NextBtn(hintText: "获取验证码", onTap: () {
              Get.toNamed("/code-login-step-two");
            },)
          ],
        ));
  }
}
