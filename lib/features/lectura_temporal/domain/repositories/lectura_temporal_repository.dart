import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/lectura_temporal.dart';

abstract class LecturaTemporalRepository {
  Future<Either<Failure, List<LecturaTemporal>>> getLecturas();
  Future<Either<Failure, LecturaTemporal>> getLecturaById(String id);
  Future<Either<Failure, void>> saveLectura(LecturaTemporal lectura);
  Future<Either<Failure, void>> deleteLectura(String id);
  Future<Either<Failure, List<LecturaTemporal>>> getLecturasByCategoria(
    String categoria,
  );
}
