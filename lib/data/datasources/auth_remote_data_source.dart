import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application_1/data/models/user_model.dart';
import 'package:flutter_application_1/data/models/token_model.dart';

const String baseUrl = 'https://meddi-training.vercel.app/api/v1';

class AuthRemoteDataSource {
  final http.Client client;

  AuthRemoteDataSource({required this.client});

 Future<TokenModel?> login(UserModel user) async {
    try {
      final url = Uri.parse('$baseUrl/user/login');

      print('Enviando solicitud POST a: $url');

      final response = await client.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );

      print('Código de estado de la respuesta: ${response.statusCode}');

      print('Cuerpo de la respuesta (sin decodificar): ${response.body}'); 

      if (response.statusCode == 200) {
        try { 
          final data = jsonDecode(response.body);
          print('Datos decodificados: $data'); 

          final tokenValue = data['data']['jwtToken']; 

          if (tokenValue != null) {
            return TokenModel(token: tokenValue, expiresIn: 0);
          } else {
            print('Error: jwtToken es nulo en la respuesta.');
            return null;
          }
        } catch (e) {
          print('Error al decodificar JSON o acceder a jwtToken: $e');
          return null;
        }
      } else {
        print('Error en el login: ${response.statusCode}, ${response.body}');
        throw Exception('Error en el login: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error en el login (excepción): $e');
      throw Exception('Error en el login: $e');
    }
  }
}