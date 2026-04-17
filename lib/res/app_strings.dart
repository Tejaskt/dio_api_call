class AppStrings {
  AppStrings._();

  static const String appName = 'Recipify';
  static const String appMoto = 'Discover Delicious Recipes';

  // Login Screen
  static const String login = 'Log In';
  static const String or = 'OR';
  static const String welcomeString = 'Welcome Back!';
  static const String continueWithGoogle = 'Continue with Google';
  static const String continueWithFacebook = 'Continue with Facebook';

  // Profile Screen
  static const String profile = 'Profile';
  static const String userNotFound = 'User not found';
  static const String email = 'Email';
  static const String gender = 'Gender';
  static const String userId = 'User ID';
  static const String logout = 'Logout';

  // Home Screen
  static const String home = 'Home';
  static const String retry = 'Retry';

  // Recipe Details Screen
  static const String ingredients = 'Ingredients';
  static const String instructions = 'Instructions';

  /// HINT
  static const String enterUsername = 'Username';
  static const String enterPassword = 'Password';

  /// error messages
 static const String loginFieldEmpty  = 'Please enter username and password';
 static const String googleSignInCancelled = 'Google Sign-in was cancelled';
 static const String facebookSignInCancelled = 'Facebook sign-in was cancelled';
 static const String googleSignInFailed = 'Google Sign-in Failed. please try again';
 static const String facebookSignInFailed = 'Facebook sign-in failed. Please try again';
 static const String signOutError = 'Sign-out Error';


 /// facebook error messages
static const String codeAccountDifferentCredential = 'account-exists-with-different-credential';
static const String msgAccountDifferentCredential = 'An account already exists with a different sign-in method for this email.';
static const String codeInvalidCredential = 'invalid-credential';
static const String msgInvalidCredential = 'The sign-in credential is invalid or has expired.';
static const String codeUserDisabled = 'user-disabled';
static const String msgUserDisabled = 'This account has been disabled.';
static const String codeNetworkRequestFailed = 'network-request-failed';
static const String msgNetworkRequestFailed = 'Network error. Please check your connection.';
static const String defaultErrorMsg = 'Authentication failed. Please try again.';
}
