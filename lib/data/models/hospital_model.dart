import 'package:flutter_application_1/domain/entities/hospital.dart';

class HospitalModel {
  final String id;
  final String name;
  final String address;
  final String telefono;
  final String horario;

  HospitalModel({
    required this.id,
    required this.name,
    required this.address,
    required this.telefono,
    required this.horario

  });

  factory HospitalModel.fromJson(Map<String, dynamic> json) {
  return HospitalModel(
    id: json['_id'],
    name: json['name'],
    address: json['direccion'],
    telefono: json['telefono'],
    horario: json['horario'], 
  );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'name': name,
    'address': address,
  };

  Hospital toEntity() {
    return Hospital(
      id: id,
      name: name,
      address: address,
    );
  }
}