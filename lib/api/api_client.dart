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

  /*

  Future<Dio> getApiClient({String? content = ApiEndPoint.mimeJson}) async {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: apiEndPoint.baseUrl,
        connectTimeout: const Duration(minutes: 5),
        receiveTimeout: const Duration(minutes: 3),
        contentType: content,
      ),
    );
    dio.interceptors.add(
      // this will help to print all the data into log
      // should be added on last otherwise modification of other interceptors will not be logged
      LogInterceptor(
        responseBody: true,
        request: true,
        responseHeader: true,
        requestHeader: true,
        requestBody: true,
        error: true,
      ),
    );
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (request, handler) async {
          ///  this will act as middle ware so do the required changes before requesting to the server

          // if (!isAuth) {
          //   var token = await LoginManager.shared.getAuthToken();
          //   if (token != null && token != '') {
          //     request.headers['Authorization'] = 'Bearer $token';
          //   }
          // }
          return handler.next(request);
        },
        onResponse: (response, handler) async {
          // if (response.data != null) {
          //   if (response.statusCode == ResponseCode.alreadyExist.value) {
          //     response.data = {
          //       "code": response.data['code'],
          //       "message": response.data['message'],
          //       "status": response.data['status'],
          //       "data": response.data["data"],
          //     };
          //
          //     return handler.next(response);
          //   }
          //   var commonResponse = CommonResponse.fromJson(response.data);
          //
          //   var decryptedData = await Encryption.doubleDecryption(
          //     commonResponse.data,
          //   );
          //   printLong("Decrypted Response Detail $decryptedData");
          //
          //   // Rebuild response.data while preserving the original structure
          //   response.data = {
          //     "code": commonResponse.code,
          //     "message": commonResponse.message,
          //     "status": commonResponse.status,
          //     "data": decryptedData,
          //   };
          // }
          return handler.next(response);
        },
        onError: (DioException e, handler) {},
      ),
    );

    return dio;
  }

  Future<ApiResponse<T>> request<T>({
    required String url,
    required HttpMethod method,
    Map<String, dynamic>? queryParams,
    dynamic data,
    String contentType = Headers.jsonContentType,
    required T Function(Map<String, dynamic>) fromJson,
    bool isAuth = false,
  }) async {
    try {
      APIClient apiClient = APIClient();
      Dio dio = await apiClient.getApiClient(content: contentType);
      late Response response;

      switch (method) {
        case HttpMethod.get:
          response = await dio.get(url, queryParameters: queryParams);
          break;
        case HttpMethod.post:
          response = await dio.post(
            url,
            data: data,
            queryParameters: queryParams,
          );
          break;
        case HttpMethod.put:
          response = await dio.put(url, data: data);
          break;
        case HttpMethod.patch:
          response = await dio.patch(url, data: data);
          break;
        case HttpMethod.delete:
          response = await dio.delete(url, data: data);
          break;
      }
      return ApiResponse<T>.fromJson(response.data, fromJson);
    } on DioException catch (e) {
      return ApiResponse(message: e.message, code: e.hashCode); // ! changed.
    }
  }
}

enum HttpMethod { get, post, put, delete, patch }

enum ResponseCode {
  success(200),
  created(201),
  deleted(204),
  inActiveUser(300),
  badRequest(400),
  notVerified(426),
  unauthorizedRequest(401),
  forbidden(403),
  errorNotFound(404),
  connectionTimeout(408),
  alreadyExist(208),
  expired(410),
  recognitionFailed(422),
  serviceUnavailable(503),
  serverError(500);

  const ResponseCode(this.value);

  final int value;
}

class ApiResponse<T> {
  T? data;
  String? message;
  bool? status;
  int? code;

  ApiResponse({this.data, this.message, this.status, this.code});

  factory ApiResponse.fromJson(
    Map<String, dynamic>? json,
    T Function(Map<String, dynamic>) create,
  ) {
    return ApiResponse<T>(
      data: json?["data"] != null ? create(json?["data"]) : null,
      message: json?["message"],
      status: json?["status"],
      code: json?["code"],
    );
  }
}
*/
