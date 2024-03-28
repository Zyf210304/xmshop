import 'package:get/get.dart';
import '../../../services/ityingFonts.dart';

class UserController extends GetxController {
  //TODO: Implement UserController

  final count = 0.obs;

  var servicesTitleArr = [
    "一键安装",
    "一键退换",
    "一键维修",
    "服务进度",
    "小米之家",
    "客服中心",
    "依旧换新",
    "手机电池"
  ];
  var servicesIcon = [
    ItyingFonts.anzhuang,
    ItyingFonts.anzhuangyewu,
    ItyingFonts.weixiu,
    ItyingFonts.weixiufuwu,
    ItyingFonts.xiaomi,
    ItyingFonts.kefu,
    ItyingFonts.tuihuanhuo,
    ItyingFonts.tuihuanhuo
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
