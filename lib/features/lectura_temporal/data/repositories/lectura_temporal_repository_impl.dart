import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/lectura_temporal.dart';
import '../../domain/repositories/lectura_temporal_repository.dart';
import '../datasources/lectura_temporal_local_datasource.dart';
import '../datasources/lectura_temporal_remote_datasource.dart';
import '../models/lectura_temporal_model.dart';

class LecturaTemporalRepositoryImpl implements LecturaTemporalRepository {
  final LecturaTemporalRemoteDataSource remoteDataSource;
  final LecturaTempralLocalDataSource localDataSource;

  LecturaTemporalRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<LecturaTemporal>>> getLecturas() async {
    try {
      // Por ahora usar solo datos locales para demo
      final cachedLecturas = await localDataSource.getCachedLecturas();
      return Right(cachedLecturas);
    } catch (e) {
      return Left(CacheFailure('Error al obtener datos: $e'));
    }
  }

  @override
  Future<Either<Failure, LecturaTemporal>> getLecturaById(String id) async {
    try {
      final lectura = await remoteDataSource.getLecturaById(id);
      await localDataSource.cacheLectura(lectura);
      return Right(lectura);
    } catch (e) {
      try {
        final cachedLectura = await localDataSource.getCachedLectura(id);
        if (cachedLectura != null) {
          return Right(cachedLectura);
        } else {
          return Left(CacheFailure('Lectura no encontrada'));
        }
      } catch (cacheError) {
        return Left(ServerFailure('Error al obtener lectura: $e'));
      }
    }
  }

  @override
  Future<Either<Failure, void>> saveLectura(LecturaTemporal lectura) async {
    try {
      final model = LecturaTemporalModel.fromEntity(lectura);
      await remoteDataSource.saveLectura(model);
      await localDataSource.cacheLectura(model);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Error al guardar lectura: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteLectura(String id) async {
    try {
      await remoteDataSource.deleteLectura(id);
      await localDataSource.deleteCachedLectura(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Error al eliminar lectura: $e'));
    }
  }

  @override
  Future<Either<Failure, List<LecturaTemporal>>> getLecturasByCategoria(
    String categoria,
  ) async {
    try {
      final lecturas = await localDataSource.getCachedLecturas();
      final filteredLecturas = lecturas
          .where((lectura) => lectura.categoria == categoria)
          .toList();
      return Right(filteredLecturas);
    } catch (e) {
      return Left(ServerFailure('Error al obtener lecturas por categoría: $e'));
    }
  }
}
