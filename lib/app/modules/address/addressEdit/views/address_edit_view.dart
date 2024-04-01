import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/address_edit_controller.dart';
import 'package:city_pickers/city_pickers.dart';

import '../../../../services/screenAdapter.dart';


class AddressEditView extends GetView<AddressEditController> {
    Widget meessgeWidget(title, hintText,
      {keyboardType = TextInputType.text,
      isHaveDivider = true,
      needChooseTF = false,
      context = BuildContext,
      editController = TextEditingController}) {
    return Container(
        color: Colors.white,
        height: 50,
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          children: [
            Expanded(
                flex: 1,
                child: !needChooseTF
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: 80,
                              child: Text(
                                title,
                                style: const TextStyle(fontSize: 16),
                              )),
                          Expanded(
                              flex: 1,
                              child: TextField(
                                controller: editController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    hintStyle: const TextStyle(fontSize: 16),
                                    hintText: hintText,
                                    border: InputBorder.none),
                              ))
                        ],
                      )
                    : InkWell(
                        onTap: () async{
                          Result? result = await CityPickers.showCityPicker(context: context);
                          if (result != null) {
                            var address = "${result.provinceName} ${result.cityName} ${result.areaName}";
                            controller.changedArea(address);
                          }
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                                width: 80,
                                child: Text(
                                  title,
                                  style: const TextStyle(fontSize: 16),
                                )),
                            Expanded(
                                flex: 1,
                                child: Obx(() {
                                  print("----------");
                                  print(controller.area.value);
                                  return Text(
                                      controller.area.value.isEmpty
                                          ? hintText
                                          : controller.area.value,
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: controller.area.value.isEmpty
                                            ? Colors.black45
                                            : Colors.black87,
                                      ),
                                    );
                                }
                                    )
                                    )
                          ],
                        ),
                      )),
            isHaveDivider
                ? const Divider(
                    height: 1,
                    indent: 0,
                    endIndent: 0,
                  )
                : const SizedBox(
                    height: 0,
                  )
          ],
        ));
  }

  const AddressEditView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 250, 249, 246),
      appBar: AppBar(
        title: const Text('添加地址'),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          meessgeWidget("姓名", "请填写收货人姓名",
              editController: controller.nameController),
          meessgeWidget("电话", "填写收货人手机号",
              keyboardType: TextInputType.phone,
              isHaveDivider: false,
              editController: controller.phoneController),
          const SizedBox(
            height: 20,
          ),
          meessgeWidget("所在地区", "选择地区信息", needChooseTF: true, context: context),
          meessgeWidget("详细地址", "小区、楼牌号等",
              isHaveDivider: false,
              editController: controller.addreeController),
          const SizedBox(
            height: 80,
          ),
          Container(
            // color: Colors.white,
            alignment: Alignment.center,
            width: double.infinity,
            height: ScreenAdapter.width(190),
            child: Center(
                child: InkWell(
              onTap: () {
                
                //保存地址
                controller.doAddAddress();


              },
              child: Container(
                alignment: Alignment.center,
                width: ScreenAdapter.width(900),
                height: ScreenAdapter.height(140),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8), color: Colors.red),
                child: const Text(
                  "保存",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            )),
          ),
        ],
      ),
    );
  }
}
