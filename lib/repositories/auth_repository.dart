import 'dart:convert';
import 'package:dio/dio.dart';
import '../models/user.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';
import '../core/constants/api_endpoints.dart';

class AuthRepository {
  final ApiService _api;
  final StorageService _storage;

  AuthRepository() 
      : _api = ApiService(),
        _storage = StorageService() {
    _api.init();
  }

  Future<User?> login(String email, String password) async {
    try {
      print('📤 AuthRepository.login called');
      print('🌐 URL: ${ApiEndpoints.baseUrl}${ApiEndpoints.login}');
      print('📧 Email/Username: $email');
      
      final response = await _api.post(
        ApiEndpoints.login,
        data: {
          'username': email,
          'password': password,
        },
        isFormUrlEncoded: true,
      );
      
      print('📥 Response status: ${response.statusCode}');
      print('📥 Response data: ${response.data}');
      
      if (response.statusCode == 200) {
        final data = response.data;
        await _storage.setToken(data['access_token']);
        await _storage.setRefreshToken(data['refresh_token']);
        return await getCurrentUser();
      }
      return null;
    } catch (e) {
      print('❌ AuthRepository.login exception: $e');
      if (e is DioException) {
        print('Dio error type: ${e.type}');
        print('Dio error message: ${e.message}');
        if (e.response != null) {
          print('Response status: ${e.response?.statusCode}');
          print('Response data: ${e.response?.data}');
        }
      }
      return null;
    }
  }

  Future<User?> register(String email, String username, String password, String fullName) async {
    try {
      print('📤 AuthRepository.register called');
      print('📧 Email: $email');
      print('👤 Username: $username');
      
      final response = await _api.post(
        ApiEndpoints.register,
        data: {
          'email': email,
          'username': username,
          'password': password,
          'full_name': fullName,
        },
      );
      
      print('📥 Response status: ${response.statusCode}');
      print('📥 Response data: ${response.data}');
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        await _storage.setToken(data['access_token']);
        await _storage.setRefreshToken(data['refresh_token']);
        return await getCurrentUser();
      }
      print('❌ Response status not OK: ${response.statusCode}');
      return null;
    } catch (e) {
      print('❌ AuthRepository.register exception: $e');
      if (e is DioException) {
        print('Dio error type: ${e.type}');
        print('Dio error message: ${e.message}');
        if (e.response != null) {
          print('Response status: ${e.response?.statusCode}');
          print('Response data: ${e.response?.data}');
        }
      }
      return null;
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      final token = await _storage.getToken();
      if (token == null) return null;
      
      final response = await _api.get(ApiEndpoints.me);
      if (response.statusCode == 200) {
        return User.fromJson(response.data);
      }
      return null;
    } catch (e) {
      print('❌ getCurrentUser error: $e');
      return null;
    }
  }

  Future<void> logout() async {
    try {
      await _api.post(ApiEndpoints.logout);
    } catch (e) {
      print('❌ Logout error: $e');
    } finally {
      await _storage.deleteToken();
      await _storage.deleteRefreshToken();
    }
  }
}