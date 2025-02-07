import 'package:flutter_application_1/domain/entities/token.dart';

class TokenModel {
  final String token;
  final int expiresIn;

  TokenModel({required this.token, required this.expiresIn});

factory TokenModel.fromJson(Map<String, dynamic> json) {
  print('Tipo de json: ${json.runtimeType}'); 
  return TokenModel(
    token: json['jwtToken'],
    expiresIn: json['expiresIn'] ?? 0,
  );
}

  Token toEntity() {
    return Token(value: token); 
  }
}