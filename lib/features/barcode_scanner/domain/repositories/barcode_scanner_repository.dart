import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/producto_escaneado.dart';

abstract class BarcodeScannerRepository {
  Future<Either<Failure, String>> scanBarcode();
  Future<Either<Failure, ProductoEscaneado>> getProductInfo(String codigo);
  Future<Either<Failure, List<ProductoEscaneado>>> getHistorialEscaneos();
  Future<Either<Failure, void>> guardarEscaneo(ProductoEscaneado producto);
  Future<Either<Failure, void>> exportarHistorial();
  Future<Either<Failure, void>> limpiarHistorial();
}
