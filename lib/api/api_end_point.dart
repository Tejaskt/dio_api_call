ApiEndPoint apiEndPoint = ApiEndPoint();

class ApiEndPoint {
  static final ApiEndPoint _apiEndPoint = ApiEndPoint._i();

  factory ApiEndPoint() {
    return _apiEndPoint;
  }

  ApiEndPoint._i();

  static const String mimeJson = 'application/json';
  static const String mimeFormD0ata = 'multipart/form-data';
  static const String mimeURLEncoded = 'application/x-www-form-urlencoded';
  static const dynamic defaultRequestForCallBack = {"screen": "mobile"};

  // BASE URL
  final String baseUrl = 'https://dummyjson.com/';
  // AUTH
  final String login = 'auth/login';
  // RECIPES
  final String getRecipe = 'recipes';


}