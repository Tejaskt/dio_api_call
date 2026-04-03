import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/error/app_exception.dart';
import '../api_end_point.dart';
import '../model/common/firebase_user.dart';
import '../model/request/login_request.dart';
import '../model/response/login_response.dart';

class AuthService {
  final Dio dio;

  AuthService(this.dio);

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
        throw AppException('Google Sign-in was cancelled');
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
      throw AppException('Google Sign-in Failed. please try again');
    }
  }

  // --- SIGN OUT (covers all providers) ---
  Future<void> signOut() async {
    await Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
      // Facebook auto-clears on FirebaseAuth.signOut()
    ]);
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
      case 'account-exists-with-different-credential':
        return 'An account already exists with a different sign-in method for this email.';
      case 'invalid-credential':
        return 'The sign-in credential is invalid or has expired.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }
}
