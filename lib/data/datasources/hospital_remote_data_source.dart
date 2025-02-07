import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/hospital_model.dart';

class HospitalRemoteDataSource {
  final http.Client client;

  HospitalRemoteDataSource({required this.client});

  Future<List<HospitalModel>> getHospitals() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      throw Exception('Token no encontrado. Debes iniciar sesión.');
    }

    final uri = Uri.parse('https://meddi-training.vercel.app/api/v1/hospital/get/all').replace(
      queryParameters: {
        'page': '1',
        'rowsPerPage': '10',
        'lat': '20.7244704',
        'long': '-103.397476',
        'estadoCode': 'JC',
      },
    );

    final response = await client.get(
      uri,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print('Cuerpo de la respuesta (sin decodificar): ${response.body}');
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      final List<dynamic> hospitalsJson = jsonResponse['data']['data'] ?? [];
      return hospitalsJson.map((json) => HospitalModel.fromJson(json)).toList();
    } else {
      print('Error en la solicitud: ${response.statusCode}, ${response.body}');
      throw Exception(
        'Error al cargar hospitales. Código: ${response.statusCode}, Respuesta: ${response.body}',
      );
    }
  }

  Future<void> sendRequest(int hospitalId, String details) async {
  }
}