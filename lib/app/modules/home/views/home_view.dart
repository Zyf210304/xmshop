import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:xmshop/app/services/screenAdapter.dart';

import '../controllers/home_controller.dart';
import '../../../services/screenAdapter.dart';
import '../../../services/keepAliveWrapper.dart';
import '../../../services/ityingFonts.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
        child: Scaffold( 
      body: Stack(
        children: [
          Positioned(
            top: -46,
            left: 0,
            right: 0,
            bottom: 0,
            child: ListView.builder(
            
            controller: controller.scrollController,  //绑定后才能监听
              itemCount: 20,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                    width: ScreenAdapter.width(1080),
                    height: ScreenAdapter.height(682),
                    child: Image.network(
                        "https://www.itying.com/images/focus/focus02.png", fit: BoxFit.cover,),
                  );
                } else {
                  return ListTile(title: Text("$index  ----- 列表"));
                }
              }),),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Obx(() => AppBar(
              leading: controller.flag.value ? const Text("") : Icon(
                ItyingFonts.xiaomi,
                color:  controller.flag.value == true ? Colors.black45 :  Colors.white
              ),
              leadingWidth: controller.flag.value ? 0 : ScreenAdapter.width(140),
              title: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: controller.flag.value ? ScreenAdapter.width(800) : ScreenAdapter.width(620),
                height: ScreenAdapter.height(96),
                decoration: BoxDecoration( 
                  color: const Color.fromARGB(230, 202, 190, 190),
                  borderRadius: BorderRadius.circular(30),
                ),
                child:  Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:  [ 
                  const Padding(padding: EdgeInsets.fromLTRB(10, 0, 4, 0), child: Icon(Icons.search, color:  Colors.black45,),),
                  Text("手机" , style: TextStyle(color: Colors.black45, fontSize:  ScreenAdapter.fontSize(32)), ),
                  
                ]),
              ),
              centerTitle: true,
              backgroundColor: controller.flag.value == true ? Colors.white :  Colors.transparent,
              elevation: 0,
              actions: [
                IconButton(onPressed: () {}, icon:  Icon(Icons.qr_code, color: controller.flag.value == true ? Colors.black45 :  Colors.white,)),
                IconButton(onPressed: () {}, icon:  Icon(Icons.message, color: controller.flag.value == true ? Colors.black45 :  Colors.white,))
              ],
            )),
          )
        ],
      ),
    ));
  }
}
