import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/code_login_step_one_controller.dart';
import '../../../../services/screenAdapter.dart';
import '../../../../services/ityingFonts.dart';
import '../../../../widget/passTextField.dart';
import '../../../../widget/delegetaRichText.dart';

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
            Container(
              margin: EdgeInsets.only(top: ScreenAdapter.width(40)),
              child: const Icon(
                ItyingFonts.xiaomi,
                size: 80,
                color: Color.fromARGB(255, 216, 57, 57),
              ),
            ),
            PassTextField(
              hintText: "请输入手机号码",
              onChanged: (value) {
                print("value");
              },
            ),
            
            DelegateRichText(chooseChange: (p0) {
              print(p0);
            }),


            Container(
              margin: EdgeInsets.only(top: ScreenAdapter.height(80)),
              height: ScreenAdapter.height(130),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  foregroundColor: MaterialStateProperty.all(Colors.white)
                ),
                onPressed: () {}, child: Text("获取验证码", style: TextStyle(fontSize: ScreenAdapter.fontSize(45)),)),
            )
          ],
        ));
  }
}
