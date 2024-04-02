import 'dart:convert';

import 'package:get/get.dart';
import '../../../services/storage.dart';
 
 import '../../../models/user_model.dart';
import '../../../services/signServices.dart';
import '../../../services/userServices.dart';
import '../../../services/httpsClient.dart';
import '../../../models/address_model.dart';
import '../../cart/controllers/cart_controller.dart';

class CheckoutController extends GetxController {
  //TODO: Implement CheckoutController

  var checkoutList = [].obs;
  var allPrice = 0.obs;
  var allNumber = 0.obs;
  HttpClient httpClient = HttpClient();

  //默认地址
  var addressList = <AddressItemModel>[].obs;

  //页面
  CartController cartController = Get.find();


  bool isFromCart = Get.arguments["isFromCart"];

  @override
  void onInit() {
    super.onInit();

    getCheckoutListData();
    getDefalutAddress();

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getCheckoutListData() async{
     checkoutList.value = await Storage.getData("checkoutListData");
     calculatePrice();
     update();
  }

  calculatePrice() {
    var tempCount = 0;
    var tempNumber = 0;

    for (var i = 0; i < checkoutList.length; i++) {
 
        int price = checkoutList[i]["price"];
        int count = checkoutList[i]["count"];
        tempCount = tempCount + price * count;
        tempNumber += count;
    }
    allPrice.value = tempCount.toInt();
    allNumber.value = tempNumber.toInt();
  }

  getDefalutAddress() async{
    List userList = await UserServices.getUserInfo();
    var userInfo = Userinfo.fromJson(userList[0]);
    Map tempJson = {"uid": userInfo.sid};

    var sign = SignServices.getSign({
      ...tempJson,
      "salt": userInfo.salt,
    });

    var response = await httpClient.get("api/oneAddressList?uid=${userInfo.sid}&sign=$sign");
    
    if (response != null) {
      print(response);
      var tempList = AddressModel.fromJson(response.data);
      print(tempList);
      addressList.value = tempList.result!;
     update();
    }
  }


  //结算
  doCheckout() async{

    if(addressList.isEmpty) {
      Get.snackbar("提示", "请选择收货人信息");
      return;
    }

    List userList = await UserServices.getUserInfo();
    var userInfo = Userinfo.fromJson(userList[0]);
    Map tempJson = {
      "uid": userInfo.sid,
      "phone":addressList[0].phone,
      "address":addressList[0].address,
      "name":addressList[0].name,
      "all_price":allPrice.value.toStringAsFixed(1),
      "products":json.encode(checkoutList)
      };

    var sign = SignServices.getSign({
      ...tempJson,
      "salt": userInfo.salt,
    });

    var response = await httpClient.post("api/doOrder", data: {
      ...tempJson,
      "sign":sign,
    });
    print(response);
    if (response.data["success"]) {
      if (isFromCart) {
        cartController.deleteCartData();
      }
      
      Get.offAndToNamed("/buy");
    } else {
      Get.snackbar("提示信息", response.data["message"]);
    }

  }
   
}


  

