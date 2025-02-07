import 'package:flutter_application_1/domain/repositories/hospital_repository.dart';
import 'package:flutter_application_1/domain/entities/hospital.dart';
import 'package:flutter_application_1/data/datasources/hospital_remote_data_source.dart';
import 'package:flutter_application_1/data/local/local_storage.dart';

class HospitalRepositoryImpl implements HospitalRepository {
  final HospitalRemoteDataSource remoteDataSource;
  final LocalStorage localStorage;

  HospitalRepositoryImpl({
    required this.remoteDataSource,
    required this.localStorage,
  });

  @override
  Future<List<Hospital>> getHospitals() async {
    final hospitalModels = await remoteDataSource.getHospitals();
    return hospitalModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> sendRequest(int hospitalId, String details) async {
    try {
      await remoteDataSource.sendRequest(hospitalId, details);
    } catch (e) {
      rethrow;
    }
  }
}