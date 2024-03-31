import 'package:get/get.dart';
import '../../../services/storage.dart';
 
class CheckoutController extends GetxController {
  //TODO: Implement CheckoutController

  var checkoutList = [].obs;

  var allPrice = 0.obs;
  var allNumber = 0.obs;

  @override
  void onInit() {
    super.onInit();

    getCheckoutListData();

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
  
}
