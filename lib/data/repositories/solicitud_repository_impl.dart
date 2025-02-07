import '../../domain/repositories/solicitud_repository.dart';
import '../datasources/solicitud_remote_data_source.dart';

class SolicitudRepositoryImpl implements SolicitudRepository {
  final SolicitudRemoteDataSource remoteDataSource;

  SolicitudRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> createSolicitud(Map<String, dynamic> solicitudData) async {
    try {
      await remoteDataSource.createSolicitud(solicitudData);
    } catch (e) {
      print('Error en el repositorio: $e'); 
      rethrow;
    }
  }
}