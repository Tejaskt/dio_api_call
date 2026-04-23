import 'package:dio_api_call/api/api_client.dart';
import 'package:dio_api_call/res/app_strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/error/app_exception.dart';
import '../api_end_point.dart';
import '../model/common/firebase_user.dart';
import '../model/request/login_request.dart';
import '../model/response/login_response.dart';

class AuthService {
  static var shared = AuthService();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // REFACTORED LOGIN
  Future<ApiResponse<LoginResponse>> login({
    required LoginRequest request,
  }) {
    return client.request<LoginResponse>(
      url: apiEndPoint.login,
      method: HttpMethod.post,
      data: request.toJson(),
      fromJson: (data) => LoginResponse.fromJson(data),
      isAuth: true,
    );
  }

  // --- GOOGLE SIGN-IN ---
  Future<FirebaseUser> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleAccount =
      await _googleSignIn.signIn();

      if (googleAccount == null) {
        throw AppException(AppStrings.googleSignInCancelled);
      }

      final GoogleSignInAuthentication googleAuth =
      await googleAccount.authentication;

      final OAuthCredential credential =
      GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
      await _firebaseAuth.signInWithCredential(credential);

      return _mapFirebaseUser(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      throw AppException(_firebaseErrorMessage(e.code));
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException(AppStrings.googleSignInFailed);
    }
  }

  // --- FACEBOOK SIGN-IN ---
  Future<FirebaseUser> signInWithFacebook() async {
    try {
      final LoginResult loginResult =
      await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      if (loginResult.status == LoginStatus.cancelled) {
        throw AppException(AppStrings.facebookSignInCancelled);
      }

      if (loginResult.status == LoginStatus.failed) {
        throw AppException(
            '${AppStrings.facebookSignInFailed} ${loginResult.message}');
      }

      final OAuthCredential credential =
      FacebookAuthProvider.credential(
        loginResult.accessToken!.tokenString,
      );

      final UserCredential userCredential =
      await _firebaseAuth.signInWithCredential(credential);

      return _mapFirebaseUser(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      throw AppException(_firebaseErrorMessage(e.code));
    } catch (e) {
      if (e is AppException) rethrow;
      throw AppException(AppStrings.facebookSignInFailed);
    }
  }

  // --- SIGN OUT ---
  Future<void> signOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      throw AppException('${AppStrings.signOutError} : $e');
    }
  }

  // --- HELPERS ---

  FirebaseUser _mapFirebaseUser(User user) {
    return FirebaseUser(
      uid: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
      image: user.photoURL ?? '',
      provider: user.providerData.first.providerId,
    );
  }

  String _firebaseErrorMessage(String code) {
    switch (code) {
      case AppStrings.codeAccountDifferentCredential:
        return AppStrings.msgAccountDifferentCredential;

      case AppStrings.codeInvalidCredential:
        return AppStrings.msgInvalidCredential;

      case AppStrings.codeUserDisabled:
        return AppStrings.msgUserDisabled;

      case AppStrings.codeNetworkRequestFailed:
        return AppStrings.msgNetworkRequestFailed;

      default:
        return AppStrings.defaultErrorMsg;
    }
  }
}