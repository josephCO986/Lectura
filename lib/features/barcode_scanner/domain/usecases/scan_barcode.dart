import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/barcode_scanner_repository.dart';

class ScanBarcode {
  final BarcodeScannerRepository repository;

  ScanBarcode(this.repository);

  Future<Either<Failure, String>> call() async {
    return await repository.scanBarcode();
  }
}
