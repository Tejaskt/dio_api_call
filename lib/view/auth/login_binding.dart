import 'package:dio_api_call/view/auth/login_controller.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings{

  @override
  void dependencies() {
    // Get.lazyPut = created only when first accessed, auto disposed when unused.
    Get.lazyPut<LoginController>(() => LoginController());
  }

}