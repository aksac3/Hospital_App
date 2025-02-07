import 'package:flutter_application_1/domain/entities/hospital.dart';

abstract class HospitalRepository {
  Future<List<Hospital>> getHospitals();
  Future<void> sendRequest(int hospitalId, String details); 
}