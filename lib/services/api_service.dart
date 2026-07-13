import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../core/constants/api_endpoints.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  late Dio _dio;
  final _storage = const FlutterSecureStorage();

  void init() {
    _dio = Dio(BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Accept': 'application/json',
      },
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.read(key: 'access_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (e, handler) async {
        if (e.response?.statusCode == 401) {
          final refreshToken = await _storage.read(key: 'refresh_token');
          if (refreshToken != null) {
            try {
              final response = await _dio.post(
                '${ApiEndpoints.baseUrl}${ApiEndpoints.refresh}',
                data: {'refresh_token': refreshToken},
              );
              if (response.statusCode == 200) {
                final newToken = response.data['access_token'];
                await _storage.write(key: 'access_token', value: newToken);
                e.requestOptions.headers['Authorization'] = 'Bearer $newToken';
                final retryResponse = await _dio.request(
                  e.requestOptions.path,
                  options: Options(
                    method: e.requestOptions.method,
                    headers: e.requestOptions.headers,
                  ),
                  data: e.requestOptions.data,
                );
                return handler.resolve(retryResponse);
              }
            } catch (_) {}
          }
        }
        return handler.next(e);
      },
    ));
  }

  Future<Response> get(String path, {Map<String, dynamic>? query}) async {
    return _dio.get(path, queryParameters: query);
  }

  Future<Response> post(String path, {dynamic data, bool isFormUrlEncoded = false}) async {
    final options = Options(
      headers: isFormUrlEncoded 
          ? {'Content-Type': 'application/x-www-form-urlencoded'}
          : {'Content-Type': 'application/json'},
    );
    
    if (isFormUrlEncoded && data is Map<String, dynamic>) {
      // Convert map to form data
      final formData = FormData.fromMap(data);
      return _dio.post(path, data: formData, options: options);
    }
    
    return _dio.post(path, data: data, options: options);
  }

  Future<Response> put(String path, {dynamic data}) async {
    return _dio.put(path, data: data);
  }

  Future<Response> delete(String path) async {
    return _dio.delete(path);
  }
}