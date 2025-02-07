abstract class HospitalEvent {}

class FetchHospitals extends HospitalEvent {}

class SendRequest extends HospitalEvent {
  final String hospitalId;
  final String details;

  SendRequest({required this.hospitalId, required this.details});
}