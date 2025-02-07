import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/local/local_storage.dart'; 

// Eventos
abstract class AuthEvent {}
class CheckAuth extends AuthEvent {} 
class LoginButtonPressed extends AuthEvent {
  final String username;
  final String password;
  LoginButtonPressed({required this.username, required this.password});
}
class LogoutButtonPressed extends AuthEvent {}

// Estados
abstract class AuthState {}
class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthAuthenticated extends AuthState {}
class AuthUnauthenticated extends AuthState {}
class AuthError extends AuthState {
  final String error;
  AuthError({required this.error});
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LocalStorage localStorage;

  AuthBloc({required this.localStorage}) : super(AuthInitial()) {
    on<CheckAuth>((event, emit) async {
      final token = await localStorage.getToken();
      if (token != null) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthUnauthenticated());
      }
    });

    on<LoginButtonPressed>((event, emit) async {
      emit(AuthLoading());
      try {
        final token = await localStorage.getToken(); 
        if (token != null) {
          emit(AuthAuthenticated());
        } else {
          emit(AuthUnauthenticated());
        }

      } catch (e) {
        emit(AuthError(error: e.toString()));
      }
    });

    on<LogoutButtonPressed>((event, emit) async {
      await localStorage.clearToken();
      emit(AuthUnauthenticated());
    });
  }
}