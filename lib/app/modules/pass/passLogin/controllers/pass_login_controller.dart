import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../../models/message.dart';
import '../../../../services/httpsClient.dart';
import '../../../../services/storage.dart';
import '../../../user/controllers/user_controller.dart';

class PassLoginController extends GetxController {
  //TODO: Implement PassLoginController

final UserController userController = Get.find();

  TextEditingController telController = TextEditingController();
  TextEditingController passController = TextEditingController();
  HttpClient httpsClient = HttpClient();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    userController.getUserInfo();
    super.onClose();
  }

  Future<MessageModel> doLogin() async{

      var response = await httpsClient.post("api/doLogin",data:{
        "username":telController.text,
        "password":passController.text
      });

      if (response != null) {

         if(response.data["success"] == true){
            //保存用户信息
            Storage.setData("userinfo", response.data["userinfo"]);
            return MessageModel(message: "登录成功", success: true);
         }
        return MessageModel(message: response.data["message"], success: false);
      }else{
        return MessageModel(message:"网络异常", success: false);
      }
  }

 
}
