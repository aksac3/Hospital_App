import '../entities/hospital.dart';
import '../repositories/hospital_repository.dart';

class GetHospitalsUseCase {
  final HospitalRepository repository;

  GetHospitalsUseCase({required this.repository});

  Future<List<Hospital>> execute() async {
    return await repository.getHospitals();
  }
}
