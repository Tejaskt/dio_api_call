import 'package:dio/dio.dart';
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

  final Dio dio;
  AuthService({Dio? dio}) : dio = dio ?? APIClient().dio;

  // Firebase instance - created once, used across all auth methods
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // --- Dummy json auth api login --- \\
  Future<LoginResponse> login(LoginRequest request) async {
    try {
      final response = await dio.post(
        apiEndPoint.login,
        data: request.toJson(),
      );
      return LoginResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  // --- Google Sign-in --- \\
  Future<FirebaseUser> signInWithGoogle() async {
    try {
      // Opens the google account picker dialog
      final GoogleSignInAccount? googleAccount = await _googleSignIn.signIn();

      // user cancelled the dialog
      if (googleAccount == null) {
        throw AppException(AppStrings.googleSignInCancelled);
      }

      // Get the auth tokens from google
      final GoogleSignInAuthentication googleAuth =
      await googleAccount.authentication;

      // Build a firebase credential from those tokens
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign into firebase with that credential
      final UserCredential userCredential = await _firebaseAuth
          .signInWithCredential(credential);

      return _mapFirebaseUser(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      throw AppException(_firebaseErrorMessage(e.code));
    } catch (e) {
      // re-throw AppException (like the cancelled one above) as-it
      if (e is AppException) rethrow;
      throw AppException(AppStrings.googleSignInFailed);
    }
  }

  // --- FACEBOOK SIGN-IN ---
  Future<FirebaseUser> signInWithFacebook() async {
    try {
      // Opens the Facebook login dialog
      final LoginResult loginResult = await FacebookAuth.instance.login(
        permissions: ['email', 'public_profile'],
      );

      // User cancelled or it failed
      if (loginResult.status == LoginStatus.cancelled) {
        throw AppException(AppStrings.facebookSignInCancelled);
      }
      if (loginResult.status == LoginStatus.failed) {
        throw AppException('${AppStrings.facebookSignInFailed} ${loginResult.message}');
      }

      // Build a Firebase credential from the Facebook token
      final OAuthCredential credential = FacebookAuthProvider.credential(
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

  // --- SIGN OUT (covers all providers) ---
  Future<void> signOut() async {
    try {
      await Future.wait([

        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
        // Facebook auto-clears on FirebaseAuth.signOut()
      ]);
    } catch (e) {
      throw AppException('${AppStrings.signOutError} :$e');
    }
  }

  // --- HELPERS --- \\

  // Maps Firebase's User object to your own domain model
  // so the rest of your app never imports firebase_auth directly
  FirebaseUser _mapFirebaseUser(User user) {
    return FirebaseUser(
      uid: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
      image: user.photoURL ?? '',
      provider: user.providerData.first.providerId,
    );
  }

  // messages for Firebase error codes
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

/* facebook login user response
User(
displayName: Tejas Kanazriya,
email: tejaskanjariya82547@gmail.com,
isEmailVerified: false,
isAnonymous: false,
metadata:
      UserMetadata(
          creationTime: 2026-04-03 06:05:45.600Z,
          lastSignInTime: 2026-04-03 06:24:00.703Z),
          phoneNumber: null,
          photoURL: https://graph.facebook.com/2401364983704158/picture,
          providerData,
        [UserInfo(
          displayName: Tejas Kanazriya,
          email: tejaskanjariya82547@gmail.com,
          phoneNumber: null,
          photoURL: https://graph.facebook.com/2401364983704158/picture,
          providerId: facebook.com,
          uid: 2401364983704158)],
    refreshToken: null, tenantId: null, uid: hTm7M95HSMRBnTjri33wMn0b1kZ2)

 */
