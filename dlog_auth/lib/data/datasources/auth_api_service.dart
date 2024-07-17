import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dlog_auth/domain/entities/user.dart';

part 'auth_api_service.g.dart';

@RestApi(baseUrl: "https://bizaid-dlog.bizaid.com.mm/api/v1")
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @POST("/auth/login")
  Future<User> login(@Body() Map<String, dynamic> body);

  @POST("/auth/logout")
  Future<void> logout();

  @POST("/auth/register")
  Future<User> register(@Body() Map<String, dynamic> body);
}
