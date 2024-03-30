import 'package:get/get.dart';
import '../../../services/ityingFonts.dart';
import '../../../services/userServices.dart';

class UserController extends GetxController {
  //TODO: Implement UserController

  var isLogin = false.obs;
  var userList = [].obs;

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
    getUserInfo();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


  getUserInfo() async{

    var tempLoginState = await UserServices.getUserLoginState();
    isLogin.value = tempLoginState;

    var tempList = await UserServices.getUserInfo();
    if (tempList!=[]) {
      userList.value = tempList as List;
    }

  }


  loginOut(){
    UserServices.loginOut();
    isLogin.value = false;
    userList.value = [];
    update();
  }

}
