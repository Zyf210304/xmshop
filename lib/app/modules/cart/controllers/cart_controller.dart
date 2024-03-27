import 'package:get/get.dart';
import '../../../services/cartServices.dart';


class CartController extends GetxController {
  //TODO: Implement CartController

  var cartList = [].obs;
  var isAllChoose = true.obs;
  var allPrice = 0.obs;

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
    calculateIsAllChoose();
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
    
    saveAndUpdate(tempList); 

  }


  //改变数量
  changChecked(cartItem) {
    var tempList = [];
    for (var i = 0; i < cartList.length; i++) {
      if (cartList[i]["_id"] == cartItem["_id"] && cartList[i]["selectedAttr"] == cartItem["selectedAttr"]) {

           cartList[i]["checked"] = !cartList[i]["checked"];
        
      } 
      tempList.add(cartList[i]);
    }
    

    saveAndUpdate(tempList); 

  }


  calculateIsAllChoose() {
    bool isCheckedAll = true;
    var tempCount = 0;


    for (var i = 0; i < cartList.length; i++) {
      
      if(!cartList[i]["checked"]) {
        isCheckedAll = false;
      }
      
      int price =  cartList[i]["price"];
      int count = cartList[i]["count"];
      tempCount = tempCount + price  *count;
    }
    isAllChoose.value = isCheckedAll;
    allPrice.value = tempCount.toInt();
    print(allPrice);


  }
  
  checkedAll(isAll) {
    var tempList = [];
    for (var i = 0; i < cartList.length; i++) {
      
      cartList[i]["checked"] = isAll;
      tempList.add(cartList[i]);
    }
    isAllChoose.value = isAll;
    saveAndUpdate(tempList); 
  }


  saveAndUpdate(tempList) {
    cartList.value = tempList;
    calculateIsAllChoose();
    CartServices.setCartList(cartList);
    update();
  }
}
