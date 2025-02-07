import '../repositories/hospital_repository.dart';

class SendRequestUseCase {
  final HospitalRepository repository;

  SendRequestUseCase({required this.repository});

  Future<void> execute(int hospitalId, String details) async {
    return await repository.sendRequest(hospitalId, details);
  }
}