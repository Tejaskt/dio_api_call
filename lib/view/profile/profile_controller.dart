import 'package:get/get.dart';

import '../../api/model/response/login_response.dart';
import '../../core/routes/route_name.dart';
import '../../core/storage/secure_storage.dart';

class ProfileController extends GetxController {

  // Rx<T> wraps any nullable type reactively
  final user = Rxn<LoginResponse>(); // Rxn = nullable Rx — starts as null
  final isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadUser();
  }

  Future<void> loadUser() async {
    isLoading.value = true;
    user.value = await SecureStorage.getUser();
    isLoading.value = false;
  }

  Future<void> logout() async {
    await SecureStorage.clear();
    // offAllNamed clears the entire navigation stack —
    // the user cannot press back to return to the profile
    Get.offAllNamed(RouteName.login);
  }
}