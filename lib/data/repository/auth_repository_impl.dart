import 'package:dio_api_call/data/model/request/login_request.dart';
import 'package:dio_api_call/data/model/response/login_response.dart';
import 'package:dio_api_call/data/remote/api/services/auth_service.dart';
import 'package:dio_api_call/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository{

  final AuthService apiService;
  AuthRepositoryImpl(this.apiService);

  @override
  Future<LoginResponse> login(LoginRequest request) async{
    return await apiService.login(request);
  }

}