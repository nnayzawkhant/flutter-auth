import 'package:dlog_auth/domain/entities/user.dart';
import 'package:dlog_auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  Future<User> execute(String email, String password) async {
    try {
      final user = await _authRepository.login(email, password);
      print('usercase: $user');
      return user; // Ensure the user object is returned correctly
    } catch (e) {
      print('LoginUseCase error: $e');
      throw e; // Handle or rethrow any errors from the repository
    }
  }
}
