import 'package:dio/dio.dart';
import '../../../../core/error/app_exception.dart';
import '../api_end_point.dart';
import '../model/request/login_request.dart';
import '../model/response/login_response.dart';

class AuthService {

  final Dio dio;
  AuthService(this.dio);

  Future<LoginResponse> login(LoginRequest request) async{
    try{
      final response = await dio.post(
        apiEndPoint.login,
        data: request.toJson(),
      );
      return LoginResponse.fromJson(response.data);
    } on DioException catch(e){
      throw ErrorHandler.handle(e);
    }
  }
}

