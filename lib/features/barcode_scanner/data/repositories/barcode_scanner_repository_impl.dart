import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/producto_escaneado.dart';
import '../../domain/repositories/barcode_scanner_repository.dart';
import '../datasources/barcode_scanner_local_datasource.dart';
import '../datasources/barcode_scanner_camera_datasource.dart';
import '../models/producto_escaneado_model.dart';

class BarcodeScannerRepositoryImpl implements BarcodeScannerRepository {
  final BarcodeScannerLocalDataSource localDataSource;
  final BarcodeScannerCameraDataSource cameraDataSource;

  BarcodeScannerRepositoryImpl({
    required this.localDataSource,
    required this.cameraDataSource,
  });

  @override
  Future<Either<Failure, String>> scanBarcode() async {
    try {
      // Verificar permisos de cámara
      final hasPermission = await cameraDataSource.checkCameraPermission();
      if (!hasPermission) {
        final granted = await cameraDataSource.requestCameraPermission();
        if (!granted) {
          return Left(ValidationFailure('Permisos de cámara requeridos'));
        }
      }

      // Por ahora usar simulación para testing
      final codigo = await _simulateBarcodeScan();

      if (codigo.isEmpty) {
        return Left(ValidationFailure('No se pudo leer el código'));
      }

      return Right(codigo);
    } catch (e) {
      return Left(ServerFailure('Error al escanear código: $e'));
    }
  }

  @override
  Future<Either<Failure, ProductoEscaneado>> getProductInfo(
    String codigo,
  ) async {
    try {
      // Buscar en datos locales primero
      final producto = await localDataSource.getProductoPorCodigo(codigo);

      if (producto != null) {
        return Right(producto);
      }

      // Si no está en local, crear uno básico desde el código
      final productoBasico = ProductoEscaneadoModel.fromCode(
        codigo: codigo,
        tipoEscaneo: 'CODE128', // Asumir CODE128 por defecto
      );

      return Right(productoBasico);
    } catch (e) {
      return Left(
        ServerFailure('Error al obtener información del producto: $e'),
      );
    }
  }

  @override
  Future<Either<Failure, List<ProductoEscaneado>>>
  getHistorialEscaneos() async {
    try {
      final historial = await localDataSource.getHistorialEscaneos();
      return Right(historial);
    } catch (e) {
      return Left(CacheFailure('Error al obtener historial: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> guardarEscaneo(
    ProductoEscaneado producto,
  ) async {
    try {
      final model = ProductoEscaneadoModel.fromEntity(producto);
      await localDataSource.guardarEscaneo(model);
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Error al guardar escaneo: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> exportarHistorial() async {
    try {
      // Implementación futura: exportar a Excel/CSV
      await Future.delayed(const Duration(seconds: 1));
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Error al exportar historial: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> limpiarHistorial() async {
    try {
      await localDataSource.limpiarHistorial();
      return const Right(null);
    } catch (e) {
      return Left(CacheFailure('Error al limpiar historial: $e'));
    }
  }

  // Método temporal para simular escaneo
  Future<String> _simulateBarcodeScan() async {
    await Future.delayed(const Duration(seconds: 2));

    final codigos = [
      'MP-PALLM000030',
      'MP-PALLM000038',
      'MP-PALLM000043',
      'MP-PBOPP000393',
    ];

    final random = DateTime.now().millisecondsSinceEpoch % codigos.length;
    return codigos[random];
  }
}
