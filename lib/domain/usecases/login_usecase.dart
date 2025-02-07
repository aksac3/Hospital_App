import '../repositories/auth_repository.dart';
import '../../domain/entities/token.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  Future<Token?> execute(String username, String password) async { 
    return await authRepository.login(username, password); 
  }
}
