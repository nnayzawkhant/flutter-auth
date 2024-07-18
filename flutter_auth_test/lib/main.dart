import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/services/auth_service.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/usecases/login_usecase.dart';
import 'presentation/bloc/login_bloc.dart';
import 'presentation/screens/login_screen.dart';

void main() {
  final dio = Dio();
  final authService = AuthService(dio);
  final authRepository = AuthRepositoryImpl(authService: authService);
  final loginUseCase = LoginUseCase(authRepository: authRepository);

  runApp(MyApp(loginUseCase: loginUseCase));
}

class MyApp extends StatelessWidget {
  final LoginUseCase loginUseCase;

  MyApp({required this.loginUseCase});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Clean Architecture',
      home: BlocProvider(
        create: (context) => LoginBloc(loginUseCase: loginUseCase),
        child: LoginScreen(),
      ),
    );
  }
}
