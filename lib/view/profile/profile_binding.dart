import 'package:dio_api_call/view/profile/profile_controller.dart';
import 'package:get/get.dart';

import '../../api/api_client.dart';
import '../../api/services/auth_service.dart';

class ProfileBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(() => ProfileController());

  }

}