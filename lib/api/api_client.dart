import 'package:dio/dio.dart';
import 'package:dio_api_call/core/routes/route_name.dart';
import 'package:get/get.dart';
import 'api_end_point.dart';
import '../../../core/storage/secure_storage.dart';

APIClient apiClient = APIClient();

class APIClient {
  static final APIClient _instance = APIClient._i();

  factory APIClient() => _instance;

  late Dio _dio;
  Dio get dio => _dio;

  APIClient._i() {
    _dio = Dio(
      BaseOptions(
        baseUrl: apiEndPoint.baseUrl,
        connectTimeout: const Duration(minutes: 5),
        receiveTimeout: const Duration(minutes: 3),
        contentType: ApiEndPoint.mimeJson,
      ),
    );

    ///  avoid :  Adding interceptor inside every API call || Creating multiple Dio instances
    _dio.interceptors.add(_authInterceptor());
    _dio.interceptors.add(_logInterceptor());
  }

  // --- INTERCEPTORS --- \\

  Interceptor _logInterceptor() {
    return LogInterceptor(
      responseBody: true,
      request: true,
      responseHeader: true,
      requestHeader: true,
      requestBody: true,
      error: true,
    );
  }

  Interceptor _authInterceptor() {
    return InterceptorsWrapper(
      onRequest: (request, handler) async {
        final token = await SecureStorage.getToken();

        if (token != null) {
          request.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(request);
      },

      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401) {
          await SecureStorage.clear();
          // Redirect to login and clear the entire navigation stack
          Get.offAllNamed(RouteName.login);
        }
        return handler.next(e);
      },
    );
  }
}
