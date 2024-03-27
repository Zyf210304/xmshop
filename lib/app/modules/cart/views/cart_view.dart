import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../services/screenAdapter.dart';
import '../controllers/cart_controller.dart';
import './cart_item_view.dart';

class CartView extends GetView {

  //注意 CartView再多个地方调用 需要手动获取Controller

  @override
  final CartController controller = Get.put(CartController());

   CartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text('购物车'),
          centerTitle: true,
        ),
        body: GetBuilder<CartController>(
          initState: (state){
            controller.getCartListData();
          },
          init: controller,
          builder: (controller){
          return  Container(
          color: const Color.fromRGBO(246, 246, 246, 1),
          child: controller.cartList.isEmpty ? const Center(child: Text("购物车还是空的呀"),) : Stack(
            children: [
              ListView.builder(
                  padding: EdgeInsets.only(bottom: ScreenAdapter.height(200)),
                  itemCount: controller.cartList.length,
                  itemBuilder: (context, index) {
                    Map cartItem = controller.cartList[index];
                    return CartItemView(cartItem);
                  }),
              Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.only(right: ScreenAdapter.width(20)),
                    width: double.infinity,
                    height: ScreenAdapter.height(190),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          top: BorderSide(
                              color: Colors.black12,
                              width: ScreenAdapter.height(2))),
                    ),
                    child: Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Checkbox(
                                value: controller.isAllChoose.value,
                                activeColor: Colors.red,
                                onChanged: (value) {
                                  
                                  controller.checkedAll(value);

                                }),
                            const Text("全选")
                          ],
                        ),
                        Row(
                          children: [
                            const Text("合计: "),
                            Text(
                              "${controller.allPrice}",
                              style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(58),
                                  color: Colors.red),
                            ),
                            SizedBox(
                              width: ScreenAdapter.width(20),
                            ),
                            ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                ),
                                onPressed: () {},
                                child: Text("结算"))
                          ],
                          )   
                      ],
                    ),)
                  ))
            ],
          ),
        );
        })
        

        
      
        );
  }
}
