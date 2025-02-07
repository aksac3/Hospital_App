import '../../domain/entities/hospital.dart';

abstract class HospitalState {}

class HospitalInitial extends HospitalState {}

class HospitalLoading extends HospitalState {}

class HospitalLoaded extends HospitalState {
  final List<Hospital> hospitals;

  HospitalLoaded({required this.hospitals});
}

class HospitalError extends HospitalState {
  final String message;

  HospitalError({required this.message});
}

class RequestSent extends HospitalState {}