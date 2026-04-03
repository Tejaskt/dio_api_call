import 'package:dio_api_call/api/model/common/firebase_user.dart';
import 'package:get/get.dart';

import '../../api/model/response/login_response.dart';
import '../../api/services/auth_service.dart';
import '../../core/routes/route_name.dart';
import '../../core/storage/secure_storage.dart';

class ProfileController extends GetxController {

  // Rx<T> wraps any nullable type reactively
  final user = Rxn<LoginResponse>(); // Rxn = nullable Rx — starts as null
  final isLoading = true.obs;
  final firebaseUser = Rxn<FirebaseUser>();

  @override
  void onInit() {
    super.onInit();
    loadUser();
  }

  Future<void> loadUser() async {
    isLoading.value = true;
    user.value = await SecureStorage.getUser();
    firebaseUser.value = await SecureStorage.getFirebaseUser();
    isLoading.value = false;
  }

  Future<void> logout() async {
    // Sign out from Firebase/Google/Facebook if the user logged in that way
    final firebaseUser = await SecureStorage.getFirebaseUser();
    if (firebaseUser != null) {
      // AuthService.signOut() handles Firebase + Google + Facebook
      // Get it via Get.find since AuthService is already registered
      await Get.find<AuthService>().signOut();
    }

    // Clear all local storage regardless of login method
    await SecureStorage.clear();

    // offAllNamed clears the entire navigation stack —
    // the user cannot press back to return to the profile
    Get.offAllNamed(RouteName.login);
  }
}