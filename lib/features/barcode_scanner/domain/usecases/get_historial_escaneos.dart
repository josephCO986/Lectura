import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/producto_escaneado.dart';
import '../repositories/barcode_scanner_repository.dart';

class GetHistorialEscaneos {
  final BarcodeScannerRepository repository;

  GetHistorialEscaneos(this.repository);

  Future<Either<Failure, List<ProductoEscaneado>>> call() async {
    return await repository.getHistorialEscaneos();
  }
}
