import 'package:flutter_bloc/flutter_bloc.dart';
import 'hospital_event.dart';
import 'hospital_state.dart';
import '../../domain/repositories/hospital_repository.dart';

class HospitalBloc extends Bloc<HospitalEvent, HospitalState> {
  final HospitalRepository hospitalRepository;

  HospitalBloc({required this.hospitalRepository}) : super(HospitalInitial()) {
    on<FetchHospitals>((event, emit) async {
      emit(HospitalLoading());
      try {
        final hospitals = await hospitalRepository.getHospitals();
        emit(HospitalLoaded(hospitals: hospitals));
      } catch (e) {
        emit(HospitalError(message: e.toString()));
      }
    });

    on<SendRequest>((event, emit) async {
      emit(HospitalLoading());
      try {
        int hospitalId;
        try {
          hospitalId = int.parse(event.hospitalId); 
        } on FormatException {
          emit(HospitalError(message: 'ID de hospital inválido'));
          return; 
        }

        await hospitalRepository.sendRequest(hospitalId, event.details);
        emit(RequestSent());
      } catch (e) {
        emit(HospitalError(message: e.toString()));
      }
    });
  }
}