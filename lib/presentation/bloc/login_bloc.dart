import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/domain/usecases/login_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(LoginInitial()) {
    on<LoginButtonPressed>((event, emit) async {
      emit(LoginLoading());
      print('Estado: LoginLoading');
      try {
        final token = await loginUseCase.execute(event.username, event.password);
        if (token != null) {
          emit(LoginSuccess(token: token.value));
          print('Estado: LoginSuccess');
        } else {
          emit(LoginError(error: 'Credenciales incorrectas'));
          print('Estado: LoginError - Credenciales incorrectas');
        }
      } catch (e) {
        emit(LoginError(error: e.toString()));
        print('Estado: LoginError - ${e.toString()}');
      }
    });
  }
}