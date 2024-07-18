import '../../domain/entities/login_request.dart';
import '../../domain/entities/login_response.dart';
import '../../domain/repositories/auth_repository.dart';
import '../models/login_request_model.dart';
import '../models/login_response_model.dart';
import '../services/auth_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthService authService;

  AuthRepositoryImpl({required this.authService});

  @override
  Future<LoginResponse> login(LoginRequest loginRequest) async {
    final response = await authService.login(LoginRequestModel(
      email: loginRequest.email,
      password: loginRequest.password,
    ));
    return LoginResponse(token: response.accessToken);
  }
}
