import 'package:dio/dio.dart';
import 'package:dlog_auth/data/datasources/auth_api_service.dart';
import 'package:dlog_auth/domain/entities/user.dart';
import 'package:dlog_auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService apiService;

  AuthRepositoryImpl(this.apiService);

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await apiService.login({'email': email, 'password': password});
      print('Login API response: $response');

      // Handle null or unexpected data in the response
      if (response != null && response is Map<String, dynamic>) {
        return User.fromJson(response as Map<String, dynamic>);
      } else {
        throw Exception('Login failed: Invalid response data');
      }
    } on DioException catch (e) {
      print('Login API error: ${e.response?.data}');
      throw Exception('Login failed: ${e.message}');
    } catch (e) {
      print('Login API error: $e');
      throw Exception('Login failed');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await apiService.logout();
    } on DioException catch (e) {
      print('Logout API error: ${e.response?.data}');
      throw Exception('Logout failed: ${e.message}');
    } catch (e) {
      print('Logout API error: $e');
      throw Exception('Logout failed');
    }
  }

  @override
  Future<User> register(String email, String password) async {
    try {
      final response = await apiService.register({'email': email, 'password': password});
      print('Register API response: $response');

      // Handle null or unexpected data in the response
      if (response != null && response is Map<String, dynamic>) {
        return User.fromJson(response as Map<String, dynamic>);
      } else {
        throw Exception('Registration failed: Invalid response data');
      }
    } on DioException catch (e) {
      print('Register API error: ${e.response?.data}');
      throw Exception('Registration failed: ${e.message}');
    } catch (e) {
      print('Register API error: $e');
      throw Exception('Registration failed');
    }
  }
}
