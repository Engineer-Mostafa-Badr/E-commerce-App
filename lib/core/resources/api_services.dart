import 'package:ecommerce_app/core/resources/sensitive_data.dart';
import 'package:dio/dio.dart';

class ApiServices {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: SensitiveData.baseUrl,
      headers: {"apikey": SensitiveData.supabaseAnonKey},
    ),
  );

  Future<Response> getData(String path) async {
    return await _dio.get(path);
  }

  Future<Response> postData(String path, Map<String, dynamic> data) async {
    return await _dio.post(path, data: data);
  }

  Future<Response> patchData(String path, Map<String, dynamic> data) async {
    return await _dio.patch(path, data: data);
  }

  Future<Response> deleteData(String path) async {
    return await _dio.delete(path);
  }
}
