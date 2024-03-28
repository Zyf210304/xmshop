import 'package:get/get.dart';

import '../controllers/on_setp_login_controller.dart';

class OnSetpLoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnSetpLoginController>(
      () => OnSetpLoginController(),
    );
  }
}
