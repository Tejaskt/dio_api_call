import 'package:dio/dio.dart';
import '../../../../data/model/response/login_response.dart';
import '../../../../data/remote/api/api_end_point.dart';
import '../../../../core/error/app_exception.dart';
import '../../../model/request/login_request.dart';

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

