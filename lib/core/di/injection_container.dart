import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

import '../../features/lectura_temporal/data/datasources/lectura_temporal_local_datasource.dart';
import '../../features/lectura_temporal/data/datasources/lectura_temporal_remote_datasource.dart';
import '../../features/lectura_temporal/data/repositories/lectura_temporal_repository_impl.dart';
import '../../features/lectura_temporal/domain/repositories/lectura_temporal_repository.dart';
import '../../features/lectura_temporal/domain/usecases/get_lecturas.dart';
import '../../features/lectura_temporal/domain/usecases/save_lectura.dart';
import '../../features/lectura_temporal/presentation/bloc/lectura_temporal_bloc.dart';

final sl = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);

  sl.registerLazySingleton(() => Dio());

  // Data sources
  sl.registerLazySingleton<LecturaTempralLocalDataSource>(
    () => LecturaTemporalLocalDataSourceImpl(),
  );

  sl.registerLazySingleton<LecturaTemporalRemoteDataSource>(
    () => LecturaTemporalRemoteDataSourceImpl(sl()),
  );

  // Repository
  sl.registerLazySingleton<LecturaTemporalRepository>(
    () => LecturaTemporalRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => GetLecturas(sl()));
  sl.registerLazySingleton(() => SaveLectura(sl()));

  // Bloc
  sl.registerFactory(
    () => LecturaTemporalBloc(getLecturas: sl(), saveLectura: sl()),
  );
}
