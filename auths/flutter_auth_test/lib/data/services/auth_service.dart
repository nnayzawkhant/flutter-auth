import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';

part 'auth_service.g.dart';

@RestApi(baseUrl: "https://bizaid-dlog.bizaid.com.mm/api/v1/auth")
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @POST("/login")
  Future<LoginResponseModel> login(@Body() LoginRequestModel loginRequest);
}
