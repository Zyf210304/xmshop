import 'package:get/get.dart';
import '../../../services/cartServices.dart';


class CartController extends GetxController {
  //TODO: Implement CartController

  var cartList = [].obs;


  @override
  void onInit() {
    super.onInit();

    // CartServices.clearHistoryData();
    getCartListData();

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getCartListData() async{
    cartList.value = await CartServices.getCartData();
    print(cartList);
    update();
  }

}
