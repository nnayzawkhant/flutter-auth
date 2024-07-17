import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:dlog_auth/data/datasources/auth_api_service.dart';
import 'package:dlog_auth/data/repositories/auth_repository_impl.dart';
import 'package:dlog_auth/domain/usecases/login_use_case.dart';
import 'package:dlog_auth/domain/usecases/logout_use_case.dart';
import 'package:dlog_auth/domain/usecases/register_use_case.dart';
import 'package:dlog_auth/presentation/bloc/auth/auth_bloc.dart';
import 'package:dlog_auth/presentation/screens/login_screen.dart';
import 'package:dlog_auth/presentation/screens/home_screen.dart';

void main() {
  final dio = Dio();
  final apiService = AuthApiService(dio);
  final authRepository = AuthRepositoryImpl(apiService);
  final loginUseCase = LoginUseCase(authRepository);
  final logoutUseCase = LogoutUseCase(authRepository);
  final registerUseCase = RegisterUseCase(authRepository);

  runApp(MyApp(
    loginUseCase: loginUseCase,
    logoutUseCase: logoutUseCase,
    registerUseCase: registerUseCase,
  ));
}

class MyApp extends StatelessWidget {
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final RegisterUseCase registerUseCase;

  MyApp({
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.registerUseCase,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DLog Auth',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/login': (context) => BlocProvider(
              create: (context) =>
                  AuthBloc(loginUseCase, logoutUseCase),
              child: LoginScreen(),
            ),
        '/home': (context) => HomeScreen(),
      },
      initialRoute: '/login',
    );
  }
}
