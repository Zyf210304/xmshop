import 'package:get/get.dart';
import '../../../services/storage.dart';
 
 import '../../../models/user_model.dart';
import '../../../services/signServices.dart';
import '../../../services/userServices.dart';
import '../../../services/httpsClient.dart';
import '../../../models/address_model.dart';

class CheckoutController extends GetxController {
  //TODO: Implement CheckoutController

  var checkoutList = [].obs;

  var allPrice = 0.obs;
  var allNumber = 0.obs;

  HttpClient httpClient = HttpClient();

  //默认地址
  var addressList = <AddressItemModel>[].obs;

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
  
}
