import 'package:dlog_auth/domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<User?> login(String email, String password);
  Future<User?> register(String email, String password);
  Future<void> logout();
}
