import 'package:flutter/material.dart';
import 'package:flutter_application_1/domain/entities/hospital.dart';

class HospitalDetailPage extends StatelessWidget {
  final Hospital hospital;

  const HospitalDetailPage({Key? key, required this.hospital}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hospital.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              hospital.name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              hospital.address,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text('Teléfono: ${hospital.telefono ?? "No disponible"}'), 
            const SizedBox(height: 8),
            Text('Horario: ${hospital.horario ?? "No disponible"}'),
            const SizedBox(height: 8),

            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/create_request', arguments: hospital.id);
              },
              child: const Text('Enviar solicitud'),
            ),
          ],
        ),
      ),
    );
  }
}