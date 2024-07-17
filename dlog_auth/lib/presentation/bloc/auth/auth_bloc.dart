import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dlog_auth/domain/usecases/login_use_case.dart';
import 'package:dlog_auth/domain/usecases/logout_use_case.dart';
import 'package:dlog_auth/presentation/bloc/auth/auth_event.dart';
import 'package:dlog_auth/presentation/bloc/auth/auth_state.dart';
import 'package:dlog_auth/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthBloc(this._loginUseCase, this._logoutUseCase) : super(AuthInitial()) {
    on<LoginEvent>(_onLoginEvent);
    on<LogoutEvent>(_onLogoutEvent);
  }

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final User user = await _loginUseCase.execute(event.email, event.password);
      if (user != null) {
        print('Logged in user: ${user.email}');
        // Save user to local storage
        await _saveUserToLocalStorage(user);
        emit(AuthAuthenticated(user));
      } else {
        throw Exception('User object returned from login is null');
      }
    } catch (e) {
      emit(AuthError('Login failed: $e'));
    }
  }

  Future<void> _onLogoutEvent(LogoutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      // Clear user data from local storage
      await _clearUserFromLocalStorage();
      await _logoutUseCase.execute();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError('Logout failed: $e'));
    }
  }

  Future<void> _saveUserToLocalStorage(User user) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('user', jsonEncode(user.toJson()));
  }

  Future<void> _clearUserFromLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('user');
  }

  Future<User?> _getUserFromLocalStorage() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString('user');
    if (userData != null) {
      return User.fromJson(jsonDecode(userData));
    }
    return null;
  }
}
