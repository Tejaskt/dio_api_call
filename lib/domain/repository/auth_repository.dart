import 'package:dio_api_call/data/model/request/login_request.dart';
import 'package:dio_api_call/data/model/response/login_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginRequest request);
}