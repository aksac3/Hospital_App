import 'dart:convert';
import 'package:http/http.dart' as http;
import '../local/local_storage.dart';

class SolicitudRemoteDataSource {
  final http.Client client;
  final LocalStorage localStorage;

  SolicitudRemoteDataSource({required this.client, required this.localStorage});

  Future<void> createSolicitud(Map<String, dynamic> solicitudData) async {
    final token = localStorage.getToken();
    if (token == null) {
      throw Exception('Token no encontrado. Debes iniciar sesión.');
    }

    final url = Uri.parse('https://meddi-training.vercel.app/api/v1/solicitud/create'); 

    try {
      final response = await client.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json', 
        },
        body: jsonEncode(solicitudData), 
      );

      if (response.statusCode == 201) {
        print('Solicitud creada correctamente');
      } else {
        print('Error al crear solicitud: ${response.statusCode}, ${response.body}'); 
        throw Exception('Failed to create solicitud: ${response.statusCode}, ${response.body}');
      }
    } catch (e) {
      print('Error en la solicitud: $e'); 
      rethrow; 
    }
  }
}