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

// Barcode Scanner imports
import '../../features/barcode_scanner/data/datasources/barcode_scanner_camera_datasource.dart';
import '../../features/barcode_scanner/data/datasources/barcode_scanner_local_datasource.dart';
import '../../features/barcode_scanner/data/repositories/barcode_scanner_repository_impl.dart';
import '../../features/barcode_scanner/domain/repositories/barcode_scanner_repository.dart';
import '../../features/barcode_scanner/domain/usecases/scan_barcode.dart';
import '../../features/barcode_scanner/domain/usecases/get_product_info.dart';
import '../../features/barcode_scanner/domain/usecases/get_historial_escaneos.dart';
import '../../features/barcode_scanner/presentation/bloc/barcode_scanner_bloc.dart';

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

  // Barcode Scanner Dependencies
  // Data sources
  sl.registerLazySingleton<BarcodeScannerCameraDataSource>(
    () => BarcodeScannerCameraDataSourceImpl(),
  );

  sl.registerLazySingleton<BarcodeScannerLocalDataSource>(
    () => BarcodeScannerLocalDataSourceImpl(),
  );

  // Repository
  sl.registerLazySingleton<BarcodeScannerRepository>(
    () => BarcodeScannerRepositoryImpl(
      cameraDataSource: sl(),
      localDataSource: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => ScanBarcode(sl()));
  sl.registerLazySingleton(() => GetProductInfo(sl()));
  sl.registerLazySingleton(() => GetHistorialEscaneos(sl()));

  // Bloc
  sl.registerFactory(
    () => BarcodeScannerBloc(
      scanBarcode: sl(),
      getProductInfo: sl(),
      getHistorialEscaneos: sl(),
      repository: sl(),
    ),
  );
}
