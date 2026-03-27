ApiEndPoint apiEndPoint = ApiEndPoint();

class ApiEndPoint {
  static final ApiEndPoint _apiEndPoint = ApiEndPoint._i();

  factory ApiEndPoint() {
    return _apiEndPoint;
  }

  ApiEndPoint._i();

  static const String mimeJson = 'application/json';
  static const String mimeFormData = 'multipart/form-data';
  static const String mimeURLEncoded = 'application/x-www-form-urlencoded';
  static const dynamic defaultRequestForCallBack = {"screen": "mobile"};

  String baseUrl = 'https://dummyjson.com/';
  String login = 'auth/login';
}