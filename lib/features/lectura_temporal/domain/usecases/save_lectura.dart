import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/lectura_temporal.dart';
import '../repositories/lectura_temporal_repository.dart';

class SaveLectura {
  final LecturaTemporalRepository repository;

  SaveLectura(this.repository);

  Future<Either<Failure, void>> call(LecturaTemporal lectura) async {
    return await repository.saveLectura(lectura);
  }
}
