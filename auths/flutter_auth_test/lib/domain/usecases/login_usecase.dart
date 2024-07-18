import '../entities/login_request.dart';
import '../entities/login_response.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  Future<LoginResponse> call(LoginRequest loginRequest) {
    return authRepository.login(loginRequest);
  }
}
