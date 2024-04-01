import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/services/httpsClient.dart';

import '../../../../services/screenAdapter.dart';
import '../controllers/address_list_controller.dart';
import '../../../../models/address_model.dart';

class AddressListView extends GetView<AddressListController> {
  const AddressListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 245, 243, 239),
      appBar: AppBar(
        title: const Text('收货地址'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom:
                  ScreenAdapter.getbottomBarHeight() + ScreenAdapter.width(190),
              child: Container(
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white),
                  child: Obx(
                    () => ListView.builder(
                      itemCount: controller.addressList.length,
                      itemBuilder: (BuildContext context, int index) {
                        AddressItemModel model = controller.addressList[index];
                        return Column(
                          children: [
                            
                            ListTile(
                              leading: model.defaultAddress == 1 ? const Icon(Icons.check, color: Colors.red,) : null,
                              title: InkWell(
                                onLongPress: () {
                                  if (index != 0) {
                                    Get.defaultDialog(
                                      title: "提示",
                                      middleText: "您确定要删除该地址吗？",
                                      confirm: ElevatedButton(onPressed: (){
                                        controller.deleteAddress(model.sId);
                                        Get.back();
                                      }, child: const Text("确认")),
                                      cancel: ElevatedButton(onPressed: (){Get.back();}, child: const Text("取消")),
                                    );
                                  }
                                },
                                onTap: () {
                                  controller.changeDefalueAddress(model.sId);
                                },
                                child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(model.phone!),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    model.address!,
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(model.name!)
                                ],
                              ),
                              ),
                              trailing: IconButton(
                                onPressed: (){
                                  controller.getNeedChangeAddress(model);
                                  Get.toNamed("/address-edit");
                                },
                                icon:const Icon(
                                Icons.edit,
                                color: Colors.blue,
                              )),
                            ),
                            const Divider(
                              indent: 10,
                              endIndent: 10,
                            ),
                          ],
                        );
                      },
                    ),
                  ))),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  alignment: Alignment.center,
                  width: double.infinity,
                  height: ScreenAdapter.width(190),
                  child: Center(
                      child: InkWell(
                    onTap: () {
                      Get.toNamed("/address-add");
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: ScreenAdapter.width(900),
                      height: ScreenAdapter.height(140),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.red),
                      child: const Text(
                        "添加收获地址",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  )),
                ),
                Container(
                  height: ScreenAdapter.getbottomBarHeight(),
                  color: Colors.white,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
