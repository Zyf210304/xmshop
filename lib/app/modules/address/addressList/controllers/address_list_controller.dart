import 'package:get/get.dart';

import '../../../../models/user_model.dart';
import '../../../../services/signServices.dart';
import '../../../../services/userServices.dart';
import '../../../../services/httpsClient.dart';
import '../../../../models/address_model.dart';

import '../../../checkout/controllers/checkout_controller.dart';

class AddressListController extends GetxController {
  //TODO: Implement AddressListController

  HttpClient httpClient = HttpClient();
  var addressList = <AddressItemModel>[].obs;

  CheckoutController checkoutController = Get.find();

  var needChangeAddressModel = AddressItemModel().obs;


  @override 
  void onInit() {
    super.onInit();
    getAddressList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    checkoutController.getDefalutAddress();
    super.onClose();
  }

  getAddressList() async {
    List userList = await UserServices.getUserInfo();
    var userInfo = Userinfo.fromJson(userList[0]);
    Map tempJson = {"uid": userInfo.sid};

    var sign = SignServices.getSign({
      ...tempJson,
      "salt": userInfo.salt,
    });

    var response = await httpClient.get("api/addressList?uid=${userInfo.sid}&sign=$sign");
    
    if (response != null) {
      print(response);
      var tempList = AddressModel.fromJson(response.data);
      print(tempList);
      addressList.value = tempList.result!;
     update();
    }
  }

  changeDefalueAddress(id) async {

     List userList = await UserServices.getUserInfo();
    var userInfo = Userinfo.fromJson(userList[0]);
    Map tempJson = {"uid": userInfo.sid, "id":id};

    var sign = SignServices.getSign({
      ...tempJson,
      "salt": userInfo.salt,
    });

    var response = await httpClient.post("api/changeDefaultAddress", data: {
      ...tempJson,
      "sign":sign,
    });
    
    if (response != null) {
      Get.back();
    }

  }

  deleteAddress(id) async {

     List userList = await UserServices.getUserInfo();
    var userInfo = Userinfo.fromJson(userList[0]);
    Map tempJson = {"uid": userInfo.sid, "id":id};

    var sign = SignServices.getSign({
      ...tempJson,
      "salt": userInfo.salt,
    });

    var response = await httpClient.post("api/deleteAddress", data: {
      ...tempJson,
      "sign":sign,
    });
    
    if (response != null) {
      // Get.back();
      getAddressList();
    }

  }

  getNeedChangeAddress(AddressItemModel model) {
    needChangeAddressModel.value  = model;
    
  }

}
