import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../../models/user_model.dart';
import '../../../../services/signServices.dart';
import '../../../../services/userServices.dart';
import '../../../../services/httpsClient.dart';
import '../../addressList/controllers/address_list_controller.dart';

class AddressAddController extends GetxController {
  //TODO: Implement AddressAddController

  HttpClient httpClient = HttpClient();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addreeController = TextEditingController();

  var area = "".obs;
  
  AddressListController addressListController = Get.find();

  @override
  void onInit() {
    super.onInit();
    changedArea("");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    addressListController.getAddressList();
    super.onClose();
  }

  changedArea(address) {
    area.value = address;
    update();
  }

  doAddAddress() async{

    List userList = await UserServices.getUserInfo();
    var userInfo = Userinfo.fromJson (userList[0]);
    if (nameController.text.length < 2) {
      Get.snackbar("提示信息", "请把姓名填写完整");
    } else if (!GetUtils.isPhoneNumber(phoneController.text) ||
        phoneController.text.length != 11) {
      Get.snackbar("提示信息", "手机号不合法");
    } else if (area.value.length < 2) {
      Get.snackbar("提示信息", "请选择地区");
    } else if (addreeController.text.length < 2) {
      Get.snackbar("提示信息", "请填写详细的地址");
    } else {
      Map tempJson = {
        "uid": userInfo.sid,
        "name": nameController.text,
        "phone": phoneController.text,
        "address": "${area.value} ${addreeController.text}",       
      };
      String sign = SignServices.getSign({
         ...tempJson,    //合并对象
         "salt": userInfo.salt, //登录成功后服务器返回的salt  私钥
      });
      var response=await httpClient.post("api/addAddress", data: {
           ...tempJson,    
           "sign":sign
      });
      if(response.data["success"]){
         Get.back();
      }else{
        Get.snackbar("提示信息", response.data["message"]);
      }
    }


  }
    
  

}
