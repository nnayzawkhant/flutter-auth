import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/login_request.dart';
import '../../domain/entities/login_response.dart';
import '../../domain/usecases/login_usecase.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      try {
        final response = await loginUseCase(LoginRequest(
          email: event.email,
          password: event.password,
        ));
        print(response);
        emit(LoginSuccess(response: response));
      } catch (error) {
        print(error);
        emit(LoginFailure(error: error.toString()));
      }
    });
  }
}
