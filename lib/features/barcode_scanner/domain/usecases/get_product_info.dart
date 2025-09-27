import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/producto_escaneado.dart';
import '../repositories/barcode_scanner_repository.dart';

class GetProductInfo {
  final BarcodeScannerRepository repository;

  GetProductInfo(this.repository);

  Future<Either<Failure, ProductoEscaneado>> call(String codigo) async {
    return await repository.getProductInfo(codigo);
  }
}
