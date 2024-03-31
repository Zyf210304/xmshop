import 'package:get/get.dart';
import '../../../services/storage.dart';
import '../../../services/cartServices.dart';
import '../../../services/userServices.dart';

class CartController extends GetxController {
  //TODO: Implement CartController

  //列表数据
  var cartList = [].obs;

  //全选
  var isAllChoose = true.obs;

  //总价
  var allPrice = 0.obs;

  //编辑状态
  var isEdit = false.obs;

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

  getCartListData() async {
    cartList.value = await CartServices.getCartData();
    calculateIsAllChoose();
    update();
  }

  //改变数量
  changNumber(isAdd, cartItem) {
    var tempList = [];
    for (var i = 0; i < cartList.length; i++) {
      if (cartList[i]["_id"] == cartItem["_id"] &&
          cartList[i]["selectedAttr"] == cartItem["selectedAttr"]) {
        if (isAdd) {
          cartList[i]["count"]++;
        } else {
          if (cartList[i]["count"] > 1) {
            cartList[i]["count"]--;
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
      if (cartList[i]["_id"] == cartItem["_id"] &&
          cartList[i]["selectedAttr"] == cartItem["selectedAttr"]) {
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
      if (!cartList[i]["checked"]) {
        isCheckedAll = false;
      } else {
        int price = cartList[i]["price"];
        int count = cartList[i]["count"];
        tempCount = tempCount + price * count;
      }
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

  //判断用户有没有登录
  Future<bool> isLogin() async {
    return await UserServices.getUserLoginState();
  }

  //获取选中商品列表
  savecheckoutData() {
    var tempList = [];

    for (var i = 0; i < cartList.length; i++) {
      if (cartList[i]["checked"]) {
        tempList.add(cartList[i]);
      }
    }

    Storage.setData("checkoutListData", tempList);

  }

   
  

  //购买按钮点击事件
  checkout() async {
    bool loginState = await isLogin();
    if (loginState) {
      if (allPrice.value == 0) {
        Get.snackbar("提示", "请选择购买的商品");
      } else {
        savecheckoutData();
        Get.toNamed("/checkout");
      }
    } else {
      Get.toNamed("/code-login-step-one");
    }
  }

  //改变编辑状态
  changeEditState() {
    isEdit.value = !isEdit.value;
    update();
  }

  //删除购物车数据
  deleteCartData() {
      var tempList = [];
    for (var i = 0; i < cartList.length; i++) {
      if(cartList[i]["checked"] == false) {
        tempList.add(cartList[i]);
      }
    }
    saveAndUpdate(tempList);
  }


}
