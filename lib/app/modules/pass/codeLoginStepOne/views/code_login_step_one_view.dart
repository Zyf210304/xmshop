import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/models/message.dart';
import 'package:xmshop/app/widget/passButton.dart';
import '../../../../widget/userAgreement.dart';
import '../../../../widget/passTextField.dart';
import '../controllers/code_login_step_one_controller.dart';
import "../../../../services/screenAdapter.dart";
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
        actions: [TextButton(onPressed: () {}, child: Text("帮助"))],
      ),
      body: ListView(
        padding: EdgeInsets.all(ScreenAdapter.width(40)),
        children: [
          //logo
          const Logo(),
          //输入手机号
          PassTextFiled(
            controller: controller.telController,
              hintText: "请输入手机号",
              onChanged: (value) {
                print(value);
              }),
                    
          //用户协议
          const UserAgreement(),
          //登录按钮
          PassButton(text: "获取验证码", onPressed: () async{
            print("获取验证码");
            if(GetUtils.isPhoneNumber(controller.telController.text)) {

              MessageModel resulte = await controller.sendCode();
              if (resulte.success) {
                Get.offAndToNamed("/code-login-step-two", arguments: {"tel":controller.telController.text});
              } else {
                Get.snackbar("提示", resulte.message);
              }
            } else {
              Get.snackbar("提示", "手机号格式错误");
            }
            
          }),
         SizedBox(height: ScreenAdapter.height(40)),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(onPressed: (){
                Get.toNamed("/register-step-one");
              }, child: Text("新用户注册")),
              TextButton(onPressed: (){
                  Get.offAndToNamed("/pass-login");
              }, child: Text("账户密码登录"))
            ],
          )
        
        ],
      ),
    );
  }
}
