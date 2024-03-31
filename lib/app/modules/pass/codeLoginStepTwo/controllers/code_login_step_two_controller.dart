import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../models/message.dart';
import '../../../../services/httpsClient.dart';
import '../../../../services/storage.dart';
import '../../../user/controllers/user_controller.dart';

class CodeLoginStepTwoController extends GetxController {

  final UserController userController = Get.find();

  final TextEditingController editingController = TextEditingController();
  HttpClient httpsClient = HttpClient();
  String tel = Get.arguments["tel"];
  RxInt seconds = 10.obs;

  @override
  void onInit() {
    super.onInit();

    countDown();

  } 
  @override
  void onClose() {
    print("----更新用户状态");
    userController.getUserInfo();
    super.onClose();
  }

  Future<MessageModel> doLogin() async{
     var response = await httpsClient.post("api/validateLoginCode",data:{
        "tel":tel,
        "code":editingController.text
      });
      if (response != null) {
         print(response);
         if(response.data["success"]){        
          //执行登录 保存用户信息
           Storage.setData("userinfo",response.data["userinfo"]);
           return MessageModel(message: "登录成功", success: true);
         }
          return MessageModel(message: response.data["message"], success: false);
      }else{
          return MessageModel(message: "网络异常", success: false);
      }
  }

 //发送验证码
  Future<MessageModel> sendCode() async{
      var response = await httpsClient.post("api/sendLoginCode",data:{
        "tel":tel
      });
      if (response != null) {
         print(response);
         if(response.data["success"]){
          //测试：把验证码复制到剪切板上面，正式上线不需要这句话,这个为了方便测试
          // Clipboard.setData(ClipboardData(text: response.data["code"]));
          seconds.value = 10;
          countDown();
          return MessageModel(message: "发送验证码成功", success: true);
          
         }
        return MessageModel(message: response.data["message"], success: false);
      }else{
        return MessageModel(message:"网络异常", success: false);
      }
  } 

  //倒计时的方法
  countDown() {
    Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      seconds.value--;
      if (seconds.value == 0) {
        timer.cancel();
      }
      update();
    });
  }
  
}
