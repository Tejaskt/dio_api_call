import 'package:dio_api_call/api/api_client.dart';
import 'package:dio_api_call/view/auth/login_controller.dart';
import 'package:get/get.dart';
import '../../api/services/auth_service.dart';

class LoginBinding extends Bindings{

  @override
  void dependencies() {
    // register AuthService here.
    // Get.lazyPut = created only when first accessed, auto disposed when unused.
    Get.lazyPut<AuthService>(() => AuthService(apiClient.dio),);
    Get.lazyPut<LoginController>(() => LoginController(Get.find<AuthService>()));
  }

}
