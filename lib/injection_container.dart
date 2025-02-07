import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'data/repositories/hospital_repository_impl.dart';
import 'domain/repositories/hospital_repository.dart';
import 'data/datasources/hospital_remote_data_source.dart';
import 'data/local/local_storage.dart';
import 'domain/usecases/login_usecase.dart';
import 'presentation/bloc/login_bloc.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/repositories/auth_repository.dart';
import 'data/datasources/auth_remote_data_source.dart';
import 'presentation/bloc/hospital_bloc.dart'; 

final sl = GetIt.instance;

Future<void> init() async {
  // External dependencies
  sl.registerLazySingleton<http.Client>(() => http.Client()); 

  // SharedPreferences
  final prefs = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => prefs);

  // Local Storage
  sl.registerLazySingleton<LocalStorage>(() => LocalStorage(prefs: sl<SharedPreferences>())); 

  // Data sources
  sl.registerLazySingleton<HospitalRemoteDataSource>(() =>
      HospitalRemoteDataSource(client: sl<http.Client>())); 

  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(client: sl<http.Client>())); 

  // Repositories
  sl.registerLazySingleton<HospitalRepository>(() =>
      HospitalRepositoryImpl(
          remoteDataSource: sl<HospitalRemoteDataSource>(),
          localStorage: sl<LocalStorage>())); 

  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: sl<AuthRemoteDataSource>())); 

  // Use cases
  sl.registerLazySingleton<LoginUseCase>(() => LoginUseCase(authRepository: sl<AuthRepository>())); 

  // Blocs
  sl.registerFactory<HospitalBloc>(() =>
      HospitalBloc(hospitalRepository: sl<HospitalRepository>())); 

  sl.registerFactory<LoginBloc>(() => LoginBloc(loginUseCase: sl<LoginUseCase>())); 
}