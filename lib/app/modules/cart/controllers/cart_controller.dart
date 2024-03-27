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

  //改变数量
  changNumber(isAdd, cartItem) {
    var tempList = [];
    for (var i = 0; i < cartList.length; i++) {
      if (cartList[i]["_id"] == cartItem["_id"] && cartList[i]["selectedAttr"] == cartItem["selectedAttr"]) {
        if (isAdd) {
           cartList[i]["count"] ++;
        } else {
          if(cartList[i]["count"] > 1) {
            cartList[i]["count"] --;
          }
        }
      } 
      tempList.add(cartList[i]);
    }
    
    cartList.value = tempList;
    CartServices.setCartList(cartList);
    update();

  }


}
