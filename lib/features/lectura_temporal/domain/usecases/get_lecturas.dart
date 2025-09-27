import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/lectura_temporal.dart';
import '../repositories/lectura_temporal_repository.dart';

class GetLecturas {
  final LecturaTemporalRepository repository;

  GetLecturas(this.repository);

  Future<Either<Failure, List<LecturaTemporal>>> call() async {
    return await repository.getLecturas();
  }
}
