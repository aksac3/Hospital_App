import 'package:flutter_application_1/domain/entities/token.dart';

abstract class AuthRepository {
  Future<Token?> login(String username, String password); 
}