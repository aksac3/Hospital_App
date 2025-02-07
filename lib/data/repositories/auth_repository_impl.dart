import 'package:flutter_application_1/domain/repositories/auth_repository.dart';
import 'package:flutter_application_1/domain/entities/token.dart';
import 'package:flutter_application_1/data/datasources/auth_remote_data_source.dart';
import 'package:flutter_application_1/data/models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Token?> login(String username, String password) async {
    try {
      final user = UserModel(username: username, password: password);
      final tokenModel = await remoteDataSource.login(user);

      if (tokenModel != null) {
        return tokenModel.toEntity();
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error en el login: $e');
    }
  }
}