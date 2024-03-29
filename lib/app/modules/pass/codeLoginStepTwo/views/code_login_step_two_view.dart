import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:get/get.dart';

import '../controllers/code_login_step_two_controller.dart';
import '../../../../services/screenAdapter.dart';
import '../../../../widget/passTextField.dart';
import '../../../../widget/delegetaRichText.dart';
import '../../../../widget/nextBtn.dart';
import '../../../../widget/logo.dart';

class CodeLoginStepTwoView extends GetView<CodeLoginStepTwoController> {
  const CodeLoginStepTwoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('手机号快速登录'),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            const LogoIcon(),
            Container(
              margin: EdgeInsets.only(top: ScreenAdapter.height(60)),
              padding: EdgeInsets.all(ScreenAdapter.width(40)),
              child: PinCodeTextField(
                
                //123456
                autoFocus: true,
                keyboardType: TextInputType.number,
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                dialogConfig: DialogConfig(   //配置弹框样式
                  dialogTitle: "粘贴验证码",
                  dialogContent: "确定要粘贴验证码",
                  affirmativeText: "确认",
                  negativeText: "取消"
                ),
                pinTheme: PinTheme(   //样式
                activeColor: Colors.blue, //边框 输入文字后的颜色
                selectedColor: Colors.blue,  //边框 选中后的颜色
                inactiveColor: Colors.black12,  //默认边框颜色
                inactiveFillColor: Colors.white,  //默认颜色
                activeFillColor: Colors.white, //改变后 内部颜色


                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  
                ),
                animationDuration: const Duration(milliseconds: 300),
                // backgroundColor: Colors.blue.shade50,
                enableActiveFill: true,
                controller: controller.textEditingController,
                onCompleted: (v) {
                  print("Completed");
                },
                onChanged: (value) {
                  print(value);
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                  //but you can show anything you want here, like your pop up saying wrong paste format or etc
                  return true;
                }, appContext: context,
              ),
            ),
            SizedBox(
              // padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [ 
                  TextButton(onPressed: (){}, child: Text("重新发送验证码")),
                  TextButton(onPressed: (){}, child: Text("帮助")),
                ],
              ),
            ),
            NextBtn(hintText: "下一步", onTap: () {
              print(controller.textEditingController.text);
              //收起键盘
              Focus.of(context).requestFocus(FocusNode());
            }, margin_h: 20,)
          ],
        ));
  }
}
